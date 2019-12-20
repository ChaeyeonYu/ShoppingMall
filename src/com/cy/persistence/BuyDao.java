package com.cy.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cy.domain.BuyVo;
import com.cy.domain.CartVo;
import com.cy.domain.CategoryVo;
import com.cy.domain.UserVo;

public class BuyDao {
//	public static final int ORDER_FAIL = -1;
	private static BuyDao instance;
	private BuyDao(){ /* singleton */ };
	
	public static BuyDao getInstance(){
		if( instance == null ){
			instance = new BuyDao();
		}
		return instance;
	}
	
	private Connection getConnection(){
		try {
			Context initCtx = new InitialContext();
			DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/oraclexe");
			Connection conn = ds.getConnection();
			return conn;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private void closeAll(Connection conn, PreparedStatement pstmt, ResultSet rs){
		if (conn != null) try { conn.close(); } catch (Exception e) { }
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) { }
		if (rs != null) try { rs.close(); } catch (Exception e) { }
	}
	
	//재고 차감 후 
	//재고 검색
	//그 값이 0 이하인 것이 있다면 
	//rollback 후 false를 return
	public boolean updateStock(List<CartVo> list) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			
			String sql = "update tbl_product set product_stock = product_stock - ? where product_num = ?";
			int count = 0;
			for(CartVo vo : list) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(++count, vo.getProduct_count());
				pstmt.setInt(++count, vo.getProduct_num());
				pstmt.executeUpdate();
				count = 0;
			}
			
			String sql2 = "select count(*) cnt from tbl_product where product_num = ? and product_stock < 0";
			int count2 = 0;
			for(CartVo vo : list) {
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setInt(++count2, vo.getProduct_num());
				rs = pstmt2.executeQuery();
				count2 = 0;
				
				if(rs.next()) {
					int cnt = rs.getInt("cnt");
					if(cnt > 0) {
						return false;
					}
				}
			}
			
			conn.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			closeAll(null, pstmt, null);
			closeAll(conn, pstmt2, rs);
		} return false;
	}
	
	//재고 - 구매 할 개수 > 0이면 제품 테이블의 재고 수를 업데이트
	//아니면 결제취소 알림 보내기
	public boolean order(List<CartVo> list, Map<String, Object> paramMap) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			//재고 차감, 재고 검사
			boolean updateStockResult = updateStock(list);
			if(!updateStockResult) {
				return false;
			}
			
			System.out.println(list);
			System.out.println(paramMap);
			
			String sql = "insert all ";
			for(int i=0; i<list.size(); i++){
				sql	+= " into tbl_buy(buy_num, user_id, product_num, product_count, "
								   + " buy_date, user_address, user_tel, buy_receiver) "
					        + " values(seq_buy_num.nextval, ?, ?, ?, "
					        	   + " sysdate, ?, ?, ?) ";
			}	
				sql += " select * from dual";
			pstmt = conn.prepareStatement(sql);
			
			int count = 0;
			for(CartVo vo : list){
				pstmt.setString(++count, (String)paramMap.get("user_id"));
				pstmt.setInt(++count, vo.getProduct_num());
				pstmt.setInt(++count, vo.getProduct_count());
				pstmt.setString(++count, (String)paramMap.get("user_address"));
				pstmt.setString(++count, (String)paramMap.get("user_tel"));
				pstmt.setString(++count, (String)paramMap.get("buy_receiver"));
			}
			int result = pstmt.executeUpdate();
			if(result > 0){
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		} return false;
	}
	
	//주문성공시 장바구니 내역 비우기
	//CardDao에서 생성한 기능 이용
	
	//주문성공시 방금 주문한 내역 1개를 조회
	//주문번호인 마지막 시퀸스 값을 알아냄
	public int getBuyNum() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select SEQ_BUY_NUM.currval buy_num from dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int buy_num = rs.getInt("buy_num");
				return buy_num;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		} return 0;
	}
	
	//주문번호를 가지고 방금 주문한 내역만 조회
	public List<BuyVo> getOrder(String user_id, int buy_num){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from tbl_buy b, tbl_product p "
						+ " where b.product_num = p.product_num "
						+ " and user_id = ? and buy_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, buy_num);
			rs = pstmt.executeQuery();
			
			List<BuyVo> list = new ArrayList<>();
			
			while(rs.next()) {
				BuyVo vo = new BuyVo();
				vo.setBuy_num(buy_num);
				vo.setProduct_name(rs.getString("product_name"));
				vo.setProduct_num(rs.getInt("product_num"));
				vo.setProduct_img(rs.getString("product_img"));
				vo.setProduct_price(rs.getInt("product_price"));
				vo.setProduct_count(rs.getInt("product_count"));
				vo.setBuy_date(rs.getTimestamp("buy_date"));
				vo.setBuy_receiver(rs.getString("buy_receiver"));
				vo.setUser_tel(rs.getString("user_tel"));
				vo.setUser_address(rs.getString("user_address"));
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} return null;
	}
	
	//사용자의 주문내역 전체 조회
	//user_id = 로그인한 아이디
	public List<BuyVo> getOrderListAll(String user_id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from tbl_buy b, tbl_product p "
						+ " where b.product_num = p.product_num "
						+ " and user_id = '" + user_id + "'"
						+ " order by buy_num desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			List<BuyVo> list = new ArrayList<>();
			
			while(rs.next()) {
				BuyVo vo = new BuyVo();
				vo.setBuy_num(rs.getInt("buy_num"));
				vo.setProduct_name(rs.getString("product_name"));
				vo.setProduct_num(rs.getInt("product_num"));
				vo.setProduct_img(rs.getString("product_img"));
				vo.setProduct_price(rs.getInt("product_price"));
				vo.setProduct_count(rs.getInt("product_count"));
				
				vo.setBuy_date(rs.getTimestamp("buy_date"));
				vo.setBuy_receiver(rs.getString("buy_receiver"));
				vo.setUser_tel(rs.getString("user_tel"));
				vo.setUser_address(rs.getString("user_address"));
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} return null;
	}
	
	//관리자용 사용자 주문내역 조회
	public List<BuyVo> getOrderListAllAdmin(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from tbl_buy b, tbl_product p where b.product_num = p.product_num order by buy_num desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			List<BuyVo> list = new ArrayList<>();
			
			while(rs.next()) {
				BuyVo vo = new BuyVo();
				vo.setBuy_num(rs.getInt("buy_num"));
				vo.setProduct_name(rs.getString("product_name"));
				vo.setProduct_num(rs.getInt("product_num"));
				vo.setProduct_img(rs.getString("product_img"));
				vo.setProduct_price(rs.getInt("product_price"));
				vo.setProduct_count(rs.getInt("product_count"));
				
				vo.setBuy_date(rs.getTimestamp("buy_date"));
				vo.setBuy_receiver(rs.getString("buy_receiver"));
				vo.setUser_id(rs.getString("user_id"));
				vo.setUser_tel(rs.getString("user_tel"));
				vo.setUser_address(rs.getString("user_address"));
				
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} return null;
	}
	
	//tbl_user의 사용자 정보에 배송지 정보 추가
	public void updateUserAddress(Map<String, Object> paramMap){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "update tbl_user set user_address = ?, user_tel = ? "
						+ " where user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (String)paramMap.get("user_address"));
			pstmt.setString(2, (String)paramMap.get("user_tel"));
			pstmt.setString(3, (String)paramMap.get("user_id"));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		}
	}
	
}
