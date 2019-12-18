<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header2.jsp"%>

<script>
$(function(){
	
	//카트에 있는 제품 클릭시 상세보기로 이동
	$(".product_a").on("click", function(e){
		var product_num = $(this).attr("data-product-num");
		location.href = "product-detail.cy?product_num="+product_num;
	});
});
</script>


<!-- <div class="container-fluid" align="right"> -->
<!-- 	<div class="row"> -->
<!-- 		<div class="col-md-1"></div> -->
<!-- 		<div class="col-md-10" align="right"> -->
<!-- 			<a href="cart.user-cy">장바구니로</a> -->
<!-- 		</div> -->
<!-- 		<div class="col-md-1"></div> -->
<!-- 	</div> -->
<!-- </div> -->

<br><br>

<!-- 본문 -->
<div class="container-fluid" align="center">
<div class="row" align="center">
	<div class="col-md-1">
	</div>
	<div class="col-md-10" align="center">
		<table class="table" id="tbl_buy">
			
			<thead align="center">
				<tr align="center">
					<th>IMAGE</th>
					<th>PRODUCT</th>
					<th>PRICE</th>
					<th>QUANTITY</th>
				</tr>
			</thead>
				
			<tbody>
				<tr>
					<c:choose>
						<c:when test="${not empty vo.product_img}">
							<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
								<img alt="product pic" src="upload/${vo.product_img}" width="50" height="50"/>
							</a></td>
						</c:when>
						<c:otherwise>
							<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
								<img alt="default img" src="img/인형1.PNG" width="50" height="50"/>
							</a></td>
						</c:otherwise>
					</c:choose>
						
					<td><a href="#" class="product_a" data-product-num="${vo.product_num}">${vo.product_name}</a></td>
					<td>${vo.product_price}</td>
					<td>${vo.product_count}</td>
				</tr>
				</tbody>	
				
			</table>
			
			
		</div>
		<div class="col-md-1">
		</div>
	</div>
</div>
	

<br>
<!-- total -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
			<div class="row" style="display: inline;">
				<div class="col-md-4" style="display: inline;">
					<h3 style="display: inline;"><strong>TOTALS : </strong> </h3><br>
					<h3 style="display: inline;" id="buy_total">
						 ${vo.product_price * vo.product_count}
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