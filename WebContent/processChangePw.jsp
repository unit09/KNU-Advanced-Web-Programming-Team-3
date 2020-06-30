<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="login.AccountDataHandler"%>


<%
	request.setCharacterEncoding("utf-8");
	
	String newPw = request.getParameter("input-pw-new").toString();
	
	AccountDataHandler adh = new AccountDataHandler();
	adh.setPw(session.getAttribute("userId").toString(), newPw);
	adh.close();
	
	session.setAttribute("userPw", newPw);
	
	response.sendRedirect("myPage.jsp");
%>