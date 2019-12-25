<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>

<script>
$(function(){
	//카테고리로 이동
	$("#btn_category").click(function(){
		location.href = "category.admin-cy";
	});
});
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<h1>admin_category_insert</h1>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br>

<!-- 카테고리 추가-->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
		<form method="post" action="category-insert-pro.admin-cy">
			<table class="table" >
				<tr>
					<th align="right">CATEGORY CODE*</th>
					<td><input type="text" style="width:100%;" name="category_code" 
							maxlength="10" placeholder="CATEGORY CODE*" required></td>
				</tr>
				<tr>
					<th>CATEGORY NAME*</th>
					<td><input type="text" style="width:100%;" name="category_name"
							maxlength="20" placeholder="CATEGORY NAME*" required></td>
				</tr>
				</table>
				
				<button type="submit" class="btn btn-lg btn-outline-secondary" id="btn_add_category">ADD CATEGORY</button>
				<button type="button" class="btn btn-lg btn-outline-secondary" id="btn_category">CANCEL</button>
		</form>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br>

<%@ include file="../include/footer.jsp" %>