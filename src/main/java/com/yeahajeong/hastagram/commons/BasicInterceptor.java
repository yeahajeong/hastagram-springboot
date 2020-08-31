package com.yeahajeong.hastagram.commons;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

@Component
public class BasicInterceptor extends HandlerInterceptorAdapter {

    //로그인이 안되어있으면 접근하면 안된는 페이지 거르는 인터셉터
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //세션 가져오기
        HttpSession session = request.getSession();

        //세션에 login이 있는지 확인
        if (session.getAttribute("login") == null) {

            //세션이 없으니까 로그인한 회원이 없다는 것!
            //알림창을 띄워보자
            //브라우저에 html을 자바코드로 출력하는 방법
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            out.print("<script>alert('로그인이 필요합니다 !'); location.href='/hastagram/login';</script>");
            out.flush();//출력버퍼를 비우는 코드
            out.close();

            return false; //인터셉터를 통과할 수 없다
        }
        return true; //세션에 로그인이 있으면 통과 -> 컨트롤러로 고고
    }
}
