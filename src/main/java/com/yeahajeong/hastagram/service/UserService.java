package com.yeahajeong.hastagram.service;

import com.yeahajeong.hastagram.domain.commons.MailUtil;
import com.yeahajeong.hastagram.domain.user.Login;
import com.yeahajeong.hastagram.domain.user.User;
import com.yeahajeong.hastagram.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.UUID;

@Service
public class UserService {

    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
    @Autowired
    private UserRepository userRepository;

    public void register(User user) throws Exception {
        String securePassword = encoder.encode(user.getPw());
        user.setPw(securePassword);
        userRepository.save(user);
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

    public String findPw(Login login) throws Exception {
        String result;
        //회원정보 불러오기
        User user = userRepository.findUserById(login.getId());

        //가입된 아이디가 존재할 경우 이메일 발송
        if (user != null) {
            //임시 비밀번호 생성(UUID 이용 - 특수문자는 못넣음 ㅠㅠ)
            String tempPw = UUID.randomUUID().toString().replace("-", ""); // -를 제거
            tempPw = tempPw.substring(0, 10); //tempPw를 앞에서부터 10자리 잘라줌

            //임시 비밀번호 세팅
            user.setPw(tempPw);

            //메일 전송
            MailUtil mail = new MailUtil();
            mail.sendMail(user);

            //회원 비밀번호를 암호화하여 다시 세팅
            String securePw = encoder.encode(user.getPw());
            user.setPw(securePw);

            //비밀번호 변경
            userRepository.save(user);

            result = "Success";
        } else {
            result = "Fail";
        }
        return result;
    }

    @Transactional
    public void withdrawal(User user) throws Exception {
        userRepository.delete(user);
    }

}
