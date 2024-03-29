<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
       
<%@ include file="include/header2.jsp"%>

<script>
$(function(){
	
	//SHOP(현재 페이지)에 붉은색
	$(".header_a:eq(1)").attr("style", "color:red");
	
	//paging을 위한 변수
	var page = 1;
	
	//category를 위한 변수
	var category_code = "";
	
	//search
	var keyword = ""; 
	$("#btn_search").on("click", function(e){
		e.preventDefault();
		keyword = $("#search_input").val();
		location.href = "shop.cy?page="+page+"&keyword="+keyword;
	});
	
	//클릭한 카테고리를 붉은색으로 변경
	var now_category = "ALL";
	$(".product_a:eq(0)").attr("style", "color:red");
	
	$(".product_a").on("click", function(e){
		//클릭한 카테고리를 붉은색으로 변경
		now_category = $(this).text();
		category_code = $(this).attr("data-category-code");
		$("a").attr("style", "color:black");
		$(this).attr("style", "color:red");
		
		//제품목록을 클릭한 카테고리에 해당하는 것들만 출력
		if(now_category == "ALL"){
			location.href = "shop.cy?page=1";
		}else{
			$("#search_input").val("");
			category_code = $(this).attr("data-category-code");
			page = 1;
			getProductList(category_code, page);
			getPaging(category_code, page);
		}
		
		//SHOP(현재 페이지)에 붉은색 유지
		$(".header_a:eq(1)").attr("style", "color:red");
	});
	
	//paging
	$(document).on("click", ".paging", function(e){
		e.preventDefault();
		page = $(this).attr("href");
		console.log("paging=================================");
		console.log(page);
		console.log(category_code);
		
		//page a태그 클릭시
		//제품목록을 클릭한 카테고리에 해당하는 것들만 출력
		if(now_category == "ALL"){
			location.href = "shop.cy?page="+page+"&keyword="+$("#search_input").val();
		}else{
			console.log("paging_other_category================================");
			console.log(page);
			getProductList(category_code, page);
			getPaging(category_code, page);
		}
		
		//SHOP(현재 페이지)에 붉은색 유지
		$(".header_a:eq(1)").attr("style", "color:red");
		
	});
	
	//function paging
	function getPaging(category_code, page){
		console.log("getPaging==============================");
		var sData = {
				"category_code" : category_code,
				"page" : page
		}
		console.log(sData);
		
		$.getJSON("shop-paging-service.ajax-cy", sData, function(rData){
			console.log(rData);
			$("#paging_div").empty();
			
			if(rData.totalCountByCategory != 0){
				var div = "<div>";
				div = "<ul class='pagination'>";
				
				if(rData.startPage != 1){
					div += "<li><a class='page-link paging' href=" + (rData.startPage -1) + 
							">Previous</a></li>"
				}
				for(var i=rData.startPage; i<=rData.endPage; i++){
					if(rData.nowPage == i){
						div += "<li><a class='page-link paging' href='" + i + 
								"' style='color: red; font-weight: bold;'>" + i +"</a></li>"
					}else{
						div += "<li><a class='page-link paging' href='" + i + "'>" + i +"</a></li>"
					}
				}
				if(rData.endPage != rData.totalPage){
					div += "<li><a class='page-link paging' href=" + (rData.endPage +1) + 
							">Next</a></li>"
				}
				div += "</ul></div>";
				
				$("#paging_div").append(div);
			} //if
		}); //$.getJSON
	} //getPaging()
	
	
	//function 제품 목록 조회
	function getProductList(category_code, page){
		console.log("getProductList==============================");
		console.log(category_code);
		console.log(page);
		var sData = {
				"category_code" : category_code,
				"page" : page
		}
		$.getJSON("shop-service.ajax-cy", sData, function(rData){
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
			}); //$.each
		}); //$.getJSON
	} //getProductList()
	
	
	//제품 이미지와 제목을 클릭했을 때 현재 클릭한 제품의 상세보기로 이동
	$("#product_list_div").on("click", ".product_detail", function(e){
		e.preventDefault();
		
		var product_num = $(this).attr("data-product-num");
		location.href = "product-detail.cy?product_num=" + product_num;
	});
	
	
});
</script>

<br>

<!-- 검색 -->
<div class="container-fluid" id="search_div">
<form id="search_form">
<div class="row">
<div class="col-md-1"></div>
<div class="col-md-10">
<div class="card-body row no-gutters align-items-center">
      <div class="col-auto">
      	<i class="fas fa-search h4 text-body"></i>
      </div>
      <!--end of col-->
      <div class="col">
      
      <c:choose>
      <c:when test="${not empty keyword}">
       	<input class="form-control form-control-lg form-control-borderless" value="${keyword}"
      		     type="search" placeholder="Search here .." id="search_input" name="keyword"/>
      </c:when>
      <c:otherwise>
       	<input class="form-control form-control-lg form-control-borderless" 
      		     type="search" placeholder="Search here .." id="search_input" name="keyword"/>
      </c:otherwise>
      </c:choose>
      
	 	
      </div>
      <!--end of col-->
      <div class="col-auto">
        <button type="submit" class="btn btn-lg btn-block btn-outline-danger" id="btn_search">Search</button>
      </div>
      <!--end of col-->
      </div>
</div>
<div class="col-md-1"></div>
</div>
</form>
</div>
<!-- 검색 끝 -->

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
<div class="container-fluid text-center" style="width:100%;">
	<div class="row text-center" >
		<div class="col-md-1"></div>
		<div class="col-md-10 text-center" id="product_list_div" style="margin-left:100px">
		
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

<!-- 페이징 START-->
<div class="row" align="center">
	<div class="col-md-1"></div>
		<div class="col-md-10" id="paging_div">
				<ul class="pagination">
				
				<c:if test="${pagingDto.startPage != 1}">
					<li>
						<a class="page-link paging" href="${pagingDto.startPage -1}">Previous</a>
					</li>
				</c:if>	
				
				<c:forEach var="i" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
					<li>
						<c:choose>
						<c:when test="${pagingDto.nowPage eq i}">
							<a class="page-link paging" href="${i}" style="color: red; font-weight: bold;"
							>${i}</a>
						</c:when>
						<c:otherwise>
							<a class="page-link paging" href="${i}"
							>${i}</a>
						</c:otherwise>
						</c:choose>
					</li>
				</c:forEach>
					
				<c:if test="${pagingDto.endPage != pagingDto.totalPage}">	
					<li>
						<a class="page-link paging" href="${pagingDto.endPage +1}">Next</a>
					</li>
				</c:if>
				
				</ul>
		</div>
	<div class="col-md-1"></div>
</div>
<!-- 페이징 END -->


<br><br>

<%@ include file="include/footer.jsp" %>