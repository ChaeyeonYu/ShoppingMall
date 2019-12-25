<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script>
$(function(){
	
	//제품 추가
	$("#btn_add_product").click(function(){
		var category_code = "${categoryVo.category_code}";
		location.href = "product-insert.admin-cy?category_code=" + category_code ;
	});
	
	//제품 클릭시 상세보기로 이동@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
	$(".product_a").on("click", function(e){
		var product_num = $(this).attr("data-product-num");
		location.href = "product-detail.cy?product_num="+product_num;
	});
	
	//카테고리로 이동
	$("#btn_category").click(function(){
		location.href = "category.admin-cy";
	});
	
	//제품 수정
	$("#tbl_product").on("click", ".btn_update", function(){
		var category_code = $("input[name=category_code]").val();
		var product_num = $(this).attr("data-product-num");
		console.log(category_code);
		console.log(product_num);

		location.href="product-update.admin-cy?category_code=" + category_code + "&product_num=" + product_num;
	});
	
	//제품 삭제
	$("#tbl_product").on("click", ".btn_delete", function(){
		var that = $(this);
		
		var product_num = $(this).attr("data-product-num");
		var product_name = $(this).attr("data-product-name");
		console.log(product_num);

		var deleteConfirm = confirm(product_name + ' 제품을 삭제하시겠습니까?');
		if(deleteConfirm){
			var url = "product-delete-pro.ajax-cy";
			var sData = { "product_num" : product_num };
			$.post(url, sData, function(rData){
				if(rData.trim() == 'success'){ 
					that.parent().parent().remove();
					
					var numbering = $(".numbering");
					$.each(numbering, function(index){
						numbering.eq(index).text(index+1);
					});
				}
			});
		}else{
			return;
		}
		
	});
});
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<input type="hidden" name="category_code" value="${categoryVo.category_code}" />
			<h5>CATEGORY CODE - ${categoryVo.category_code}</h5>
			<h5>CATEGORY NAME - ${categoryVo.category_name}</h5>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br>

<div class="container-fluid" align="right">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
		<button class="btn btn-lg btn-outline-secondary" id="btn_add_product">ADD PRODUCT</button>
		<button type="button" class="btn btn-lg btn-outline-secondary" id="btn_category">CATEGORY</button>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>


<br><br>

<c:choose>
<c:when test="${empty list}">
<div class="container-fluid" align="center">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10" align="center">
			<h3>등록된 제품이 없습니다.</h3>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>
</c:when>
<c:otherwise>
<!-- 해당 카테고리의 제품 조회 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<table class="table" id="tbl_product">
					<thead align="center">
						<tr align="center">
							<th></th>
							<th></th>
							<th>제품정보</th>
							<th>제품설명</th>
							<th>가격</th>
							<th>등록일</th>
							<th>수정</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
							<c:forEach items="${list}" var="vo" varStatus="status">
							<tr>
								<td align="center" class="numbering">${status.count}</td>
								<c:choose>
									<c:when test="${not empty vo.product_img}">
										<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
											<img src="upload/${vo.product_img}" width="70"/></a></td>
									</c:when>
									<c:otherwise>
										<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
										<img src="img/default.png" width="50"/></a></td>
									</c:otherwise>
								</c:choose>
								<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
									${vo.product_name}</a></td>
								
								<td title="${vo.product_content}">
								<c:choose>
									<c:when test="${fn:length(vo.product_content)>10}">
										<c:out value="${fn:substring(vo.product_content,0,9)}"/>...
									</c:when>
									<c:otherwise>
										<c:out value="${vo.product_content}"/>
									</c:otherwise>
								</c:choose>

								</td>
<%-- 								<td>${vo.product_content}</td> --%>
								<td>${vo.product_price}</td>
								<td>${vo.product_reg_date}</td>
								<td><button class="btn_update btn btn-lg btn-outline-secondary" type="button" data-product-num="${vo.product_num}">UPDATE</button></td>
								<td><button class="btn_delete btn btn-lg btn-outline-secondary" type="button" 
											data-product-num="${vo.product_num}" data-product-name="${vo.product_name}">DELETE</button></td>
							</tr>
							</c:forEach>
					</tbody>						
				</table>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>
	
</c:otherwise>
</c:choose>


<br><br>

<%@ include file="../include/footer.jsp" %>