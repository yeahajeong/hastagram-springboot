package com.yeahajeong.hastagram.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.time.LocalDate;

@Data
@Entity //테이블과 링크될 클래스임을 나타냄
@AllArgsConstructor //모든 필드를 파라미터를 통해 초기화하는 생성자
@NoArgsConstructor  //기본 생성자 자동 추가 (public Post(){}와 같은 효과)
@Builder //클래스에 빌더 패턴 클래스 생성
public class Follow {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long followNo;
//    private int activeUser;
//    private int passiveUser;
//    private Timestamp regDate;
//
//    private String activeUserId;
//    private String passiveUserId;

    @ManyToOne
    @JoinColumn(name = "activeUser")
    private User activeUser; //내가 팔로우 건 유저(내가 행함)

    @ManyToOne
    @JoinColumn(name = "passiveUser")
    private User passiveUser; //나를 팔로우 한 유저(내가 당함)

    @Transient //영속 필드에서 제외할 때 사용
    private boolean mutualFollowing; //맞팔 여부

    @CreationTimestamp
    private LocalDate regDate;



}
