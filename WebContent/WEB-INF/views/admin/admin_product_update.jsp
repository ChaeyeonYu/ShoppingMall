<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>    

<script>
$(function(){
	//제품 업데이트.. 시간남으면 카테고리 변경 해보기!
	//셀랙트 상자로 카테고리 띄워서
	
	//카테고리로 이동
	$("#btn_category").click(function(){
		location.href = "category.admin-cy";
	});
	
	//폼 전송시 새로운 이미지를 등록했는지 확인
	$("#product_update_form").submit(function(){
		var new_product_img = $("input[name=new_product_img]").val();
		
		if(new_product_img != ""){
			$(this).attr("enctype", "multipart/form-data");
			$("input[name=isBinary]").val("Y");
		}
	});
});
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<h1>product_update</h1>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br>


<!-- 제품 상세보기 & 수정하기 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
		<form method="post" action="product-update-pro.admin-cy" id="product_update_form">
			<input type="hidden" name="category_code" value="${productVo.category_code}"/>
			<input type="hidden" name="product_num" value="${productVo.product_num}"/>
			<input type="hidden" name="product_img" value="${productVo.product_img}"/>
			<input type="hidden" name="isBinary" value="N"/>
			<table class="table" >
				<tr>
					<th align="right">CATEGORY CODE*</th>
					<td>${productVo.category_code}</td>
				</tr>
				<tr>
					<th align="right">CATEGORY NAME*</th>
					<td>${productVo.category_name}</td>
				</tr>
				<tr>
					<th align="right">PRODUCT NAME*</th>
					<td><input type="text" style="width:100%;" name="product_name" value="${productVo.product_name}"
							maxlength="20" placeholder="PRODUCT NAME*" required/></td>
				</tr>
				<tr>
					<th align="right">PRODUCT PRICE*</th>
					<td><input type="text" style="width:100%;" name="product_price" value="${productVo.product_price}"
							maxlength="7" placeholder="PRODUCT PRICE*" required/></td>
				</tr>
				<tr>
					<th align="right">PRODUCT STOCK</th>
					<td><input type="text" style="width:100%;" name="product_stock" value="${productVo.product_stock}"
							maxlength="7" placeholder="PRODUCT_STOCK"/></td>
				</tr>
				<tr>
					<th align="right">PRODUCT CONTENT</th>
					<td><textarea rows="10" cols="50" name="product_content" placeholder="PRODUCT_CONTENT"
						 style="width:100%;" maxlength="350" >${productVo.product_content}</textarea></td>
				</tr>
				
				<c:choose>
					<c:when test="${not empty productVo.product_img}">
					<tr>
						<th align="right">PRODUCT IMG</th>
						<td><img src="upload/${productVo.product_img}" width="500"/></td>
					</tr>
					<tr>
						<th align="right">NEW PRODUCT IMG</th>
						<td><input type="file" style="width:100%;" name="new_product_img"></td>
					</tr>
					</c:when>
					<c:otherwise>
					<tr>
						<th>PRODUCT IMG</th>
						<td><input type="file" style="width:100%;" name="product_img"></td>		
					</tr>
					</c:otherwise>
				</c:choose>

				</table>
				
				<button type="submit" class="btn btn-lg btn-outline-secondary" id="btn_add_product">UPDATE</button>
				<button type="button" class="btn btn-lg btn-outline-secondary" id="btn_category">CATEGORY</button>
		</form>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>


<br><br>

<%@ include file="../include/footer.jsp" %>