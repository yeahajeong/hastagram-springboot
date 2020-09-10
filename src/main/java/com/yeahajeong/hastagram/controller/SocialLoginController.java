package com.yeahajeong.hastagram.controller;

import com.yeahajeong.hastagram.domain.User;
import com.yeahajeong.hastagram.repository.UserRepository;
import com.yeahajeong.hastagram.service.KakaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping(value = "social_login")
public class SocialLoginController {

    @Autowired
    private KakaoService kakaoService;
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/kakao")
    public String kakaoLogin(@RequestParam("code") String code, HttpSession session) throws Exception {

        //사용자 토큰 얻기
        String accessToken = kakaoService.getAccessToken(code);
        //사용자 토큰을 통해 사용자 정보 얻기
        Map<String, Object> userData = kakaoService.getKakaoUserData(accessToken);

        String email = (String)userData.get("email");
        String name = (String)userData.get("nickname");

//        int idx = email.indexOf("@");
        String id = email.substring(0, email.indexOf("@"));
        System.out.println("id = " + id);

        User user = userRepository.findUserByEmail(email);
        User newUser = new User();
        if (user != null) {
            //회원이 존재하니까 로그인 시키면 됨
            session.setAttribute("access_token", accessToken);
            session.setAttribute("login", user);
        } else {
            //회원이 존재하지 않아서 가입시킨 후에 로그인
            if (userRepository.findUserById(id) != null) {
                //아이디가 존재하면 난수생성해서 중복안되게 하기
                id += String.valueOf((int)(Math.random()*10000));
            }
            newUser.setId(id);
            newUser.setEmail(email);
            newUser.setName(name);
//            newUser.setPw("1111");
            newUser.setSocial("kakao");
            userRepository.save(newUser);
            session.setAttribute("login", newUser);
        }
        return "redirect:/post/list";
    }

    //로그아웃 요청 처리
    @GetMapping("/logout")
    public String logout(HttpSession session) throws Exception {

        kakaoService.kakaoLogout((String)session.getAttribute("access_token"));

        session.invalidate();

        return "redirect:/";
    }
}
