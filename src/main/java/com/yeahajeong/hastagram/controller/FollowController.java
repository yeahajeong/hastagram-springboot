package com.yeahajeong.hastagram.controller;

import com.yeahajeong.hastagram.domain.Follow;
import com.yeahajeong.hastagram.domain.User;
import com.yeahajeong.hastagram.repository.FollowRepository;
import com.yeahajeong.hastagram.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
public class FollowController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private FollowRepository followRepository;

    //팔로우 요청
    @PostMapping("/follow/{id}")
    public String follow(@PathVariable String id, HttpSession session, Model model) throws Exception {

        User activeUser = (User) session.getAttribute("login");
        User passiveUser = userRepository.findUserById(id);

        Follow follow = new Follow();
        follow.setActiveUser(activeUser);
        follow.setPassiveUser(passiveUser);

        followRepository.save(follow);
        return "FollowOK";
    }

    //언팔로우 요청
    @PostMapping("/unfollow/{id}")
    public String unfollow(@PathVariable String id, HttpSession session, Model model) throws Exception {

        User activeUser = (User) session.getAttribute("login");
        User passiveUser = userRepository.findUserById(id);

        Follow follow = new Follow();
        follow.setActiveUser(activeUser);
        follow.setPassiveUser(passiveUser);

        followRepository.deleteByActiveUser_UserNoAndPassiveUser_UserNo(activeUser.getUserNo(), passiveUser.getUserNo());
        return "UnFollowOK";
    }

}
