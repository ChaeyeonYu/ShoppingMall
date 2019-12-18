<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="include/header2.jsp"%>

<script>
$(function(){
	
	//SHOP(현재 페이지)에 붉은색
// 	$(".header_a:eq(1)").attr("style", "color:red");
	
// 	var v = "${sessionScope.msg}";
	
// 	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  할말?? START
	$("#write_review_div").hide();
	$("#list_review_div").hide();
	$("#write_review_button").hide();
	
	//제품 상세
	$("#product_detail_a").click(function(){
		$("#product_detail_div").show();
		$("#write_review_div").hide();
		$("#list_review_div").hide();
		$("#write_review_button").hide();
	});
	
	//리뷰
	$("#review_a").click(function(){
		$("#product_detail_div").hide();
		$("#list_review_div").show();
		$("#write_review_button").show();
	});
	
	//리뷰 작성
	$("#write_review_button").click(function(){
		$("#write_review_div").show();
	});
//  할말?? END
// 	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//수량 버튼 SRATR
	$(".plus").click(function(){
		var num = $(".numBox").val();
		var plusNum = Number(num) + 1;
		var max = ${productVo.product_stock};
		
		if(plusNum > max) {
			$(".numBox").val(num);
		} else {
		    $(".numBox").val(plusNum);          
		}
	});
		  
	$(".minus").click(function(){
		var num = $(".numBox").val();
		var minusNum = Number(num) - 1;
		   
		if(minusNum <= 0) {
		    $(".numBox").val(num);
		} else {
		    $(".numBox").val(minusNum);          
		}
	});
	//수량 버튼 END
	
	
	//클릭한 카테고리를 붉은색으로 변경
	//처음은 제품 상세 a 태그를 붉은색으로 설정
	$(".menu_a:eq(0)").attr("style", "color:red");
	
	$(".menu_a").on("click", function(e){
		//클릭한 카테고리를 붉은색으로 변경
		$("a").attr("style", "color:black");
		$(this).attr("style", "color:red");
	});
	
	
	//장바구니 버튼 클릭
	$("#btn_cart").click(function(){
		//장바구니에 넣을 갯수
		var product_count = $(".numBox").val(); 
		//제품번호
		var product_num = $(this).attr("data-product-num"); 
		
		var url = "cart-pro.ajax-cy";
		var sData = {
				"product_num" : product_num,
				"product_count" : product_count
		};
		$.post(url, sData, function(rData){
			if(rData.trim() == "success"){
				var deleteConfirm = confirm('계속 쇼핑을 하시겠습니까?\n취소시 장바구니로 이동합니다.');
				//아니오 클릭시 장바구니로 이동
		 		if(!deleteConfirm){
		 			location.href = "cart.user-cy";
		 		}
			}else if(rData.trim() == "not_login"){
				alert("로그인 후 이용가능합니다.");
			}
		});
	});
	
	//구매하기 버튼 클릭
	$("#btn_buy").click(function(){
		var product_count = $(".numBox").val();
		var product_num = $(this).attr("data-product-num"); 
		location.href = "buy-now.user-cy?product_num="+product_num+"&product_count="+product_count;
	});
});
</script>


<!-- session을 지움 -->
<!-- 처음 한 번만 띄울 것은(새고시에 안나오게) 세션에 넣고 날림 -->
<c:remove var="msg" scope="session"/>

<br><br>

