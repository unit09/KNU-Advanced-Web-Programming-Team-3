<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="login.AccountDataHandler"%>

<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/login.css"></link>
<title>회원가입</title>
</head>
<body>
<%@ include file="header.jsp" %>
	<div class="container text-center p-3">
		<form class="form-login text-center jumbotron pt-4 pb-4" action="./processSignUp.jsp" method="post" onsubmit="return checkAll()">
			<h1 class="mb-5 text-secondary">회원가입</h1>
			
			<h5 class="input-title">성명</h5>
			<input type="text" id="input-name" name="input-name" class="mb-4 p-2 border border-secondary form-control" required>
			
			<h5 class="input-title">ID</h5>
			<input type="text" id="input-id" name="input-id" class="mb-1 p-2 border border-secondary form-control" onkeydown="idCheckReset()" required>
			<button type="button" class="mb-1 btn btn-success btn-block btn-sm" id="idCheckButton" onClick="idCheck()">중복 확인</button>
			<div id="id-check-success-alert" class="alert alert-primary alert-dismissable fade small d-none" role="alert">
				<button type="button" class="close ml-2 -mt-5px" data-dismiss="" aria-label="Close">
					<span id="id-check-success-alert-x-button" aria-hidden="true" onClick="alertClose(this.id)">×</span>
				</button>
				해당 ID는 <strong>사용 가능</strong>합니다.
			</div>
			<div id="id-check-fail-alert" class="alert alert-danger alert-dismissable fade small d-none" role="alert">
				<button type="button" class="close ml-2 -mt-5px" data-dismiss="" aria-label="Close">
					<span id="id-check-fail-alert-x-button" aria-hidden="true" onClick="alertClose(this.id)">×</span>
				</button>
				해당 ID는 <strong>사용 할 수 없습니다</strong>.
			</div>
			<input type="hidden" id="id-check" name="id-check" class="mb-1 p-2 border border-secondary form-control" value="false"> <!-- 중복 검사 통과하면 value가 "true"가 됨(String임) -->
			
			<h5 class="mt-4 input-title">비밀번호</h5>
			<input type="password" id="input-pw" name="input-pw" class="mb-1 p-2 border border-secondary form-control" onkeyup="pwCheck(this.value); pwDoubleCheck()" required>
			<h5 id="pw-check-feedback" class="mb-4 invalid-feedback text-left d-block show fade">비밀번호는 영문자와 숫자를 포함하여 6~20자리이어야 합니다.</h5>
			
			<h5 class="input-title">비밀번호 확인</h5>
			<input type="password" id="input-pw-double-check" name="input-pw-check" class="p-2 border border-secondary form-control" onkeyup="pwDoubleCheck()" required>
			<h5 id="pw-double-check-feedback" class="mb-4 invalid-feedback text-left d-block fade">비밀번호와 다릅니다.</h5>
			
			
			<h5 class="input-title">이메일</h5>
			<div class="row">
				<div class="col-md-6 pr-0">
					<input type="text" id="input-email" name="input-email" class="mb-1 p-2 border border-secondary form-control" onkeydown="resetCode()" required>
				</div>
				<div class="col-md-6 pl-1">
					<select id="input-email-kind" name="input-email-kind" class="border border-secondary form-control" onchange="resetCode()">
						<option>@naver.com</option>
						<option>@gmail.com</option>
						<option>@daum.net</option>
					</select>
				</div>
			</div>
			<button type="button" class="mb-2 btn btn-success btn-block btn-sm" onclick="sendMail()">인증코드 전송</button>
			<div id="code-send-alert" class="alert alert-primary alert-dismissable d-none fade small" role="alert">
				<button type="button" class="close ml-2 -mt-5px" data-dismiss="" aria-label="Close">
					<span id="code-send-x-button" aria-hidden="true" onClick="alertClose(this.id)">×</span>
				</button>
				인증 코드를 발송하였습니다.
			</div>
			
			<h5 class="mt-4 input-title">이메일 인증코드</h5>
			<input type="text" id="input-email-code" name="input-email-code" class="mb-1 p-2 border border-secondary form-control" required>
			<button id="check-code-button" type="button" class="mb-1 btn btn-success btn-block btn-sm" onclick="checkCode()">인증코드 확인</button>
			<div id="code-success-alert" class="alert alert-primary alert-dismissable d-none fade small" role="alert">
				<button type="button" class="close ml-2 -mt-5px" data-dismiss="" aria-label="Close">
					<span id="code-success-x-button" aria-hidden="true" onClick="alertClose(this.id)">×</span>
				</button>
				인증 성공
			</div>
			<div id="code-fail-alert" class="alert alert-danger alert-dismissable d-none fade small" role="alert">
				<button type="button" class="close ml-2 -mt-5px" data-dismiss="" aria-label="Close">
					<span id="code-fail-x-button" aria-hidden="true" onClick="alertClose(this.id)">×</span>
				</button>
				인증 실패
			</div>
			<input type="hidden" id="code-check" name="code-check" class="mb-1 p-2 border border-secondary form-control" value="false">
			
			<button type="submit" class="mt-5 btn btn-primary btn-block">회원가입</button>
		</form>
	</div>

<%@ include file="footer.jsp" %>
<script src="./js/signup.js"></script>
</body>
</html>