<%@page import="java.util.Random"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.SMTPAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page contentType="text/html; charset=utf-8"%>

<%!
	String code = "";


	//A-Z 대문자 랜덤 발생 (함수명은 getRandomCHAR인데 char가 아니라 1개짜리 String을 반환함에 주의)
	public String getRandomChar() {
		Random r = new Random();
		return String.valueOf((char) ((int) (r.nextInt(26)) + 65)); //A-Z 아스키코드 65~90
	}

	//0-9 랜덤 발생 (String 형태)
	public String getRandomDigit() {
		Random r = new Random();
		return String.valueOf(r.nextInt(10)); //0~9
	}
%>

<%
	request.setCharacterEncoding("utf-8");
	
	
	//인증코드 생성 (숫자 문자 문자 숫자 문자로 구성되어있음, 영어-숫자-영어-영어-숫자로 총 5자리)
	code = "";
	code += getRandomChar();
	code += getRandomDigit();
	code += getRandomChar();
	code += getRandomChar();
	code += getRandomDigit();
	
	new Thread(new Runnable() {
		@Override
		public void run() {
			
			
			String email = request.getParameter("email").toString(); //회원 이메일
			
			Properties p = new Properties(); //stmp 서버에 접속하기 위한 정보를 담을 객체
			p.put("mail.smtp.host", "gmail-smtp.l.google.com");
			p.put("mail.smtp.starttls.enable", "true");
			p.put("mail.smtp.auth", "true");
			p.put("mail.smtp.debug", "true");
			p.put("mail.smtp.socketFactory.port", "465");
			p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			p.put("mail.smtp.socketFactory.fallback", "false");
			
			
			
			try {
				
				Authenticator auth = new SMTPAuthenticator();
				Session ses = Session.getInstance(p, auth);
				
				ses.setDebug(true);
				
				MimeMessage msg = new MimeMessage(ses); //메일 내용을 담을 객체
				msg.setSubject("회원가입 인증코드"); //메일 제목
				
				Address fromAddr = new InternetAddress("toonraon5@gmail.com"); //보내는 이메일 주소
				msg.setFrom(fromAddr);
				
				Address toAddr = new InternetAddress(email); //받을 이메일 주소
				msg.addRecipient(Message.RecipientType.TO, toAddr);
				
				
				msg.setContent("아래 인증 코드를 회원가입 페이지에서 입력해주십시오.<br><br><h1>" + code + "</h1>", "text/html;charset=UTF-8"); //이메일 내용
				
				Transport.send(msg);
				
				System.out.println("메일을 성공적으로 전송하였습니다.");
				
				
			} catch(Exception e) {
				
			}
			
			
		}
	}).start();

	
%>

<script type="text/javascript">
	//안 보이는 hidden input에 인증코드 저장 (인증코드 확인 버튼 눌렀을 때 제대로 쳤는지 비교하기 위해서)
	opener.document.getElementById("code-check").value = "<%=code%>";
	
	//alert 띄우기
	var classList = opener.document.getElementById("code-send-alert").classList;
	classList.remove("d-none");
	classList.add("show");
	
	window.close();
</script>
