<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header2.jsp"%>

<script>
$(function(){
	//제품 이미지나 제목 클릭시 상세보기로 이동
	$(".product_a").on("click", function(e){
		var product_num = $(this).attr("data-product-num");
		location.href = "product-detail.cy?product_num="+product_num;
	});
	
	//주문하기
	$("#btn_order").click(function(e){
		e.preventDefault();
		
		var buy_receiver = $("input[name=buy_receiver]").val();
		var user_tel = $("input[name=user_tel]").val();
		var uset_address = $("input[name=user_address]").val();
		
		if(buy_receiver == ""){
			alert("수령인을 입력해주세요.");
			return;
		}
		if(user_tel == ""){
			alert("연락처를 입력해주세요.");
			return;
		}
		if(uset_address == ""){
			alert("배송지를 입력해주세요.");
			return;
		}
		$("#buy_form").submit();
	});
});
</script>

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

<br><br>
<hr style="margin-left: 100px; margin-right: 100px;">
<br>


<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<h4>배송정보</h4><br>
			
			<form action="buy-pro.user-cy" method="post" id="buy_form">
			<input type="hidden" name="buy_now" value="Y"/>
			<input type="hidden" name="product_num" value="${vo.product_num}"/>
			<input type="hidden" name="product_count" value="${vo.product_count}"/>
			
			<div class="row">
				<div class="col-md-4">
					<p>수령인</p>
					<p>연락처</p>
					<p>배송지</p>
				</div>
				<div class="col-md-8">
				
				<input type="text" name="buy_receiver" class="form-control" value="${userVo.user_name}"
						required placeholder="수령인을 입력해주세요."/>
				<input type="text" name="user_tel" value="${userVo.user_tel}" class="form-control" 
						required placeholder="연락처를 입력해주세요."/>
				<input type="text" name="user_address" value="${userVo.user_address}" class="form-control" 
						required placeholder="주소를 입력해주세요."/>
				</div>
			</div>
			</form>
			
			
		</div>
		<div class="col-md-1"></div>
	</div>
	
</div>
<br><br>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<button type="button" id="btn_order" class="btn btn-block btn-outline-secondary">
				주문하기
			</button>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br><br>




<%@ include file="include/footer.jsp" %>