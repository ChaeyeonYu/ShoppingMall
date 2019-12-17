package com.cy.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cy.domain.UserVo;

public class UserDao {
	
	public static final int LOGIN_SUCCESS 	= 1;
	public static final int INCORRECT_PASSWD = 2;
	public static final int ID_NOT_FOUND 		= 3;
	
	private static UserDao instance;
	private UserDao(){ /* singleton */ };
	
	public static UserDao getInstance(){
		if( instance == null ){
			instance = new UserDao();
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
	
	//회원가입
	public boolean insertUser(UserVo vo){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into tbl_user(user_id, user_name, user_passwd) "
								   + " values(?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getUser_id());
			pstmt.setString(2, vo.getUser_name());
			pstmt.setString(3, vo.getUser_passwd());
			int count = pstmt.executeUpdate();
			if(count > 0){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		}
		return false;
	}
	
	//로그인 - 사용자 체크
	public int userCheck(String user_id, String user_passwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		System.out.println("userDao user_id: " + user_id);
		System.out.println("userDao user_passwd: " + user_passwd);
		
		try {
			conn = getConnection();
			String sql = "select user_passwd from tbl_user "
						+ " where user_id = '"  + user_id + "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String dbPasswd = rs.getString("user_passwd");
				if(user_passwd.equals(dbPasswd)) {
					// 인증 성공
					return LOGIN_SUCCESS;
				} else {
					// 비밀번호 불일치
					return INCORRECT_PASSWD;
				}
			} else {
				// 해당 아이디 없음
				return ID_NOT_FOUND;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}
		return 0;
	}
	
	
}
