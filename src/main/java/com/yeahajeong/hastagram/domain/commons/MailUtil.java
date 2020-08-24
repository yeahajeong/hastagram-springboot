package com.yeahajeong.hastagram.domain.commons;

import com.yeahajeong.hastagram.domain.user.User;
import org.apache.commons.mail.HtmlEmail;

//메일을 보낼 클래스
public class MailUtil {

    public void sendMail(User user) throws Exception {

        //Mail Server 설정
        String charSet = "utf-8";
        String hostSMTP = "smtp.naver.com";		//SMTP 서버명
        String hostSMTPid = "dev_hado"; 		//네이버 아이디
        String hostSMTPpw = "2020hastagram!"; 	//네이버 비밀번호

        //보내는 사람
        String fromEmail = "dev_hado@naver.com";	//보내는 사람 메일
        String fromName = "HASTAGRAM";			//보내는 사람 이름

        String subject = ""; 	//메일 제목
        String msg = "";		//메일 내용

        subject = "[HASTAGRAM] 임시 비밀번호 발급 안내";
        msg += "<div align='left'>";
        msg += "<h3>";
        msg += user.getId() + "님의 임시 비밀번호입니다.<br>비밀번호를 변경하여 사용하세요.</h3>";
        msg += "<p>임시 비밀번호 : ";
        msg += user.getPw() + "</p></div>";

        //email 전송
        String mailRecipient = user.getEmail(); //받는 사람 이메일 주소
        try {
            //객체 선언
            HtmlEmail mail = new HtmlEmail();
            mail.setDebug(true);
            mail.setCharset(charSet);
            mail.setSSLOnConnect(true); //SSL 사용 (TLS가 없는 경우에 SSL사용)
            mail.setHostName(hostSMTP);
            mail.setSmtpPort(587); 		//SMTP 포트 번호
            mail.setAuthentication(hostSMTPid, hostSMTPpw);
            mail.setStartTLSEnabled(true); //TLS 사용
            mail.addTo(mailRecipient, charSet);
            mail.setFrom(fromEmail, fromName, charSet);
            mail.setSubject(subject);
            mail.setHtmlMsg(msg);
            mail.send();


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
