package com.yeahajeong.hastagram.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/post")
public class PostController {

    //list.jsp 페이지 열람 요청
    @GetMapping("/list")
    public ModelAndView list(Model model) throws Exception {

        return new ModelAndView("post/list");
    }
}
