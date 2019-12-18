<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
       
<%@ include file="include/header2.jsp"%>

<script>
$(function(){
	//CART(현재 페이지)에 붉은색
	$(".header_a:eq(2)").attr("style", "color:red");
	
	//빈 장바구니 함수
	function emptyCart(){
		var div = "<div class='col-md-1'></div>";
		div += "<div class='col-md-10' align='center'>";
		div += "<p>장바구니가 비어있습니다.</p>";
		div += "</div>";
		div += "<div class='col-md-1'></div>";
		
		$("#content_div").append(div); //장바구니 목록 비우기
		$("#cart_total").text("0");	   //장바구니 제품 총 합계를 0으로 설정
	}
	
	//장바구니에 있는 제품 클릭시 상세보기로 이동
	$(".product_a").on("click", function(e){
		var product_num = $(this).attr("data-product-num");
		location.href = "product-detail.cy?product_num="+product_num;
	});
	
	//X 이미지 클릭 //선택삭제
	$(".remove_img").on("click", function(){
		var that = $(this);
		var cart_num = $(this).attr("data-cart-num");
		var user_id = $("input[name=user_id]").val();
		
		var cart_total_num = Number($("#cart_total").text().trim());
		var product_price_num = Number(that.attr("data-product-price"));
		var product_count_num = Number(that.parent().parent().find(".numBox").val());
		
// 		test
		console.log(product_price_num * product_count_num);

		var sData = {
				"cart_num" : cart_num,
				"user_id" : user_id
		};
		
		$.post("cart-delete.ajax-cy", sData, function(rData){
			if(rData.trim() == "success"){
				that.parent().parent().remove();
				$("#cart_total").text(cart_total_num - (product_price_num * product_count_num));
				
				//선택한 행만 삭제하다가 tbody의 내용이 없다면 emptyCart()를 실행
				var img = $(".remove_img");
				if($("#tbl_cart").find(img).val() == null){
					$("#tbl_cart").remove();
					emptyCart();
				} //if
			} //if rData.trim()
		}); //$.post
	});
	
	//전체삭제 버튼 클릭
	$("#btn_remove_all").on("click", function(){
		var removeAllConfirm = confirm('정말 장바구니 전체를 삭제하시겠습니까?');
 		if(!removeAllConfirm){ return; }
		
		var user_id = $("input[name=user_id]").val();
		
		$.post("cart-delete-all.ajax-cy", {"user_id" : user_id}, function(rData){
			if(rData.trim() == "success"){
				$("#tbl_cart").remove();
				emptyCart();
			}
		});
	});
	
	//수정
	//+, - 버튼 눌렀을 때 실행하기
	//카트번호, 수량, 사용자
	function update(cart_num, product_count, user_id){
		var sData = {
				"cart_num" : cart_num,
				"product_count" : product_count,
				"user_id" : user_id,
		};
		
		$.post("cart-update.ajax-cy", sData, function(){});
	}	
	
	//수량버튼 +
	$(".plus").on("click", function(){
// 		var that = $(this);
		var num = $(this).prev().val();
		var max = $(this).attr("data-product-max");
		var plusNum = Number(num) + 1;
		
		var cart_num = $(this).attr("data-cart-num"); 
		var user_id = $("input[name=user_id]").val();
		
		var cart_total = $("#cart_total");
		var cart_total_num = Number(cart_total.text().trim());
		var product_price_num = Number($(this).attr("data-product-price"));
		   
		if(plusNum > max) {
			$(this).prev().val(num);
		} else {
			$(this).prev().val(plusNum);
			update(cart_num, plusNum, user_id);
			cart_total.text(cart_total_num + product_price_num);
		}
	});
	
	//수량버튼 -
	$(".minus").on("click", function(){
		var num = $(this).next().val();
		var minusNum = Number(num) - 1;
		
		var cart_num = $(this).attr("data-cart-num"); 
		var user_id = $("input[name=user_id]").val();
		
		var cart_total = $("#cart_total");
		var cart_total_num = Number(cart_total.text().trim());
		var product_price_num = Number($(this).attr("data-product-price"));
		   
		if(minusNum <= 0) {
		    $(this).next().val(num);
		} else {
			$(this).next().val(minusNum);
			update(cart_num, minusNum, user_id);
			cart_total.text(cart_total_num - product_price_num);
		}
	});
	
	
	//주문
	$("#btn_buy").on("click", function(e){
		var user_id = $("input[name=user_id]").val();
		location.href = "buy.user-cy?user_id=" + user_id;
	});
});
</script>


