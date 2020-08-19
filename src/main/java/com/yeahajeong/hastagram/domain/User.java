package com.yeahajeong.hastagram.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.sql.Timestamp;

@Setter
@Getter
@ToString
@Entity
@Table(name="user")
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
