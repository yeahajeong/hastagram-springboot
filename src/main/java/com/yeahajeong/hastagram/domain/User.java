package com.yeahajeong.hastagram.domain;

import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.sql.Timestamp;

@Data
@Entity
@AllArgsConstructor //모든 필드를 파라미터를 통해 초기화하는 생성자
@NoArgsConstructor  //기본 생성자 선언
@Builder
public class User {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer userNo;

    private String email;
    private String id;
    private String pw;
    private String name;
    private String intro;

    @CreationTimestamp
    private Timestamp regDate;
}
