package com.yeahajeong.hastagram.commons;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

@Component
public class LoginInterceptor extends HandlerInterceptorAdapter {

    //로그인이 되어있으면 가면 안되는곳 -> 로그인 페이지, 회원가입 페이지,
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //세션 가져와
        HttpSession session = request.getSession();

        if (session.getAttribute("login") != null) {

            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            out.print("<script>alert('로그인 중 입니다 !'); location.href='/post/list';</script>");
            out.flush();
            out.close();

            return false;
        }
        return true;
    }
}
