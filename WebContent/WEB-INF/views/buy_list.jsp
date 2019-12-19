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
			<p><strong>주문목록 전체</strong></p>
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
			<p>주문내역이 없습니다.</p>
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
					<th>ORDER</th>
					<th>IMAGE</th>
					<th>PRODUCT</th>
					<th>PRICE</th>
					<th>QUANTITY</th>
					<th>ORDER DATE</th>
				</tr>
			</thead>
				
			<tbody>
				<c:forEach items="${list}" var="vo">
				<tr>
					<td>${vo.buy_num}</td>
					<c:choose>
						<c:when test="${not empty vo.product_img}">
							<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
								<img alt="product pic" src="upload/${vo.product_img}" width="50" height="40"/>
							</a></td>
						</c:when>
						<c:otherwise>
							<td><a href="#" class="product_a" data-product-num="${vo.product_num}">
								<img alt="default img" src="img/인형1.PNG" width="50" height="50"/>
							</a></td>
						</c:otherwise>
					</c:choose>
					<td>${vo.product_name}</td>
					<td>${vo.product_price}</td>
					<td>${vo.product_count}</td>
					<td>${vo.buy_date}</td>
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