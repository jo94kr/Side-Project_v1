package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;

	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("testjo0321@gmail.com", "vmfhwprxm");
	}

	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}
