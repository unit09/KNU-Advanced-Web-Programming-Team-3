package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("toonraon5@gmail.com", "rhdnpqvm321!"); //발신용 이메일 id pw 설정
	}
	
}
