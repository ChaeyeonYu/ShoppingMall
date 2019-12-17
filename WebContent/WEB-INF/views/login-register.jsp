<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
       
<%@ include file="include/header.jsp"%>
<style>
#login_h2, #register_h2{
	cursor: pointer;
}
</style>

<script>
$(function(){
	
// 	var v = "${param.msg}";
	var v = "${sessionScope.msg}";
	
	//아이디 중복체크 하기 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//회원가입 실패
	if(v == "user_regist_fail") {
		alert("회원가입에 실패했습니다. 다시 가입하세요.");
	//로그인 실패 //비밀번호 불일치	//등록되지 않은 아이디	
	}else if(v == "login_incorrect_passwd" || v == "login_id_not_found"){
		alert("등록되지 않은 아이디이거나 잘못된 비밀번호입니다.");
	}
	
	//LOGIN&REGISTER(현재 페이지)에 붉은색
	$(".header_a:eq(3)").attr("style", "color:red");
	
	//로그인
	$("form[name=registerForm]").hide();
	$("#login_h2").css("color", "red");
	
	//로그인 폼 보이기
	$("#login_h2").click(function(){	
		$("form[name=registerForm]").hide();
		$("form[name=loginForm]").show();
		$("#login_h2").css("color", "red");
		$("#register_h2").css("color", "black");
	});
	//회원가입 폼 보이기
	$("#register_h2").click(function(){
		$("form[name=loginForm]").hide();
		$("form[name=registerForm]").show();
		$("#login_h2").css("color", "black");
		$("#register_h2").css("color", "red");
	});





	//loginRegister(self) test@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// 	function loginRegister(self){
// 		if(self.id == 'login_h2'){
// 		if(self == 'LOGIN'){
// 			console.log(self);
// 			$("form[name=registerForm]").hide();
// 			$("form[name=loginForm]").show();
// 			$("#login_h2").css("color", "red");
// 			$("#register_h2").css("color", "black");
// 		}else{
// 		}else if(self.text() == 'REGISTER'){
// 			console.log(self.id);
// 			console.log(self);
// 			$("form[name=loginForm]").hide();
// 			$("form[name=registerForm]").show();
// 			$("#login_h2").css("color", "black");
// 			$("#register_h2").css("color", "red");
// 		}
// 	}
});
</script>


<!-- session을 지움 -->
<!-- 처음 한 번만 띄울 것은(새고시에 안나오게) 세션에 넣고 날림 -->
<c:remove var="msg" scope="session"/>


<br><br>

<!-- LOGIN & REGISTER -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-4"></div>
		
		<div class="col-md-4">
			<div class="container-fluid">
				<div class="row" style="text-align: center;">
					<div class="col-md-6" style="text-align: center;" >
						<h2 id="login_h2">LOGIN</h2>
<!-- 						<h2 id="login_h2" onclick="loginRegister($(this).text());">LOGIN</h2> -->
<!-- 						<h2><a href="#" id="login_a" onclick="loginRegister(this);">LOGIN</a></h2> -->
					</div>
					<div class="col-md-6" style="text-align: center;" >
						<h2 id="register_h2">REGISTER</h2>
<!-- 						<h2 id="register_h2" onclick="loginRegister($(this).text());">REGISTER</h2> -->
<!-- 						<h2><a href="#" id="register_a" onclick="loginRegister(this);">REGISTER</a></h2> -->
<!-- 						<h2><a href="#" id="register_a">REGISTER</a></h2> -->
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-md-4"></div>
	</div>
</div>

<br><br>

<!-- LOGIN FORM & REGISTER FORM -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-4"></div>
		
		<div class="col-md-4">
		
<!-- LOGIN FORM START -->
			<form name="loginForm" action="login-login-pro.cy" method="post">
				<div class="form-group">
<!-- 					<input type="text" class="form-control" name="user_id" placeholder="ID*" maxlength="20" required/> -->
					<input type="text" class="form-control" name="user_id" placeholder="ID*" maxlength="20" value = "hong" required/>
				</div>
				<div class="form-group">
<!-- 					<input type="text" class="form-control" name="user_passwd" placeholder="PASSWD*" maxlength="20" required/> -->
					<input type="text" class="form-control" name="user_passwd" placeholder="PASSWD*" maxlength="20" value = "1234" required/>
				</div>
				<button type="submit" class="btn btn-block btn-outline-danger">LOGIN</button>
			</form>
<!-- LOGIN FORM	END -->
<!-- REGISTER FORM START-->		
			<form name="registerForm" action="login-register-pro.cy" method="post">
				<div class="form-group">
					<input type="text" class="form-control" name="user_id" placeholder="ID*" maxlength="20" required/>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="user_name" placeholder="NAME*" maxlength="20" required/>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="user_passwd" placeholder="PASSWD*" maxlength="20" required/>
				</div>
				<button type="submit" class="btn btn-block btn-outline-danger">REGISTER</button>
			</form>
<!-- REGISTER FORM END-->			
		</div>
		
		<div class="col-md-4"></div>
	</div>
</div>


<%@ include file="include/footer.jsp" %>
