package com.yeahajeong.hastagram.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
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
@NoArgsConstructor  //기본 생성자 자동 추가 (public Post(){}와 같은 효과)
@Builder //클래스에 빌더 패턴 클래스 생성
public class Post {

    //기본 필드
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long postNo;		//게시글 번호

    private String caption;		//내용

    @CreationTimestamp
    private Timestamp regDate;		//등록일

    @ManyToOne
    @JoinColumn(name="userNo") //오래키를 매핑할 때 사용, name속성에는 매핑할 외래키이름 지정
    @JsonIgnoreProperties({"pw"})
    private User user;

    private String fileContentType;     //파일 타입
    private String fileName;            //파일 이름
    private long fileSize;              //파일 크기
    @Lob
    @Column(columnDefinition = "LONGBLOB") //BLOB: 65,535byte, LONGBLOB: 4,294,967,295byte
    private byte[] fileData;            //실제 데이터

//    //클라이언트 측에서 넘어온 파일 데이터를 저장하기 위한 파라미터 읽기용
//    private MultipartFile file;


}
