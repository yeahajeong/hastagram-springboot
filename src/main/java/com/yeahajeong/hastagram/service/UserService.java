package com.yeahajeong.hastagram.service;

import com.yeahajeong.hastagram.commons.MailUtil;
import com.yeahajeong.hastagram.domain.Login;
import com.yeahajeong.hastagram.domain.User;
import com.yeahajeong.hastagram.repository.FollowRepository;
import com.yeahajeong.hastagram.repository.PostRepository;
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
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private FollowRepository followRepository;
/*    @Autowired
    private ProfileImageRepository profileImageRepository;*/

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

    //회원 탈퇴 -> 유저정보, 유저의게 시물, 유저의 팔로우 삭제
    @Transactional
    public void withdrawal(User user) throws Exception {

        postRepository.deletePostByUser_UserNo(user.getUserNo()); //관련 게시글 삭제
        followRepository.deleteFollowByActiveUser_UserNo(user.getUserNo()); //팔로우 삭제
//        profileImageRepository.deleteProfileImageByUser_UserNo(user.getUserNo()); //프로필 삭제

        userRepository.delete(user); //탈퇴 진행
    }

}
