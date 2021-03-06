package com.yeahajeong.hastagram.controller;

import com.yeahajeong.hastagram.domain.Login;
import com.yeahajeong.hastagram.domain.User;
import com.yeahajeong.hastagram.repository.UserRepository;
import com.yeahajeong.hastagram.service.UserService;
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
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
//    @Autowired
//    private ProfileImageService profileImageService;
//    @Autowired
//    private ProfileImageRepository profileImageRepository;

    /* ******************** 회원 가입 로직 ******************** */
    //회원가입 페이지 join.jsp 열람 요청
    @GetMapping("/join")
    public ModelAndView join() throws Exception {
        return new ModelAndView("user/join");
    }

    //회원가입 처리 요청
    @PostMapping("")
    public String register(@RequestBody User user) throws Exception {
        userService.register(user);
        return "joinSuccess";
    }

    //회원 이메일 인증 요청
    @GetMapping("/emailauth")
    public ModelAndView emailConfirm(@RequestParam(value = "email")String email, @RequestParam(value = "authkey") String authkey) throws Exception {
        User user = userRepository.findUserByEmail(email);
        if (user.getAuthKey().equals(authkey)) {
            user.setAuthStatus("Y");
            userRepository.save(user);
        }
        return new ModelAndView("user/emailauth");
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


    /* ******************** 로그인 로직 ******************** */
    //로그인 검증 요청
    @PostMapping("/loginCheck")
    public String login(@RequestBody Login login, HttpSession session) {
        String result = null;
        logger.info("login 확인 = " + login);
        //로그인 시도한 회원의 모든 정보를 가져옴
        User loginTryUser = userRepository.findUserById(login.getId());

        logger.info("로그인한 회원의 정보 : " + loginTryUser);

        //로그인 시도한 회원이 존재하는 경우 -> 가입한 회원 -> 비밀번호 확인 필요
        if (loginTryUser != null) {

            if (loginTryUser.getAuthStatus() == null) {
                //승인되지 않은 회원
                result = "nonApproval";
            } else {
                if (encoder.matches(login.getPw(), loginTryUser.getPw())) {
                    logger.info("비밀번호 일치합니다.");
                    //비밀번호 일치 -> 로그인 성공
                    //로그인 성공시 로그인 유지를 해주어야함 -> 세션사용
                    //login이라는 이름의 세션에 로그인한 사람의 전체 정보를 저장한다.
                    session.setAttribute("login", loginTryUser);
                    logger.info("세션 저장 성공!");
                    //브라우저 닫을 때까지 혹은 세션 유효기간이 만료되기 전까지 세션이 사용됨
                    //session.setMaxInactiveInterval(60 * 60); //세션 만료시간을 1시간으로 설정
                    result = "loginSuccess";
                } else {
                    //비밀번호 불일치
                    result = "pwFail";
                }
            }

        //가입된 회원이 존재하지 않는 경우
        } else {
            result = "emailFail";
        }
        return result;
    }


    /* ******************** 로그아웃 로직 ******************** */
    //로그아웃 요청
    @GetMapping("/logout")
    public ModelAndView logout(HttpSession session) throws Exception {

        //세션에서 login정보 가져옴
        Object o = session.getAttribute("login");
        //세션에 로그인 정보가 있다면
        if (o != null) {
            session.removeAttribute("login"); //login세션 없앰
            session.invalidate();               //세션의 정보 초기화
        }
        return new ModelAndView("redirect:/");
    }


    /* ******************** 회원정보 변경 로직 ******************** */
    //회원정보 변경 페이지 update.jsp 열람 요청
    @GetMapping("/update")
    public ModelAndView modify() throws Exception {
        return new ModelAndView("user/update");
    }

    //회원정보 변경 요청
    @PostMapping("/update")
    public String modify(@RequestBody User user, HttpSession session) throws Exception {
        String result;
        User login = (User) session.getAttribute("login");

        //비밀번호는 그대로
        user.setPw(login.getPw());

        //소셜 여부도 등록을 해주어야한다.
        if(login.getSocial() != null){
            user.setSocial(login.getSocial());
        }
        if(login.getAuthKey() != null){
            user.setAuthKey(login.getAuthKey());
        }
        if (login.getAuthStatus() != null) {
            user.setAuthStatus(login.getAuthStatus());
        }

        //아이디와 이메일 존재 확인
        User idCheck = userRepository.findUserById(user.getId());
        User emailCheck = userRepository.findUserByEmail(user.getEmail());

        //변경을 위해 값을 확인하는 로직 -> 지져분하네ㅠㅠ
        if (user.getEmail().equals(login.getEmail())) { //이메일이 같음
            if (user.getId().equals(login.getId())) { //아이디가 같음
                // => 이메일과 아이디가 그 전에 있던거랑 같으면 변경진행
                userService.update(user);
                result = "updateSuccess";
            } else { //아이디가 다름
                // => 이메일은 같은데 아이디가 다르면 아이디 중복확인 필요
                if (idCheck != null) {
                    result = "idFail";
                } else {
                    userService.update(user);
                    result = "updateSuccess";
                }
            }

        } else { //이메일이 다름
            if (user.getId().equals(login.getId())) { //아이디가 같음
                // => 이메일이 다르고 아이디가 같으면 이메일 중복확인 필요
                if (idCheck != null) {
                    result = "emailFail";
                } else {
                    userService.update(user);
                    result = "updateSuccess";
                }

            } else { //아이디가 다름
                // => 이메일, 아이디 둘 다 다르면 둘 다 중복확인 필요
                if (idCheck != null) {
                    result = "idFail";
                } else if (emailCheck != null) {
                    result = "emailFail";
                } else {
                    userService.update(user);
                    result = "updateSuccess";
                }
            }
        }

        if (result.equals("updateSuccess")) {
            Login updateUser = new Login();
            updateUser.setId(user.getId());

            User updateU = userRepository.findUserById(updateUser.getId());
            session.setAttribute("login", updateU);
            System.out.println("updateU = " + updateU);
        }

        return result;
    }

    //pw-change.jsp 페이지 열람 요청
    @GetMapping("/pw-change")
    public ModelAndView pwChange() {
        return new ModelAndView("user/pw-change");
    }

    //비밀번호 확인 처리 요청
    @PostMapping("/checkPw")
    public String checkPw(@RequestBody String pw, HttpSession session) throws Exception {
        String result;

        User dbUser = (User) session.getAttribute("login");

        if (encoder.matches(pw, dbUser.getPw())) {
            result = "pwConfirmOK";
        } else {
            result = "pwConfirmNO";
        }
        return result;
    }

    //비밀번호 변경 요청
    @PostMapping("/pw-change")
    public String pwChange(@RequestBody User user, HttpSession session) throws Exception {
        //비밀번호 변경
        userService.pwSave(user);

        User updateUser = userRepository.findUserById(user.getId());
        session.setAttribute("login", updateUser);

        return "changeSuccess";
    }


    /* ******************** 비밀번호 찾기 로직 ******************** */
    //pw-find.jsp 페이지 열람 요청
    @GetMapping("/pw-find")
    public ModelAndView findPw() {
        return new ModelAndView("user/pw-find");
    }

    //비밀번호 찾기 (메일 발송) 요청
    @PostMapping("/pw-find")
    public String findPw(@RequestBody String email) throws Exception {
        User user = userRepository.findUserByEmail(email);
//        logger.info("비밀번호 찾기 컨트롤러 로직 user : " + user);

        return userService.findPw(email);
    }


    /* ******************** 회원 탈퇴 로직 ******************** */
    //withdrawal.jsp 페이지 요청
    @GetMapping("/withdrawal")
    public ModelAndView withdrawal() {
        return new ModelAndView("user/withdrawal");
    }

    //탈퇴 요청
    @PostMapping("/withdrawal")
    public String withdrawal(@RequestBody User user, HttpSession session) throws Exception {
        String result = checkPw(user.getPw(), session);

        if (result.equals("pwConfirmOK")) {
            //탈퇴시키고
            userService.withdrawal(user);

            //로그인 세션 삭제
            Object object = session.getAttribute("login");
            if (object != null) {
                session.removeAttribute("login");
                session.invalidate();
            }
            result = "Success";
        } else {
            //비번 틀림
            result = "Fail";
        }
        return result;
    }


/*    *//* 프로필 사진 로직 *//*
    //프로필 사진 등록 요청
    @PostMapping("/profile/upload")
    public ModelAndView photoUpload(@RequestParam("file") MultipartFile file, @RequestParam("userNo") Long userNo, HttpSession session) throws Exception {

        ProfileImage profileImgfile = new ProfileImage();
        profileImgfile.setFileName(file.getOriginalFilename());
        profileImgfile.setFileSize(file.getSize());
        profileImgfile.setFileContentType(file.getContentType());
        profileImgfile.setFileData(file.getBytes());
        profileImgfile.setUser(userRepository.findUserByUserNo(userNo));

        profileImageService.save(profileImgfile);
        session.setAttribute("login", userRepository.findUserByUserNo(userNo));

        return new ModelAndView("redirect:/user/update");
    }

    //프로필 사진 불러오기 요청
    @RequestMapping("/profile/{userNo}")
    public ResponseEntity<byte[]> getProfile(@PathVariable Long userNo) throws Exception {

        ProfileImage profile = profileImageRepository.findProfileImageByUser_UserNo(userNo);

        //파일을 클라이언트로 전송하기 위해 전송정보를 담을 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        String[] ftypes = profile.getFileContentType().split("/");
        //전송헤더에 파일정보와 확장자를 셋팅.
        headers.setContentType(new MediaType(ftypes[0], ftypes[1]));
        //전송헤더에 파일 용량을 셋팅
        headers.setContentLength(profile.getFileSize());
        //전송헤더에 파일명을 셋팅
        headers.setContentDispositionFormData("attachment", profile.getFileName());

        return new ResponseEntity<byte[]>(profile.getFileData(), headers, HttpStatus.OK);
    }

    //프로필 사진 삭제 요청
    @PostMapping("/profile/delete")
    public ModelAndView photoDelete(Long userNo, HttpSession session) throws Exception {

        profileImageRepository.deleteProfileImageByUser_UserNo(userNo);
        session.setAttribute("login", userRepository.findUserByUserNo(userNo));

        return new ModelAndView("redirect:/user/update");
    }*/
}