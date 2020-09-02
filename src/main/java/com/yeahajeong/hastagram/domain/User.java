package com.yeahajeong.hastagram.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.sql.Timestamp;

@Data
@Entity //테이블과 링크될 클래스임을 나타냄
@AllArgsConstructor //모든 필드를 파라미터를 통해 초기화하는 생성자
@NoArgsConstructor  //기본 생성자 자동 추가 (public User(){}와 같은 효과)
@Builder //클래스에 빌더 패턴 클래스 생성
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userNo;

    private String email;
    private String id;
    private String pw;
    private String name;
    private String intro;
    private String phone;
    private String social;

    @CreationTimestamp
    private Timestamp regDate;


//    //클라이언트 측에서 넘어온 파일 데이터를 저장하기 위한 파라미터 읽기용
//    private MultipartFile file;
//
//    //프로필 사진 파일을 위한 필드
//    private Long userImgNo;
//    private String profileName; //파일 이름
//    private Long profileSize;   //파일 크기
//    private String profileContentType; //파일 타입

}