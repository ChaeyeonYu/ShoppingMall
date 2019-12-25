package com.cy.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cy.domain.CartVo;

public class CartDao {
	
	private static CartDao instance;
	private CartDao(){ /* singleton */ };
	
	public static CartDao getInstance(){
		if( instance == null ){
			instance = new CartDao();
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
	
	//사용자 아이디와 일치하는 장바구니 목록 불러오기
	public List<CartVo> getCartList(String user_id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from tbl_cart c, tbl_product p, tbl_category pc "
							+ " where c.product_num = p.product_num "
							+ " and p.category_code = pc.category_code "
							+ " and user_id = '" + user_id + "' order by c.cart_num desc"; 
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			List<CartVo> list = new ArrayList<>();
			
			while(rs.next()){
				CartVo vo = new CartVo();
				vo.setCart_num(rs.getInt("cart_num"));
				vo.setProduct_num(rs.getInt("product_num"));
				vo.setProduct_name(rs.getString("product_name"));
				vo.setProduct_count(rs.getInt("product_count"));
				vo.setCategory_name(rs.getString("category_name"));
				vo.setProduct_img(rs.getString("product_img"));
				vo.setProduct_price(rs.getInt("product_price"));
				vo.setProduct_stock(rs.getInt("product_stock"));
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} return null;
	}
	
	
	//장바구니에 추가 전에 해당 제품이 장바구니에 있는지 확인
	public boolean isCart(int product_num, String user_id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) cnt from tbl_cart "
						+ " where product_num = ? and user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				int cnt = rs.getInt("cnt");
				if(cnt > 0){
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} return false;
	}
	
	//장바구니에 제품 추가하기
	public boolean insertCart(CartVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		//장바구니에 user_id가 구매한 product_num이 있는지 조회 후 
		//있으면 수량 update 
		//없으면 insert
		try {
			conn = getConnection();
			
			boolean result = isCart(vo.getProduct_num(), vo.getUser_id());
			if(result){
				String sql2 = "update tbl_cart set product_count = product_count + ? "
								+ " where product_num = ? and user_id = ?";
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, vo.getProduct_count());
				pstmt.setInt(2, vo.getProduct_num());
				pstmt.setString(3, vo.getUser_id());
			}else{
				String sql = "insert into tbl_cart(cart_num, user_id, product_num, product_count) "
									     + " values(seq_cart_num.nextval, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getUser_id());
				pstmt.setInt(2, vo.getProduct_num());
				pstmt.setInt(3, vo.getProduct_count());
			}
			
			int count = pstmt.executeUpdate();
			if(count > 0){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		} return false;
	}
	
	//장바구니 업데이트
	public void updateCart(Map<String, Object> paramMap){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "update tbl_cart set product_count = ? "
						+ " where cart_num = ? and user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int)paramMap.get("product_count"));
			pstmt.setInt(2, (int)paramMap.get("cart_num"));
			pstmt.setString(3, (String)paramMap.get("user_id"));
			int count = pstmt.executeUpdate();
//			if(count > 0) {
//				return true;
//			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		} 
//		return false;
	}
	
	
	//장바구니 제품 1개 삭제
	public boolean deleteCart(int cart_num, String user_id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "delete from tbl_cart where cart_num = ? and user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_num);
			pstmt.setString(2, user_id);
			int count = pstmt.executeUpdate();
			if(count > 0){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		} return false;
	}
	
	
	//장바구니 제품 전체 삭제
	public boolean deleteAllCart(String user_id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "delete from tbl_cart where user_id = '" + user_id + "'";
			pstmt = conn.prepareStatement(sql);
			int count = pstmt.executeUpdate();
			if(count > 0){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		} return false;
	}
	
	
}
