<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
       
<%@ include file="include/header.jsp"%>

<script>
$(function(){
	//function 제품 목록 조회
	function getProductList(category_code){
		$.getJSON("shop-service.ajax-cy", {"category_code" : category_code}, function(rData){
			$("#product_list_div").empty();
			
			if(rData == ""){
				$("#product_list_div").append("제품이 없습니다.");
				return;
			}
			
			var count = 0;
			$.each(rData, function(){
				++count;
				
				var div = "<div>";
				div += "<div style='float:left; text-align:center; margin:10px'>";
				
				div += "<div style='text-align: center;'>";
				if(this.product_img == null){
					div += "<a href='#' class='product_detail' data-product-num=" + this.product_num + ">"
					 	+"<img src='img/default.png' width='230' height='230' alt='default img'/></a>";
				}else{
					div += "<a href='#' class='product_detail' data-product-num=" + this.product_num + ">"
						+ "<img src='upload/" + this.product_img + "' width='230' height='230' alt='product img'/></a>";
				}
				div += "</div>"
				
				div += "<div style='text-align: center;'><a href='#' class='product_detail' data-product-num=" + this.product_num + ">"
						+ this.product_name + "</a></div>";
				div += "</div>";
				
				if(count %5 == 0){ div += "<div style='clear:both;'></div>"; }
				
				$("#product_list_div").append(div);
			});
		});
	}
	
	//SHOP(현재 페이지)에 붉은색
	$(".header_a:eq(1)").attr("style", "color:red");
	
	//클릭한 카테고리를 붉은색으로 변경
	var now_category = "ALL";
	$(".product_a:eq(0)").attr("style", "color:red");
	
	$(".product_a").on("click", function(e){
		//클릭한 카테고리를 붉은색으로 변경
		var now_category = $(this).text();
		$("a").attr("style", "color:black");
		$(this).attr("style", "color:red");
		
		//제품목록을 클릭한 카테고리에 해당하는 것들만 출력
		if(now_category == "ALL"){
			location.href = "shop.cy";
		}else{
			var category_code = $(this).attr("data-category-code");
			getProductList(category_code);
		}
		
		//SHOP(현재 페이지)에 붉은색 유지
		$(".header_a:eq(1)").attr("style", "color:red");
	});
	
	
	//제품 이미지와 제목을 클릭했을 때 현재 클릭한 제품의 상세보기로 이동
	$("#product_list_div").on("click", ".product_detail", function(e){
		e.preventDefault();
		
		var product_num = $(this).attr("data-product-num");
		location.href = "product-detail.cy?product_num=" + product_num;
	});
	
	
});
</script>


<br><br>
<!-- 상품 카테고리 보이기 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
		
		<ul class="nav">
				<li class="nav-item">
					<a class="product_a nav-link active" href="#">ALL</a>
				</li>
				
				<c:forEach items="${categoryList}" var="categoryVo">
				<li class="nav-item"> 
					<a class="product_a nav-link" data-category-code="${categoryVo.category_code}" href="#">${categoryVo.category_name}</a>
				</li>
				</c:forEach>
		</ul>
		
		</div>
		<div class="col-md-1">
		</div>
	</div>
</div>


<br>
<!-- 본문 -->
<div class="container-fluid text-center" align="center" style="width:100%;">
	<div class="row text-center" align="center">
		<div class="col-md-1"></div>
		<div class="col-md-10 text-center" id="product_list_div" align="center">
		
			<c:forEach items="${productList}" var="productVo" varStatus="status">
				<div style="float:left; text-align:center; margin:10px">
					<div style="text-align: center;">
					
					<c:choose>
					<c:when test="${not empty productVo.product_img}">
						<a href="#" class="product_detail" data-product-num="${productVo.product_num}">
							<img src="upload/${productVo.product_img}" width="230" height="230" alt="default img"/>
						</a>
					</c:when>
					<c:otherwise>
						<a href="#" class="product_detail" data-product-num="${productVo.product_num}">
							<img src="img/default.png" width="230" height="230" alt="product img"/>
						</a>
					</c:otherwise>	
					</c:choose>
					</div>
					<div style="text-align: center;">
						<a href="#" class="product_detail" data-product-num="${productVo.product_num}">
							${productVo.product_name}
						</a>
					</div>	
				</div>
				<c:if test="${status.count % 5 == 0}">
					<div style="clear:both;"></div>
				</c:if>
			</c:forEach>
			
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br>




<br><br>

<%@ include file="include/footer.jsp" %>