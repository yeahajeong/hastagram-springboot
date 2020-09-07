package com.yeahajeong.hastagram;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class HastagramApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(HastagramApplication.class, args);
    }
}
