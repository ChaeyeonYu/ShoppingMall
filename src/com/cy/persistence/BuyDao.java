package com.cy.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cy.domain.CartVo;
import com.cy.domain.CategoryVo;
import com.cy.domain.UserVo;

public class BuyDao {
	
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
	
	//재고가 충분한지 검사
	
	public boolean order(List<CartVo> list) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			String sql = "insert all ";
			
				sql	+= " into tbl_test(buy_num, user_id, product_num, product_count, "
								   + " buy_date, user_address, user_tel) "
					        + " values(seq_buy_num.nextval, ?, ?, ?, "
					        	   + " sysdate, ?, ?) ";
				
				sql += " select * from dual";
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		} return false;
	}
	
	
}
