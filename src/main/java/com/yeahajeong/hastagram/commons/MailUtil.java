package com.yeahajeong.hastagram.commons;

import com.yeahajeong.hastagram.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;

//메일을 보낼 클래스
public class MailUtil {

    @Autowired
    public JavaMailSender mailSender;

    private static final String FROM_EMAIL = "dev_hado@naver.com";
    private static final String FROM_NAME = "HASTAGRAM";

    public void sendMail(User user) throws Exception {
        System.out.println("메일 보내는 곳!!!!");
        System.out.println("user = " + user);

        String subject = ""; 	//메일 제목
        String msg = "";		//메일 내용
        subject = "[HASTAGRAM] 임시 비밀번호 발급 안내";
        msg += "<div align='left'>";
        msg += "<h3>";
        msg += user.getId() + "님의 임시 비밀번호입니다.<br>비밀번호를 변경하여 사용하세요.</h3>";
        msg += "<p>임시 비밀번호 : ";
        msg += user.getPw() + "</p></div>";

//        String mailRecipient = user.getEmail(); //받는 사람 이메일 주소


        /*try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(mailRecipient);       //받는 사람 주소
            message.setFrom(FROM_EMAIL);        //보내는 사람 주소 - 해당 메서드를 호출하지않으면 설정파일에 작성한 username으로 세팅됨
            message.setSubject(subject);        //제목
            message.setText(msg);               //메시지 내용

            mailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }*/
    }
}
