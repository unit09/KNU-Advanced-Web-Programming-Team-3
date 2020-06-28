<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="login.AccountDataHandler"%>

<!DOCTYPE html>
<html>
<head>
<!-- <link type="text/css" rel="stylesheet" href="./css/login.css"></link> -->
<link type="text/css" rel="stylesheet" href="./css/myPage.css"></link>

<title>마이 페이지</title>
</head>
<body>
<%@ include file="header.jsp" %>
	<div class="wrapper">
		<nav class="sidebar">
			<div class="">
				<ul class="nav flex-column">
					<%@ include file="myPageSidebar.jsp" %>
				</ul>
			</div>
		</nav>
		<div class="content container text-center p-3">
			<form class="form-mypage text-center jumbotron pt-4 pb-4" action="processChangePw.jsp" method="post" onsubmit="return changePw();">
				<h1 class="mb-5 text-secondary">회원 정보</h1>
				
				<h5 class="input-title">이름</h5>
				<input type="text" id="input-name" name="input-name" class="mb-4 p-2 border border-secondary form-control" value="<%=session.getAttribute("userName")%>" readonly>
				
				<h5 class="input-title">ID</h5>
				<input type="text" id="input-id" name="input-id" class="mb-4 p-2 border border-secondary form-control" value="<%=session.getAttribute("userId")%>" readonly>
				
				<h5 class="input-title">이메일</h5>
				<input type="text" id="input-email" name="input-id" class="mb-4 p-2 border border-secondary form-control" value="<%=session.getAttribute("userEmail")%>" readonly>
				
				<h5 class="mt-4 input-title">현재 비밀번호</h5>
				<input type="password" id="input-pw" name="input-pw" class="mb-1 p-2 border border-secondary form-control" onkeyup="checkPw(this.value, '<%=session.getAttribute("userPw").toString()%>')" required>
				<h5 id="check-pw-feedback" class="mb-4 invalid-feedback text-left d-block fade show">비밀번호가 다릅니다.</h5>
				
				<h5 class="input-title">변경할 비밀번호 <small class="text-secondary">8~20자리 사이 영문자와 숫자 혼합</small></h5>
				<input type="password" id="input-pw-new" name="input-pw-new" class="p-2 border border-secondary form-control" required>
				<button type="submit" class="mb-1 btn btn-success btn-block btn-sm mt-3">변경</button>
			</form>
		</div>
	</div>

<%@ include file="footer.jsp" %>
<script src="./js/myPage.js"></script>
</body>
</html>