<!-- 제품 이미지, 수량 상세 START -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
		<div class="row">
			<div class="col-md-6">
				<c:choose>
				<c:when test="${not empty productVo.product_img}">
					<img alt="product img" src="upload/${productVo.product_img}" width="300" height="300"/>
				</c:when>
				<c:otherwise>
					<img alt="product img" src="img/인형1.PNG" width="300" height="300"/>
				</c:otherwise>
				</c:choose>
				
			</div>
			<div class="col-md-6">
				<!-- https://kuzuro.blogspot.com/2018/10/15_13.html -->
				<div class="container-fluid">
				<div class="row">
					<div class="col-md-6">
						<h3><strong><br></strong></h3>
						<h3><strong>${productVo.product_name}</strong></h3>
						<h3><strong><br></strong></h3>
						<h4>가격</h4>
						<h4>재고</h4>
						<h4>구입수량</h4>
					</div>
					<div class="col-md-6">
						<h3><strong><br></strong></h3>
						<h3><strong><br></strong></h3>
						<h3><strong><br></strong></h3>
						<h4>${productVo.product_price}</h4>
						<h4>${productVo.product_stock}</h4>
						
						<button type="button" class="minus" style="border: none; background: none;">-</button>
						 <input type="number" class="numBox" min="1" max="${productVo.product_stock}" value="1" readonly="readonly"/>
						<button type="button" class="plus" style="border: none; background: none;">+</button>
					</div>
				</div>
				</div>
				
				<br>
				<!-- 구매 버튼 & 품절 알림 -->
				<c:choose>
					<c:when test="${productVo.product_stock == 0}">
						<div class="container-fluid">
							<div class="row">
								<div class="col-md-12">
									<h4 align="left">품절된 제품입니다.</h4>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
					<div class="row">
						<div class="col-md-6">
							<button type="button" id="btn_buy" data-product-num="${productVo.product_num}" 
								class="btn btn-block btn-outline-secondary">구매하기</button>
						</div>
						<div class="col-md-6">
							<button type="button" id="btn_cart" data-product-num="${productVo.product_num}" 
								class="btn btn-block btn-outline-secondary">장바구니</button>
						</div>
					</div>
					</c:otherwise>
				</c:choose>
				
			</div>
		</div>
		</div>
		
		</div>
		<div class="col-md-1"></div>
</div>
<!-- 제품 이미지, 수량 상세 END -->

<br><br>
<hr style="margin-left: 100px; margin-right: 100px;">

<!-- 상세보기, 리뷰 NAV BAR START -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
		
		<div class="container-fluid">
				<div class="row">
						<div class="col-md-4">
							<ul class="nav">
								<li class="nav-item">
									<a class="menu_a nav-link active" href="#" id="product_detail_a">제품 상세</a>
								</li>
								<li class="nav-item">
									<a class="menu_a nav-link" href="#" id="review_a">리뷰</a>
								</li>
							</ul>
						</div>
						
						<div class="col-md-4"></div>
						
						<div class="col-md-4">
							<button type="submit" class="btn btn-block btn-outline-secondary" id="write_review_button">
							리뷰 작성하기
							</button>
						</div>
				</div>
		</div>
		
		</div>
		<div class="col-md-1">
		</div>
	</div>
</div>
<!-- 상세보기, 리뷰 NAV BAR END -->

<br><br>

<!-- 제품 상세 -->
<div class="container-fluid" id="product_detail_div">
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10" align="center">
			<c:choose>
				<c:when test="${not empty productVo.product_img}">
					<img alt="product img" src="upload/${productVo.product_img}" align="middle"/>
				</c:when>
				<c:otherwise>
					<img alt="product img" src="img/인형1.PNG" align="middle"/>
				</c:otherwise>
			</c:choose>
			<br><br><br><br>
			<p style="text-align: center;">
				${productVo.product_content}
			</p>
		</div>
		<div class="col-md-1">
		</div>
	</div>
</div>

<!-- 리뷰작성 textarea & 작성완료 버튼 START-->
<div class="container-fluid" id="write_review_div">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<form role="form">
				<div class="form-group">
					<textarea class="form-control" placeholder="리뷰를 작성해주세요~"></textarea>
				</div>
			</form>
		</div>
		<div class="col-md-1"></div>
	</div>
	
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<button type="submit" class="btn btn-block btn-outline-secondary">
				작성완료
			</button>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>
<!-- 리뷰작성 textarea & 작성완료 버튼 END-->


<br><br>

<!-- 리뷰 목록 START -->
<div class="container-fluid" id="list_review_div">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
<!-- MEDIA START -->
			<div class="media">
				<div class="media-body">
					<h5 class="mt-0">홍뭉치</h5> 
					좋아요!
					<div class="media mt-3">
						ㄴ
						<div class="media-body">
							<h5 class="mt-0">매니저</h5> 
							애용해주셔서 감사합니다.
						</div>
					</div>
				</div>
			</div>
<!-- MEDIA END -->			
		</div>
		<div class="col-md-1"></div>
	</div>
</div>
<!-- 리뷰 목록 END-->

<br><br><br>

<%@ include file="include/footer.jsp" %>