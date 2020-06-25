<%@ page contentType="text/html; charset=utf-8"%>

<%
	session.removeAttribute("userId");
	session.removeAttribute("userName");
	
	//무사히 로그아웃했다고 띄워주고 싶은데 방법 없나

	response.sendRedirect("index.jsp");
%>