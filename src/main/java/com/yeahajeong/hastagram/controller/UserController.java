package com.yeahajeong.hastagram.controller;

import com.yeahajeong.hastagram.domain.Login;
import com.yeahajeong.hastagram.domain.User;
import com.yeahajeong.hastagram.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    @Autowired
    private UserRepository userRepository;

    /* ************** 회원 가입 로직 ************** */
    //회원가입 페이지 join.jsp 열람 요청
    @GetMapping("/join")
    public ModelAndView join() throws Exception {
        return new ModelAndView("user/join");
    }

    //회원가입 처리 요청
    @PostMapping("")
    public String register(@RequestBody User user) throws Exception {

        String rawPassword = user.getPw();
        String securePassword = encoder.encode(rawPassword);
        user.setPw(securePassword);
        userRepository.save(user);
        return "joinSuccess";
    }

    //이메일 중복확인 체크 요청
    @PostMapping("/emailCheck")
    public Map<String, Object> comfirmEmail(@RequestBody String userEmail) throws Exception {
        //클라이언트에 비동기 통신으로 받아야하니까 @RequestBody 사용

        Map<String, Object> data = new HashMap<>();
        if (userRepository.findUserByEmail(userEmail) == null) {
            //이메일 사용 가능
            data.put("confirm", "OK");
        } else {
            //이메일 중복! 사용 불가
            data.put("confirm", "NO");
        }
        return data;
    }

    //아이디 중복확인 체크 요청
    @PostMapping("/idCheck")
    public Map<String, Object> confirmId(@RequestBody String userId) throws Exception {

        Map<String, Object> data = new HashMap<>();
        if (userRepository.findUserById(userId) == null) {
            //아이디 사용 가능
            data.put("confirm", "OK");
        } else {
            //아이디 중복! 사용 불가
            data.put("confirm", "NO");
        }
        return data;
    }


    /* ************** 로그인 로직 ************** */
    //로그인 검증 요청
    @PostMapping("/loginCheck")
    public String login(@RequestBody Login login, HttpSession session) {
        String result = null;
        //로그인 시도한 회원의 모든 정보를 가져옴
        User loginTryUser = userRepository.findUserById(login.getId());

        logger.info("로그인한 회원의 정보 : " + loginTryUser);

        //로그인 시도한 회원이 존재하는 경우 -> 가입한 회원 -> 비밀번호 확인 필요
        if (loginTryUser != null) {

            if (encoder.matches(login.getPw(), loginTryUser.getPw())) {
                //비밀번호 일치 -> 로그인 성공
                result = "loginSuccess";

                //로그인 성공시 로그인 유지를 해주어야함 -> 세션사용
                //login이라는 이름의 세션에 로그인한 사람의 전체 정보를 저장한다.
                session.setAttribute("login", loginTryUser);

                //브라우저 닫을 때까지 혹은 세션 유효기간이 만료되기 전까지 세션이 사용됨
                //session.setMaxInactiveInterval(60 * 60); //세션 만료시간을 1시간으로 설정

            } else {
                //비밀번호 불일치
                result = "pwFail";
            }

            //가입된 회원이 존재하지 않는 경우
        } else {
            result = "emailFail";
        }
        return result;
    }

}