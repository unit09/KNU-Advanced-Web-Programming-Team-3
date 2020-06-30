<%@ page contentType="text/html; charset=utf-8"%>

<%
	session.removeAttribute("userId");
	session.removeAttribute("userPw");
	session.removeAttribute("userId");
	session.removeAttribute("userEmail");
	
	//무사히 로그아웃했다고 띄워주고 싶은데 방법 없나

	//response.sendRedirect("index.jsp");
%>

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
				title: "정상적으로 로그인하였습니다",
				icon: "success"
			}).then((result)=>{
				if(result){
					location.href = './index.jsp';
				}
			});
		</script>
	</body>
</html>