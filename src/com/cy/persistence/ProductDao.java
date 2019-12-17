package com.cy.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cy.domain.ProductVo;

public class ProductDao {
	private static ProductDao instance;
	private ProductDao(){ /* singleton */ };
	
	public static ProductDao getInstance(){
		if( instance == null ){
			instance = new ProductDao();
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
	
	//main page, 제품 전체 조회
	public List<ProductVo> getList(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from tbl_product p, tbl_category c "
								 + " where p.category_code = c.category_code "
								 + " order by product_num desc, product_reg_date desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
					
			List<ProductVo> list = new ArrayList<>();
			
			while(rs.next()){
				ProductVo vo = new ProductVo();
				vo.setProduct_num(rs.getInt("product_num"));
				vo.setProduct_name(rs.getString("product_name"));
				vo.setCategory_code(rs.getString("category_code"));
				vo.setCategory_name(rs.getString("category_name"));
				vo.setProduct_price(rs.getInt("product_price"));
				vo.setProduct_content(rs.getString("product_content"));
				vo.setProduct_img(rs.getString("product_img"));
				vo.setProduct_stock(rs.getInt("product_stock"));
				vo.setProduct_reg_date(rs.getTimestamp("product_reg_date"));
				
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} 
		return null;
	}
	
	//해당 카테고리에 대한 제품들만 전체 조회
	public List<ProductVo> getListByCategoryCode(String category_code){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from tbl_product p, tbl_category c "
								 + " where p.category_code = c.category_code "
								 + " and p.category_code = '" + category_code + "' "
								 + " order by product_num desc, product_reg_date desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
					
			List<ProductVo> list = new ArrayList<>();
			
			while(rs.next()){
				ProductVo vo = new ProductVo();
				vo.setProduct_num(rs.getInt("product_num"));
				vo.setProduct_name(rs.getString("product_name"));
				vo.setCategory_code(rs.getString("category_code"));
				vo.setCategory_name(rs.getString("category_name"));
				vo.setProduct_price(rs.getInt("product_price"));
				vo.setProduct_content(rs.getString("product_content"));
				vo.setProduct_img(rs.getString("product_img"));
				vo.setProduct_stock(rs.getInt("product_stock"));
				vo.setProduct_reg_date(rs.getTimestamp("product_reg_date"));
				
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} 
		return null;
	}
	
	//제품 번호로 제품정보 조회
	public ProductVo getProductInfoByProductNum(int product_num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from tbl_product where product_num = " + product_num;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ProductVo productVo = new ProductVo();
				productVo.setProduct_num(product_num);
				productVo.setProduct_name(rs.getString("product_name"));
				productVo.setProduct_content(rs.getString("product_content"));
				productVo.setProduct_price(rs.getInt("product_price"));
				productVo.setProduct_img(rs.getString("product_img"));
				productVo.setProduct_stock(rs.getInt("product_stock"));
				productVo.setProduct_reg_date(rs.getTimestamp("product_reg_date"));
				return productVo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} return null;
	}
	
	//제품 추가
	public boolean insertProduct(ProductVo vo){
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "insert into tbl_product "
									+ " (product_num, product_name, category_code, product_content, "
									+ " product_price, product_stock, product_img) "
									+ " values(seq_product_num.nextval, ?, ?, ?, "
									+ " ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getProduct_name());
			pstmt.setString(2, vo.getCategory_code());
			pstmt.setString(3, vo.getProduct_content());
			pstmt.setInt(4, vo.getProduct_price());
			pstmt.setInt(5, vo.getProduct_stock());
			pstmt.setString(6, vo.getProduct_img());
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
	
	//제품 수정
	public void updateProduct(ProductVo vo){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
//			product_num
//			product_name
//			category_code
//			product_content
//			product_price
//			product_img
//			product_stock
//			product_reg_date
			String sql = "update tbl_product set "
					+ " product_name = ?, "
					+ " product_content = ?, "
					+ " product_price = ?, "
					+ " product_stock = ? ";
			if(vo.getProduct_img()!=null && !vo.getProduct_img().equals("")){
					sql += ", product_img = '" + vo.getProduct_img() + "'"; 
			}
					sql += " where product_num = ?"; 
			pstmt = conn.prepareStatement(sql);
			
			int i = 0;
			pstmt.setString(++i, vo.getProduct_name());
			pstmt.setString(++i, vo.getProduct_content());
			pstmt.setInt(++i, vo.getProduct_price());
			pstmt.setInt(++i, vo.getProduct_stock());
			pstmt.setInt(++i, vo.getProduct_num());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		}
	}
	
	//제품 삭제
	public boolean deleteProduct(int product_num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "delete from tbl_product where product_num = " + product_num;
			pstmt = conn.prepareStatement(sql);
			int count = pstmt.executeUpdate();
			if(count > 0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		} return false;
	}
	
	//제품 삭제시 이미지 삭제를 위해 이미지 이름을 얻어옴
	public String getFileName(int product_num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select product_img from tbl_product where product_num = " + product_num;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String product_img = rs.getString("product_img");
				return product_img;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		} return null;
	}
}
