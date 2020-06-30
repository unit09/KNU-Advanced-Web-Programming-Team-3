<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="login.AccountDataHandler"%>

<%!
	boolean isAvailable = false;
%>

<%
	
	
	AccountDataHandler adh = new AccountDataHandler();

	String id = request.getParameter("id").toString();
	if(adh.idCheck(id)) { //id 중복 없으면
		isAvailable = true;
	} else {
		isAvailable = false;
	}

	adh.close();
	
	
%>

<script type="text/javascript">
	
	if(<%=isAvailable%>) {
		//show success alert
		var classList = opener.document.getElementById("id-check-success-alert").classList;
		classList.remove("d-none");
		classList.add("show");
		
		
		opener.document.getElementById("id-check").value = "true";
	} else {
		//show fail alert
		var classList = opener.document.getElementById("id-check-fail-alert").classList;
		classList.remove("d-none");
		classList.add("show");
		
		
		opener.document.getElementById("id-check").value = "false";
	}
	
	window.close();
</script>