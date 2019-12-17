<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>    


<script>
$(function(){
	
	//숫자만 입력할 수 있도록 설정
	$("input[name=product_price]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	$("input[name=product_stock]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	
	//카테고리로 이동
	$("#btn_category").click(function(){
		location.href = "category.admin-cy";
	});
	
// 	$("#product_insert_form")

});
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<h1>product_insert</h1>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br>

<!-- 해당카테고리에 새로운 제품 추가하기 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
		<form method="post" action="product-insert-pro.admin-cy" enctype="multipart/form-data">
			<input type="hidden" name="category_code" value="${categoryVo.category_code}"/>
			<table class="table" >
				<tr>
					<th align="right">CATEGORY CODE*</th>
					<td>${categoryVo.category_code}</td>
				</tr>
				<tr>
					<th align="right">CATEGORY NAME*</th>
					<td>${categoryVo.category_name}</td>
				</tr>
				<tr>
					<th align="right">PRODUCT NAME*</th>
					<td><input type="text" style="width:100%;" name="product_name" 
							maxlength="20" placeholder="PRODUCT NAME*" required/></td>
				</tr>
				<tr>
					<th align="right">PRODUCT PRICE*</th>
					<td><input type="text" style="width:100%;" name="product_price" 
							maxlength="7" placeholder="PRODUCT PRICE*" required/></td>
				</tr>
				<tr>
					<th align="right">PRODUCT_STOCK</th>
					<td><input type="text" style="width:100%;" name="product_stock" 
							maxlength="7" placeholder="PRODUCT_STOCK"/></td>
				</tr>
				<tr>
					<th align="right">PRODUCT_CONTENT</th>
					<td><textarea rows="10" cols="50" name="product_content" placeholder="PRODUCT_CONTENT"
						 style="width:100%;" maxlength="350" ></textarea></td>
				</tr>
				<tr>
					<th align="right">PRODUCT_IMG</th>
					<td><input type="file" style="width:100%;" name="product_img"></td>
				</tr>
				</table>
				
				<button type="submit" class="btn btn-lg btn-outline-secondary" id="btn_add_product">ADD PRODUCT</button>
				<button type="button" class="btn btn-lg btn-outline-secondary" id="btn_category">CATEGORY</button>
		</form>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>



<br><br>

<%@ include file="../include/footer.jsp" %>