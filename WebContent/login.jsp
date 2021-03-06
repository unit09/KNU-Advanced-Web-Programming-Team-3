<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/login.css"></link>
<title>로그인</title>
</head>
<body>
<%@ include file="header.jsp" %>
	<div class="container text-center p-3">
		<form class="form-login text-center jumbotron" action="processLogin.jsp" method="post">
			<h1 class="mb-3 text-secondary">로그인</h1>
			<input type="text" id="input-id" name="input-id" class="mb-2 p-2 border border-secondary form-control" placeholder="ID" required>
			<input type="password" id="input-pw" name="input-pw" class="mb-2 p-2 border border-secondary form-control" placeholder="Password" required>
			<div class="small text-secondary mb-3"><a href="./signup.jsp" class="text-primary">아직도 회원이 아니신가요?</a></div>
			<button type="submit" class="btn btn-success btn-block">로그인</button>
		</form>
	</div>

<%@ include file="footer.jsp" %>
</body>
</html>