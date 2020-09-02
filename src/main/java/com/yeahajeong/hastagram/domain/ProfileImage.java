/*
package com.yeahajeong.hastagram.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;

import javax.persistence.*;

@Setter
@Getter
@ToString(exclude = "fileData")
@Entity //테이블과 링크될 클래스임을 나타냄
@AllArgsConstructor //모든 필드를 파라미터를 통해 초기화하는 생성자
@NoArgsConstructor  //기본 생성자 자동 추가 (public User(){}와 같은 효과)
@Builder //클래스에 빌더 패턴 클래스 생성
public class ProfileImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long profileImgNo;

    @OneToMany //일대일로 하면 단방향안되고 문제가 생길 수 있으니 그냥 1:N으로..
    @JoinColumn(name = "userNo")
    @JsonIgnoreProperties({"email, pw, intro, phone, regDate"})
    private User user;

    private String fileName;            //파일이름
    private String fileContentType;     //파일 타입
    private long fileSize;              //파일 크기
    @Lob
    @Column(columnDefinition = "LONGBLOB")
    private byte[] fileData;            //실제 데이터
}
*/
