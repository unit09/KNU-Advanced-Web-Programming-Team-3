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
		<form class="form-login text-center jumbotron" action="./processSignUp.jsp" method="post">
			<h1 class="mb-5 text-secondary">회원가입</h1>
			
			<h5 class="input-title">성명</h5>
			<input type="text" id="input-name" name="input-name" class="mb-4 p-2 border border-secondary form-control" >
			
			<h5 class="input-title">ID</h5>
			<input type="text" id="input-id" name="input-id" class="mb-1 p-2 border border-secondary form-control" >
			<button class="mb-1 btn btn-success btn-block btn-sm">중복 확인</button>
			<div class="alert alert-primary alert-dismissable show fade small" role="alert">
				<button class="close ml-2 -mt-5px" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				해당 ID는 <strong>사용 가능</strong>합니다.
			</div>
			<div class="alert alert-danger alert-dismissable show fade small" role="alert">
				<button class="close ml-2 -mt-5px" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				해당 ID는 <strong>사용 할 수 없습니다</strong>.
			</div>
			
			<h5 class="mt-4 input-title">비밀번호</h5>
			<input type="password" id="input-pw" name="input-pw" class="mb-1 p-2 border border-secondary form-control" >
			<h5 class="mb-4 invalid-feedback text-left d-block">비밀번호는 영문자와 숫자를 포함하여 8자리 이상이어야 합니다.</h5>
			
			<h5 class="input-title">비밀번호 확인</h5>
			<input type="password" id="input-pw-check" name="input-pw-check" class="p-2 border border-secondary form-control" >
			<h5 class="mb-4 invalid-feedback text-left d-block">비밀번호와 다릅니다.</h5>
			
			
			<h5 class="input-title">이메일</h5>
			<div class="row">
				<div class="col-md-6 pr-0">
					<input type="text" id="input-email" name="input-email" class="mb-1 p-2 border border-secondary form-control" >
				</div>
				<div class="col-md-6 pl-1">
					<select class="border border-secondary form-control">
						<option>@naver.com</option>
						<option>@gmail.com</option>
					</select>
				</div>
			</div>
			<button class="mb-2 btn btn-success btn-block btn-sm">인증코드 전송</button>
			<div class="alert alert-primary alert-dismissable show fade small" role="alert">
				<button class="close ml-2 -mt-5px" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				인증 코드를 발송하였습니다.
			</div>
			
			<h5 class="mt-4 input-title">이메일 인증코드</h5>
			<input type="text" id="input-email-code" name="input-email-code" class="mb-1 p-2 border border-secondary form-control" >
			<button class="mb-1 btn btn-success btn-block btn-sm">인증코드 확인</button>
			<div class="alert alert-primary alert-dismissable show fade small" role="alert">
				<button class="close ml-2 -mt-5px" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				인증 성공
			</div>
			<div class="alert alert-danger alert-dismissable show fade small" role="alert">
				<button class="close ml-2 -mt-5px" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				인증 실패
			</div>
			
			<button type="submit" class="mt-5 btn btn-success btn-block">회원가입</button>
		</form>
	</div>

<%@ include file="footer.jsp" %>
</body>
</html>