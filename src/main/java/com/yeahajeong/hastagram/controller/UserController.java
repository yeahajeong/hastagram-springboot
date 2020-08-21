package com.yeahajeong.hastagram.controller;

import com.yeahajeong.hastagram.domain.User;
import com.yeahajeong.hastagram.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private BCryptPasswordEncoder encoder;

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
}