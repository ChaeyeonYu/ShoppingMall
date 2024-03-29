<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
       
<!-- Home Main(검색 추가), Login -->
<!-- 검색 X  -->
<!-- 회전목마 O -->        
       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta name="description" content="Source code generated using layoutit.com">
<meta name="author" content="LayoutIt!">

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">

<style>
a{
	text-decoration: none;
	color: black;
}

/* 페이징바 */
.pagination{  
  	text-align: center;  
  	justify-content: center;
}
.pagination a{  
  	color: black;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<script>

$(function(){
	
	//클릭한 카테고리를 붉은색으로 변경
	var now_header = "";
	
	$(".header_a").on("click", function(e){
		var now_header = $(this).text();
// 		console.log(now_header);
		
		$("a").attr("style", "color:black");
		$(this).attr("style", "color:red");
	});
	
});
</script>

<title>chaeyeon design store</title>
</head>

<body>
<br><br> 

<!-- 로고, 네비 시작 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
			<div class="row">
				<div class="col-md-4">
					<a href="main.cy"><img alt="LOGO" src="img/CY_LOGO.PNG" /></a>
				</div>
<!-- NAV BAR START -->
				<div class="col-md-4">
					<ul class="nav">
						<li class="nav-item">
							<a class="header_a nav-link active" href="main.cy">HOME</a>
						</li>
						<li class="nav-item">
							<a class="header_a nav-link active" href="shop.cy">SHOP</a>
						</li>
						<li class="nav-item">
							<a class="header_a nav-link active" href="cart.user-cy">CART</a>
						</li>
						<li class="nav-item">
							<c:choose>
								<c:when test="${not empty user_id}">
									<a class="header_a nav-link" href="login-out.user-cy">LOGOUT</a>
								</c:when>
								<c:otherwise>
									<a class="header_a nav-link" href="login-register.cy">LOGIN</a>
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
				</div>
<!-- NAV BAR END -->	
	
<!-- DROPDOWN START -->
				<div class="col-md-4">
				<!-- 드롭다운 1 -->
				<ul class="nav">
					<li class="nav-item dropdown ml-md-auto">
						 <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">PAGE</a>
						<div class="dropdown-menu dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
							 <a class="dropdown-item" href="main.cy">HOME</a> 
							 <a class="dropdown-item" href="shop.cy">SHOP</a> 
							 <a class="dropdown-item" href="cart.user-cy">CART</a> 
							 
							<c:choose>
							<c:when test="${not empty user_id}">
								<a class="dropdown-item" href="login-out.user-cy">LOGOUT</a>
								<!-- 구매내역, 개인정보 수정도 여기에 넣기	-->
								<a class="dropdown-item" href="buy-list.user-cy">구매내역</a> 
								<a class="dropdown-item" href="personal-information.user-cy">개인정보 수정</a>
							</c:when>
							<c:otherwise>
								<a class="dropdown-item" href="login-register.cy">LOGIN & REGISTER</a>
							</c:otherwise>
							</c:choose>
						</div>
					</li>
				</ul>
				<!-- 드롭다운 2, admin -->		
				<c:if test="${user_id eq 'admin'}">
				<ul class="nav">
				<li class="nav-item dropdown ml-md-auto">
					 <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">ADMIN</a>
					<div class="dropdown-menu dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						 <a class="dropdown-item" href="category.admin-cy">제품 관리</a> 
						 <a class="dropdown-item" href="order-list.admin-cy">주문 목록</a> 
					</div>
				</li>
				</ul>
				</c:if>
<!-- DROPDOWN END -->	
			
				</div>
			</div>
		</div>
		<div class="col-md-1">
		</div>
	</div>
</div>
<!-- 로고, 네비 끝 -->

<br>

<!-- 검색 -->
<!-- <div class="container-fluid" id="search_div"> -->
<!-- <form id="search_form"> -->
<!-- <div class="row"> -->
<!-- <div class="col-md-1"></div> -->
<!-- <div class="col-md-10"> -->
<!-- <div class="card-body row no-gutters align-items-center"> -->
<!--       <div class="col-auto"> -->
<!--       	<i class="fas fa-search h4 text-body"></i> -->
<!--       </div> -->
<!--       end of col -->
<!--       <div class="col"> -->
<!-- 	 	 <input class="form-control form-control-lg form-control-borderless"  -->
<!--       		     type="search" placeholder="Search here .." id="search_input" name="keyword"/> -->
<!--       </div> -->
<!--       end of col -->
<!--       <div class="col-auto"> -->
<!--         <button type="submit" class="btn btn-lg btn-block btn-outline-danger" id="btn_search">Search</button> -->
<!--       </div> -->
<!--       end of col -->
<!--       </div> -->
<!-- </div> -->
<!-- <div class="col-md-1"></div> -->
<!-- </div> -->
<!-- </form> -->
<!-- </div> -->
<!-- 검색 끝 -->

<br>
<c:if test="${not empty user_id}">

<div class="container-fluid" align="right">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10" align="right">
		${user_name}(${user_id})님 환영합니다.
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

</c:if>

<!-- 회전목마 시작 -->
	<div class="container-fluid">
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
			<div class="carousel slide" id="carousel-509661">
				<ol class="carousel-indicators">
					<li data-slide-to="0" data-target="#carousel-509661" class="active">
					</li>
					<li data-slide-to="1" data-target="#carousel-509661">
					</li>
					<li data-slide-to="2" data-target="#carousel-509661">
					</li>
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
<!-- 						<img class="d-block w-100" alt="Carousel Bootstrap Second" src="img/bg1.PNG" width="800" height="500"> -->
						<img class="d-block w-100" alt="Carousel Bootstrap Second" src="img/bg11.PNG" width="800" height="500">
						<div class="carousel-caption">
<!-- 							<h4>First Thumbnail label</h4> -->
<!-- 							<p> -->
<!-- 								Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit. -->
<!-- 							</p> -->
						</div>
					</div>
					<div class="carousel-item">
<!-- 						<img class="d-block w-100" alt="Carousel Bootstrap Second" src="../img/bg2.PNG" width="800" height="400"> -->
<!-- 						<img class="d-block w-100" alt="Carousel Bootstrap Second" src="img/bg2.PNG" width="800" height="500"> -->
						<img class="d-block w-100" alt="Carousel Bootstrap Second" src="img/bg22.PNG" width="800" height="500">
						<div class="carousel-caption">
<!-- 							<h4>Second Thumbnail label</h4> -->
<!-- 							<p> -->
<!-- 								Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit. -->
<!-- 							</p> -->
						</div>
					</div>
					<div class="carousel-item">
<!-- 						<img class="d-block w-100" alt="Carousel Bootstrap Second" src="../img/bg3.PNG" width="800" height="400"> -->
						<img class="d-block w-100" alt="Carousel Bootstrap Second" src="img/bg3.PNG" width="800" height="500">
						<div class="carousel-caption">
<!-- 							<h4>Third Thumbnail label</h4> -->
<!-- 							<p> -->
<!-- 								Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit. -->
<!-- 							</p> -->
						</div>
					</div>
				</div> <a class="carousel-control-prev" href="#carousel-509661" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> <a class="carousel-control-next" href="#carousel-509661" data-slide="next"><span class="carousel-control-next-icon"></span> <span class="sr-only">Next</span></a>
			</div>
		</div>
		<div class="col-md-1">
		</div>
	</div>
	</div>
<!-- 회전목마 끝 -->
