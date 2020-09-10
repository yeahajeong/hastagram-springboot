package com.yeahajeong.hastagram.domain;

import lombok.*;

@Setter
@Getter
@ToString
@NoArgsConstructor  //기본 생성자 자동 추가 (public User(){}와 같은 효과)
public class Login {
    private String id;
    private String pw;
}
