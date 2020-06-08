<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp" %>
<link type="text/css" rel="stylesheet" href="./css/login.css"></link>
<title>로그인</title>
</head>
<body>

	<div class="container text-center">
		<form class="form-login text-center jumbotron" action="processLogin.jsp" method="post">
			<h1 class="mb-3 text-secondary">로그인</h1>
			<input type="text" id="input-id" name="input-id" class="mb-2 p-2 border border-secondary form-control" placeholder="ID" required>
			<input type="password" id="input-pw" name="input-pw" class="mb-2 p-2 border border-secondary form-control" placeholder="Password" required>
			<div class="small text-secondary mb-3"><a href="#" class="text-primary">ID 찾기</a> | <a href="#" class="text-primary">PW 찾기</a> | <a href="./signup.jsp" class="text-primary">회원가입</a></div>
			<button type="submit" class="btn btn-success btn-block">로그인</button>
		</form>
	</div>

<%@ include file="footer.jsp" %>
</body>
</html>