<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header2.jsp"%>

<script>
$(function(){
});
</script>

<br><br>
<div class="container-fluid" align="center">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10" align="center">
			<p><strong>구매내역 전체</strong></p>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br>

<c:choose>
<c:when test="${empty list}">
<div class="container-fluid" align="center">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10" align="center">
			<p>구매내역이 없습니다.</p>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>
</c:when>

<c:otherwise>
		
<!-- 본문 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
		
		<table class="table">
			
			<thead align="center">
				<tr align="center">
					<th>주문번호</th>
					<th>제품정보</th>
					<th></th>
					<th>가격</th>
					<th>주문수량</th>
					<th>주문일</th>
					<th>수령인</th>
					<th>연락처</th>
					<th>배송지</th>
				</tr>
			</thead>
				
			<tbody>
				<c:forEach items="${list}" var="vo">
				<tr>
					<td align="center">${vo.buy_num}</td>
					<c:choose>
						<c:when test="${not empty vo.product_img}">
							<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
								<img alt="product pic" src="upload/${vo.product_img}" width="50" height="40"/>
							</a></td>
						</c:when>
						<c:otherwise>
							<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
								<img alt="default img" src="img/default.png" width="50" height="50"/>
							</a></td>
						</c:otherwise>
					</c:choose>
					<td>${vo.product_name}</td>
					<td align="center">${vo.product_price}</td>
					<td align="center">${vo.product_count}</td>
					<td>${vo.buy_date}</td>
					<td>${vo.buy_receiver}</td>
					<td>${vo.user_tel}</td>
					<td>${vo.user_address}</td>
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

<br>

<%@ include file="include/footer.jsp" %>