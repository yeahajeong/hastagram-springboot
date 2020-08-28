package com.yeahajeong.hastagram.repository;

import com.yeahajeong.hastagram.domain.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    //아이디 중복 확인
    User findUserById(String id);

    //이메일 중복확인
    User findUserByEmail(String email);

    //유저번호로 회원 정보 조회
    User findUserByUserNo(Long userNo);

}