<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>    

<div class="container-fluid" align="center">
	<div class="row" align="center">
		<div class="col-md-1"></div>
		<div class="col-md-10" align="center">
			<p><strong>주문목록 전체보기</strong></p>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br>

<c:choose>
<c:when test="${empty list}">

<div class="container-fluid" align="center">
	<div class="row" align="center">
		<div class="col-md-1"></div>
		<div class="col-md-10" align="center">
			<p>주문목록이 없습니다.</p>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

</c:when>
<c:otherwise>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<table class="table">
					<thead align="center">
						<tr align="center">
							<th>주문번호</th>
							<th>주문 아이디</th>
							<th>제품명</th>
							<th>가격</th>
							<th>주문수량</th>
							<th>주문일</th>
							<th>수령인</th>
							<th>연락처</th>
							<th>배송지</th>
						</tr>
					</thead>
					<tbody>
							<c:forEach items="${list}" var="vo" varStatus="status">
							<tr>
								<td align="center">${vo.buy_num}</td>
								<td>${vo.user_id}</td>
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

<br><br>

<%@ include file="../include/footer.jsp" %>