<br><br>

<input type="hidden" name="user_id" value="${user_id}"/>

<div class="container-fluid" align="center" id="content_div">
<c:choose>
<c:when test="${empty list}">
	
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10" align="center">
			<p>장바구니가 비어있습니다.</p>
		</div>
		<div class="col-md-1"></div>
	</div>
	
</c:when>


<c:otherwise>
	<div class="container-fluid" align="center">
	<div class="row" align="center">
		<div class="col-md-1">
		</div>
		<div class="col-md-10" align="center">
			<table class="table" id="tbl_cart">
			
				<thead align="center">
					<tr align="center">
						<th>IMAGE</th>
						<th>PRODUCT</th>
						<th>PRICE</th>
						<th>QUANTITY</th>
						<th>REMOVE</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${list}" var="vo">
					<tr>
						<c:choose>
							<c:when test="${not empty vo.product_img}">
								<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
									<img alt="product pic" src="upload/${vo.product_img}" width="100" height="100"/>
								</a></td>
							</c:when>
							<c:otherwise>
								<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
									<img alt="default img" src="img/인형1.PNG" width="100" height="100"/>
								</a></td>
							</c:otherwise>
						</c:choose>
						
						<td><a href="#" class="product_a" data-product-num="${vo.product_num}">${vo.product_name}</a></td>
						<td>${vo.product_price}</td>
						
						<td><button type="button" class="minus" style="border: none; background: none;"
								data-product-price="${vo.product_price}" data-cart-num="${vo.cart_num}"
							 >-</button>
							 
						 	<input type="number" class="numBox" min="1" max="${vo.product_stock}" value="${vo.product_count}" readonly/>
						 	
							<button type="button" class="plus" style="border: none; background: none;"
							 	 data-product-max="${vo.product_stock}" data-product-price="${vo.product_price}"
							 	 data-cart-num="${vo.cart_num}"
							 >+</button></td>
							 
						<td><a href="#" data-cart-num="${vo.cart_num}" data-product-price="${vo.product_price}" 
							data-product-count="${vo.product_count}"  data-product-num="${vo.product_num}"
							class="remove_img"><img alt="remove" src="img/remove.png" width="30" height="30" />
						</a></td>
					</tr>
					</c:forEach>
				</tbody>	
				
			</table>
			
			<!-- 구매, 전체 삭제 버튼들 START -->
			<div class="row" align="right">
				<div class="col-md-4">
				</div>
				<div class="col-md-4">
				</div>
				<div class="col-md-4" align="right">
					<ul class="nav">
						<li class="nav-item">
							<button type="button" class="btn btn-lg btn-block btn-outline-secondary"
								id="btn_buy">BUY</button>
						</li>
						<li class="nav-item">
							<button type="button" class="btn btn-lg btn-block btn-outline-secondary" 
								id="btn_remove_all">REMOVE ALL</button>
						</li>
					</ul>
				</div>
			</div>
			<!-- 구매, 전체 삭제 버튼들 END -->
		</div>
		<div class="col-md-1">
		</div>
	</div>
	</div>
	
</c:otherwise>
</c:choose>

</div>


<br>
<!-- 본문 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
			<div class="row" style="display: inline;">
				<div class="col-md-4" style="display: inline;">
					<h3 style="display: inline;"><strong>CART TOTALS : </strong> </h3><br>
					<h3 style="display: inline;" id="cart_total">
						<c:choose>
						<c:when test="${empty list}">0</c:when>
						<c:otherwise>
							<c:set var="sum" value="0"/>
							<c:forEach items="${list}" var="vo">
								<c:set var="sum" value="${sum + vo.product_count * vo.product_price}"/>
							</c:forEach>
							<c:out value="${sum}"/>
						</c:otherwise>
						</c:choose>
					</h3>
				</div>
				<div class="col-md-4">
				</div>
				<div class="col-md-4">
				</div>
			</div>
		</div>
		<div class="col-md-1">
		</div>
	</div>
</div>



<br>

<%@ include file="include/footer.jsp" %>