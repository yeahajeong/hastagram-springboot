package com.yeahajeong.hastagram.configuration;

import com.yeahajeong.hastagram.commons.BasicInterceptor;
import com.yeahajeong.hastagram.commons.LoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //스프링 부트 웹 설정
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private BasicInterceptor basicInterceptor;
    @Autowired
    private LoginInterceptor loginInterceptor;

    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(basicInterceptor)
                .addPathPatterns("/post/**/")
                .addPathPatterns("/user/update")
                .addPathPatterns("/user/pw-change")
                .addPathPatterns("/user/withdrawal");
                //.excludePathPatterns(); 제외할 패턴

        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/user/join")
                .addPathPatterns("/");
    }

}
