<%@ page contentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html>
	<%@ include file="header.jsp" %>
	
	<body>
		<div class="jumbotron">
			<div class="container">
				<h1>Oops! 예매에 실패하였습니다</h1>
				<div style="margin-top:30px">
					<p>이미 예약된 좌석이거나 서버에 연결하는데 실패하였습니다. 다시 시도해주시기 바랍니다.
					<p>불편을 끼쳐드려서 죄송합니다.
				</div>
				<p>
					<a class="btn btn-primary btn-lg" href="./seats.jsp" role="button">되돌아가기 >></a>
				</p>
			</div>
		</div>

		<div style="height:250px">
		</div>

		<%@ include file="footer.jsp" %>		
	</body>
</html>