<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header2.jsp"%>

<script>
$(function(){
	
	var v = "${sessionScope.msg}";
	
	if(v == "fail") {
		alert("정보수정에 실패했습니다.");
	}else if(v == "success"){
		alert("개인정보가 업데이트 되었습니다.");
	}
	
	$("#btn_update").click(function(e){
		e.preventDefault();
		
		var buy_receiver = $("input[name=user_name]").val();
		var user_tel = $("input[name=user_tel]").val();
		var uset_address = $("input[name=user_address]").val();
		var user_passwd = $("input[name=user_passwd]").val();
		
		if(buy_receiver == ""){
			alert("이름을 입력해주세요.");
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
		if(user_passwd == ""){
			alert("비밀번호를 입력해주세요.");
			return;
		}
		$("#info_form").submit();
	});
});
</script>

<!-- session을 지움 -->
<!-- 처음 한 번만 띄울 것은(새고시에 안나오게) 세션에 넣고 날림 -->
<c:remove var="msg" scope="session"/>

<br><br>

<!-- 본문 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<h4>개인정보</h4><br><br>
			
			<form action="personal-information-pro.user-cy" method="post" id="info_form">
			<div class="row">
				<div class="col-md-4">
					<p>이름</p>
					<p>연락처</p>
					<p>배송지</p>
					<p>비밀번호</p>
				</div>
				<div class="col-md-8">
				<input type="text" name="user_name" class="form-control" value="${vo.user_name}" maxlength="6" 
						required placeholder="이름을 입력해주세요." />
				<input type="text" name="user_tel" value="${vo.user_tel}" class="form-control" maxlength="10"
						required placeholder="연락처를 입력해주세요."/>
				<input type="text" name="user_address" value="${vo.user_address}" class="form-control" maxlength="33" 
						required placeholder="주소를 입력해주세요."/>
				<input type="text" name="user_passwd" class="form-control" maxlength="10"
						required placeholder="비밀번호를 입력해주세요."/>		
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
			<button type="button" id="btn_update" class="btn btn-block btn-outline-secondary">
				변경하기
			</button>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>


<br><br><br>

<%@ include file="include/footer.jsp" %>
    