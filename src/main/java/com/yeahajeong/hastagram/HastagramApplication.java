package com.yeahajeong.hastagram;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

/*
* @SpringBootApplication 으로 인해 스프링 부트의 자동설정, 스프링 Bean 읽기와 생성을 모두 자동으로 설정.
* 특히 @SpringBootApplication이 있는 위치부터 설정을 읽어가기 때문에 이 클래스는 항상 프로젝트 상단에 위치해야함. */
@SpringBootApplication
public class HastagramApplication extends SpringBootServletInitializer {

    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(HastagramApplication.class);
    }


    /*
    * SpringApplication.run 으로 인해 내장 WAS(웹 애플리케이션 서버)를 실행
    * 내장 WAS란 별도로 외부에 WAS를 두지 않고 애플리케이션을 실행할 때 내부에서 WAS를 실행하는 것
    * 이렇게 하면 항상 서버에 톰캣을 설치할 필요가 없고 스프링 부트로 만들어진 JAR 파일로 실행하면 됨*/
    public static void main(String[] args) {
        SpringApplication.run(HastagramApplication.class, args);
    }
}
