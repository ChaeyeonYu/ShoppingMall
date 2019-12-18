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
	
	//재고가 충분한지 검사 후 
	
	
	//재고 - 구매 할 개수 > 0이면 제품 테이블의 재고 수를 업데이트
	//아니면 결제취소 알림 보내기
	public boolean order(List<CartVo> list, Map<String, Object> paramMap) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
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
	
	//주문성공시 주문내역 확인하기(방금 주문한 내역 1개만)
	
	
	//사용자의 주문내역 전체 조회
	
	
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
