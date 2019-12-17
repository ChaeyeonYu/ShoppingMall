package com.cy.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cy.domain.CategoryVo;
import com.cy.domain.UserVo;

import oracle.net.aso.p;

public class CategoryDao {
	
	private static CategoryDao instance;
	private CategoryDao(){ /* singleton */ };
	
	public static CategoryDao getInstance(){
		if( instance == null ){
			instance = new CategoryDao();
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
	
	//카테고리 전체 조회
	public List<CategoryVo> readCategory(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from tbl_category order by category_code asc, category_name asc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			List<CategoryVo> list = new ArrayList<>();
			
			while(rs.next()){
				CategoryVo vo = new CategoryVo();
				vo.setCategory_code(rs.getString("category_code"));
				vo.setCategory_name(rs.getString("category_name"));
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} return null;
	}
	
	//카테고리 추가
	public boolean insertCategory(CategoryVo vo){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into tbl_category values(?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getCategory_code());
			pstmt.setString(2, vo.getCategory_name());
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
	
	//카테고리 수정
	public boolean updateCategory(CategoryVo vo){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "update tbl_category "
						+ " set category_name = ? "
						+ " where category_code = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getCategory_name());
			pstmt.setString(2, vo.getCategory_code());
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
	
	//카테고리 삭제
	//삭제시 해당 카테고리의 제품들도 삭제하기 @@@@@@@@@@@
	public boolean deleteCategory(String category_code){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "delete from tbl_category "
						+ " where category_code = '" + category_code + "'";
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
	
	//카테고리 코드로 카테고리 이름 조회
	public String getCategoryName(String category_code){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select category_name from tbl_category "
						+ " where category_code = '" + category_code + "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				String category_name = rs.getString(1);
				return category_name;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} return null;
	}
}
