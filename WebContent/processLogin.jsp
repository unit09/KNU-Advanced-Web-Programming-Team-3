<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="login.AccountDataHandler"%>

<%
	request.setCharacterEncoding("utf-8");
	
	AccountDataHandler adh = new AccountDataHandler();

	String id = request.getParameter("input-id");
	String pw = request.getParameter("input-pw");
	
	if(adh.login(id, pw)) { //로그인 성공
		session.setAttribute("userId", id);
		session.setAttribute("userName", adh.getUserName(id));
		out.println(adh.getUserName(id) + "님이 로그인에 성공하였습니다.");
		
		//로그인 성공시 다른 페이지에서 user id를 받아오려면 session.getAttribue("userId");
		//로그인 성공시 다른 페이지에서 user 본명을 받아오려면 session.getAttribue("userName");
		
		
	} else { //로그인 실패
		out.println("로그인에 실패하였습니다.");
	}
	
	adh.close();

%>