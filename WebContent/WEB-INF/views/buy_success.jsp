<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header2.jsp"%>

<script>
$(function(){
	//주문완료 목록의 제품 클릭시 상세보기로 이동
	$(".product_a").on("click", function(e){
		var product_num = $(this).attr("data-product-num");
		location.href = "product-detail.cy?product_num="+product_num;
	});
	
});
</script>

<br><br>
<div class="container-fluid" align="center">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10" align="center">
			
			<img alt="default img" src="img/order_success.PNG" width="100" height="100"/>
			<p>주문이 완료되었습니다.</p>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>


<br><br>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-4">
		</div>
		<div class="col-md-4">
		
		<table class="table" id="tbl_buyer">
				
			<tbody>
				<tr>
					<th>주문번호</th>
					<td>${list[0].buy_num}</td>
				</tr>
				<tr>
					<th>총 상품 금액</th>
					<td>
					<c:set var="sum" value="0"/>
							<c:forEach items="${list}" var="vo">
								<c:set var="sum" value="${sum + vo.product_count * vo.product_price}"/>
							</c:forEach>
					<c:out value="${sum}"/>
					</td>
				</tr>
				<tr>
					<th>수령인</th>
					<td>${list[0].buy_receiver}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${list[0].user_tel}</td>
				</tr>
				<tr>
					<th>배송지</th>
					<td>${list[0].user_address}</td>
				</tr>
			</tbody>	
				
			</table>
		
		
		</div>
		<div class="col-md-4">
		</div>
	</div>
</div>




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
				<c:forEach items="${list}" var="vo">
				<tr>
					<c:choose>
						<c:when test="${not empty vo.product_img}">
							<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
								<img alt="product pic" src="upload/${vo.product_img}" width="50" height="50"/>
							</a></td>
						</c:when>
						<c:otherwise>
							<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
								<img alt="default img" src="img/default.png" width="50" height="50"/>
							</a></td>
						</c:otherwise>
					</c:choose>
						
					<td><a href="#" class="product_a" data-product-num="${vo.product_num}">${vo.product_name}</a></td>
					<td>${vo.product_price}</td>
					<td>${vo.product_count}</td>
				</tr>
				</c:forEach>
				</tbody>	
				
			</table>
		</div>
		<div class="col-md-1">
		</div>
	</div>
</div>
	

<br>
<!-- total -->
<!-- <div class="container-fluid"> -->
<!-- 	<div class="row"> -->
<!-- 		<div class="col-md-1"> -->
<!-- 		</div> -->
<!-- 		<div class="col-md-10"> -->
<!-- 			<div class="row" style="display: inline;"> -->
<!-- 				<div class="col-md-4" style="display: inline;"> -->
<!-- 					<h3 style="display: inline;"><strong>TOTALS : </strong> </h3><br> -->
<!-- 					<h3 style="display: inline;" id="buy_total"> -->
<%-- 						<c:choose> --%>
<%-- 						<c:when test="${empty list}">0</c:when> --%>
<%-- 						<c:otherwise> --%>
							
<%-- 						</c:otherwise> --%>
<%-- 						</c:choose> --%>
<!-- 					</h3> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-4"> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-4"> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="col-md-1"> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

<!-- <br><br> -->
<!-- <hr style="margin-left: 100px; margin-right: 100px;"> -->
<!-- <br> -->


<!-- <div class="container-fluid"> -->
<!-- 	<div class="row"> -->
<!-- 		<div class="col-md-1"></div> -->
<!-- 		<div class="col-md-10"> -->
<!-- 			<h4>배송정보</h4><br> -->
			
<!-- 			<form action="buy-pro.user-cy" method="post" id="buy_form"> -->
<!-- 			<div class="row"> -->
<!-- 				<div class="col-md-4"> -->
<!-- 					<p>수령인</p> -->
<!-- 					<p>연락처</p> -->
<!-- 					<p>배송지</p> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-8"> -->
				
<!-- 				<input type="text" name="buy_receiver" class="form-control"  -->
<!-- 						required placeholder="수령인을 입력해주세요."/> -->
<%-- 				<input type="text" name="user_tel" value="${userVo.user_tel}" class="form-control"  --%>
<!-- 						required placeholder="연락처를 입력해주세요."/> -->
<%-- 				<input type="text" name="user_address" value="${userVo.user_address}" class="form-control"  --%>
<!-- 						required placeholder="주소를 입력해주세요."/> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			</form> -->
			
			
<!-- 		</div> -->
<!-- 		<div class="col-md-1"></div> -->
<!-- 	</div> -->
	
<!-- </div> -->


<br><br>

<!-- <div class="container-fluid"> -->
<!-- 	<div class="row"> -->
<!-- 		<div class="col-md-1"></div> -->
<!-- 		<div class="col-md-10"> -->
<!-- 			<button type="button" id="btn_order" class="btn btn-block btn-outline-secondary"> -->
<!-- 				주문하기 -->
<!-- 			</button> -->
<!-- 		</div> -->
<!-- 		<div class="col-md-1"></div> -->
<!-- 	</div> -->
<!-- </div> -->

<br><br><br>

<%@ include file="include/footer.jsp" %>