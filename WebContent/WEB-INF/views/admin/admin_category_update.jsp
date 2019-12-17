<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>

<script>
$(function(){
});
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<h1>admin_category_update</h1>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br>

<!-- 카테고리 수정-->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
		<form method="post" action="category-update-pro.admin-cy">
		<input type="hidden" name = "category_code" value="${vo.category_code}" />
			<table class="table" >
				<tr>
					<th align="right">CATEGORY CODE*</th>
					<td>${vo.category_code}</td>
				</tr>
				<tr>
					<th>CATEGORY NAME*</th>
					<td><input type="text" style="width:100%;" name="category_name"
							maxlength="20" value="${vo.category_name}" required></td>
				</tr>
				</table>
				
				<button type="submit" class="btn btn-lg btn-outline-secondary" id="btn_add_category">UPDATE CATEGORY</button>
		</form>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br>

<%@ include file="../include/footer.jsp" %>