package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("toonraon5@gmail.com", "rhdnpqvm321!"); //�߽ſ� �̸��� id pw ����
	}
	
}
