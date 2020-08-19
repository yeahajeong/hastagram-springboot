package com.yeahajeong.hastagram.repository;

import com.yeahajeong.hastagram.domain.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Integer> {
    //아이디 중복 확인
    User findUserById(String id);

    //이메일 중복확인인
    User findUserByEmail(String email);

}