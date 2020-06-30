<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="login.AccountDataHandler"%>

<%
	request.setCharacterEncoding("utf-8");
	
	AccountDataHandler adh = new AccountDataHandler();

	String name = request.getParameter("input-name");
	String id = request.getParameter("input-id");
	String pw = request.getParameter("input-pw");
	String email = request.getParameter("input-email") + request.getParameter("input-email-kind");
	
	adh.signup(name, id, pw, email);
	
	out.println("회원가입에 성공하였습니다.");
	
	adh.close();

	//response.sendRedirect("login.jsp");
	
%>

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<title>CINE KNU</title>
	</head>
	<body>
		<script>
			swal({
				title: "회원가입에 성공하였습니다!",
				icon: "success"
			}).then((result)=>{
				if(result){
					location.href = './login.jsp';
				}
			});
		</script>
	</body>
</html>

