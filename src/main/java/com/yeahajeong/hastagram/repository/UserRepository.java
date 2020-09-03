package com.yeahajeong.hastagram.repository;

import com.yeahajeong.hastagram.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    //아이디로 유저 조회
    User findUserById(String id);

    //이메일로 유저 조회
    User findUserByEmail(String email);

    //유저번호로 회원 정보 조회
    User findUserByUserNo(Long userNo);

}