package com.yeahajeong.hastagram.service;

import com.yeahajeong.hastagram.commons.TempKey;
import com.yeahajeong.hastagram.controller.UserController;
import com.yeahajeong.hastagram.domain.User;
import com.yeahajeong.hastagram.repository.FollowRepository;
import com.yeahajeong.hastagram.repository.PostRepository;
import com.yeahajeong.hastagram.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import javax.transaction.Transactional;
import java.util.UUID;

@Service
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private FollowRepository followRepository;
/*    @Autowired
    private ProfileImageRepository profileImageRepository;*/

    @Value("${my.root}")
    private static String ROOT;


    //화원가입
    public void register(User user) throws Exception {
        String securePassword = encoder.encode(user.getPw());
        user.setPw(securePassword);

        //임의의 authKey 생성
        String authKey = new TempKey().getKey(50, false);
        user.setAuthKey(authKey);

        //회원가입시 본인인증을 위한 메일 발송
        String subject = "";    //메일 제목
        String msg = "";        //메일 내용
        subject = "[HASTAGRAM] 회원가입 본인인증 안내";
        msg += "<div align='left'>";
        msg += "<h3>아래 링크를 클릭하면 이메일 인증이 완료됩니다.</h3>";
        msg += "<p><a href='http://ec2-3-35-126-40.ap-northeast-2.compute.amazonaws.com:8080/user/emailauth?email=";
//        msg += "<p><a href='http://localhost:8080/user/emailauth?email=";
        msg += user.getEmail() + "&authkey=";
        msg += user.getAuthKey() + "' target='_blank'>이메일 인증 확인</a></p></div>";

        try {
//            SimpleMailMessage message = new SimpleMailMessage();
//            message.setTo(user.getEmail());         //받는 사람 주소
//            message.setFrom("dev_hado@naver.com");  //보내는 사람 주소 - 해당 메서드를 호출하지않으면 설정파일에 작성한 username으로 세팅됨
//            message.setSubject(subject);            //제목
//            message.setText(msg);                   //메시지 내용

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
            messageHelper.setSubject(subject);
            messageHelper.setText(msg, true);
            messageHelper.setTo(user.getEmail());
            messageHelper.setFrom("dev_hado@naver.com", "하스타그램");

            mailSender.send(message);

            //user등록
            userRepository.save(user);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(User user) throws Exception {
        //엔터키와 스페이스바 처리 제약 로직을 게시글 등록시에 처리
        String adjustIntro = user.getIntro()
                .replace("\n", "<br>")
                .replace("u0020", "&nbsp;");

        user.setIntro(adjustIntro);

        userRepository.save(user);
    }

    public void pwSave(User user) throws Exception {
        String securePw = encoder.encode(user.getPw());
        user.setPw(securePw);
        userRepository.save(user);
    }

    @Transactional
    public String findPw(String email) throws Exception {
        System.out.println("서비스 단 email = " + email);
        User user = userRepository.findUserByEmail(email);
//        entityManager.persist(user); //영속상태로 만들어줌
//        entityManager.flush(); //DB에 저장
        System.out.println("유저 확인 user = " + user);

        String result = "";

        if (user != null) {//가입된 아이디가 존재할 경우
            if (user.getSocial() != null) {
                //소셜 로그인은 비밀번호 찾기 발송할 수 없음
                result = "Social";
            } else {
                //이메일 발송해야함!
                //임시 비밀번호 생성(UUID 이용 - 특수문자는 못넣음 ㅠㅠ)
                String tempPw = UUID.randomUUID().toString().replace("-", ""); // -를 제거
                tempPw = tempPw.substring(0, 10); //tempPw를 앞에서부터 10자리 잘라줌

                //임시 비밀번호 세팅
                user.setPw(tempPw);

                String subject = ""; 	//메일 제목
                String msg = "";		//메일 내용
                subject = "[HASTAGRAM] 임시 비밀번호 발급 안내";
                msg += "<div align='left'>";
                msg += "<h3>";
                msg += user.getId() + "님의 임시 비밀번호입니다.<br>비밀번호를 변경하여 사용하세요.</h3>";
                msg += "<p>임시 비밀번호 : ";
                msg += tempPw + "</p></div>";

//                Mail mail = new Mail();
//                mail.sendMail(subject, msg, user);
                try {
//                    SimpleMailMessage message = new SimpleMailMessage();
//                    message.setTo(user.getEmail());         //받는 사람 주소
//                    message.setFrom("dev_hado@naver.com");  //보내는 사람 주소 - 해당 메서드를 호출하지않으면 설정파일에 작성한 username으로 세팅됨
//                    message.setSubject(subject);            //제목
//                    message.setText(msg);                   //메시지 내용

                    MimeMessage message = mailSender.createMimeMessage();
                    MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
                    messageHelper.setSubject(subject);
                    messageHelper.setText(msg, true);
                    messageHelper.setTo(user.getEmail());
                    messageHelper.setFrom("dev_hado@naver.com", "하스타그램");

                    mailSender.send(message);

                } catch (Exception e) {
                    e.printStackTrace();
                }

                //회원 비밀번호를 암호화하여 다시 세팅
                String securePw = encoder.encode(user.getPw());
                user.setPw(securePw);

                //비밀번호 변경
                userRepository.save(user);
                result = "Success";
            }
        } else {
            result = "Fail";
        }
        return result;
    }

    //회원 탈퇴 -> 유저정보, 유저의게 시물, 유저의 팔로우 삭제
    @Transactional
    public void withdrawal(User user) throws Exception {

        postRepository.deletePostByUser_UserNo(user.getUserNo()); //관련 게시글 삭제
        followRepository.deleteFollowByActiveUser_UserNo(user.getUserNo()); //팔로우 삭제
//        profileImageRepository.deleteProfileImageByUser_UserNo(user.getUserNo()); //프로필 삭제

        userRepository.delete(user); //탈퇴 진행
    }

}
