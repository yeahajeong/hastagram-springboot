package com.yeahajeong.hastagram.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Login {
    private String id;
    private String pw;
}