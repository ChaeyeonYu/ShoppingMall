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
	$("#result_span").text("");		
	
	//로그인 폼 보이기
	$("#login_h2").click(function(){	
		$("#result_span").text("");		
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

	//아이디 중복확인을 위한 변수
	var isCheckId = false;

	//아이디 중복확인 체크
	$("#btn_id_check").click(function(){
		var check_user_id = $("input[name=user_id_r]").val();
		
		//아이디는 영문자와 숫자만 입력할 수 있도록 검사
		for (var v=0; v < check_user_id.length; v++) { //각각의 코드값을 알아내 아이디 유효성 체크 
				var keyCode = check_user_id.charCodeAt(v);
				//영문자(97<=keyCode && keyCode<=122)  //숫자(48<=keyCode && keyCode<=57)
	 	 		if ( !(97 <= keyCode && keyCode <= 122) && !(48 <= keyCode && keyCode <= 57) ) { 	
					alert("유효하지 않은 아이디입니다.\n영문자와 숫자 조합으로 입력하세요.");
					$("input[name=user_id_r]").val("").focus();
					return false; 
				} //if
		} //for
		
		var sData = { "check_user_id" : check_user_id }
					
		$.get("check-id.ajax-cy", sData, function(rData){
			var data = rData.trim();
			
			if(data == "can_not_be_used_id"){
				$("#result_span").text("사용중인 아이디입니다.");
			}else if(data == "available_id"){
				$("#result_span").text("사용 가능한 아이디입니다.");
				isCheckId = true;
			}
			
		}); //$.get
	}); //$("#btn_id_check").click
	
	//아이디 입력칸에 keyevent 발생시 아이디 중복체크를 다시 받도록 설정
	$("input[name=user_id_r]").keyup(function(e) {
		isCheckId = false;
		$("#result_span").text("");
	});

	//회원가입시
	//필수값 입력 공백검사
	//비밀번호와 비밀번호 재입력 값 체크
	$("#register_form").submit(function(){
		var user_id = $("input[name=user_id_r]").val();
		var passwd = $("input[name=user_passwd_r]").val();
		var passwd2 = $("input[name=user_passwd_r2]").val();
		
		//비밀번호와 비밀번호 재입력 값 체크
		if(passwd!=passwd2){
			$("input[name=user_passwd_r2]").focus();
			alert("비밀번호와 비밀번호입력이 일치하지 않습니다.");
			return false;			
		}
		
		//아이디 중복 체크 여부 검사
		if(isCheckId == false){
			alert("아이디 중복 체크를 해주세요.");
			return false;
		}
		
		//아이디는 영문자와 숫자만 입력할 수 있도록 검사
		for (var v=0; v < user_id.length; v++) { //각각의 코드값을 알아내 아이디 유효성 체크 
				var keyCode = user_id.charCodeAt(v);
				//영문자(97<=keyCode && keyCode<=122)  //숫자(48<=keyCode && keyCode<=57)
	 	 		if ( !(97 <= keyCode && keyCode <= 122) && !(48 <= keyCode && keyCode <= 57) ) { 	
					alert("유효하지 않은 아이디입니다.\n영문자와 숫자 조합으로 입력하세요.");
					$("input[name=user_id_r]").val("").focus();
					return false; 
				} //if
		} //for
		
		$("#register_form").submit();
	});		
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
					<input type="text" class="form-control" name="user_id" placeholder="ID*" maxlength="20" required/>
				</div>
				<div class="form-group">
<!-- 					<input type="text" class="form-control" name="user_passwd" placeholder="PASSWD*" maxlength="20" required/> -->
					<input type="password" class="form-control" name="user_passwd" placeholder="PASSWD*" maxlength="20" required/>
				</div>
				<button type="submit" class="btn btn-block btn-outline-danger">LOGIN</button>
			</form>
<!-- LOGIN FORM	END -->
<!-- REGISTER FORM START-->		
			<form name="registerForm" action="login-register-pro.cy" method="post" id="register_form">
			
				<div class="row">
				<div class="col-md-8">
				<div class="form-group">
						<input type="text" class="form-control" name="user_id_r" placeholder="ID*" maxlength="20" required/>
					</div>
				</div>
				<div class="col-md-4">
					<button type="button" class="btn btn-outline-danger btn-block" id="btn_id_check">
						CHECK
					</button>
				</div>
				</div>
				
				<div class="form-group">
					<input type="text" class="form-control" name="user_name_r" placeholder="NAME*" maxlength="20" required/>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name="user_passwd_r" placeholder="PASSWD*" maxlength="20" required/>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name="user_passwd_r2" placeholder="RETYPE PASSWD*" maxlength="20" required/>
				</div>
				<button type="submit" class="btn btn-block btn-outline-danger" id="btn_register">REGISTER</button>
			</form>
<!-- REGISTER FORM END-->			
		</div>
		
		<div class="col-md-4">
			 <span id="result_span"></span>
		</div>
	</div>
</div>


<br>

<%@ include file="include/footer.jsp" %>
