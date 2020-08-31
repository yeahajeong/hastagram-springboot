package com.yeahajeong.hastagram.repository;

import com.yeahajeong.hastagram.domain.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Long> {

    //postNo로 post내용 조회
    Post findPostByPostNo(Long postNo);

    List<Post> findByUser_UserNoOrderByPostNoDesc(Long userNo);

    //유저 번호로 포스트 삭제
    void deletePostByUser_UserNo(Long userNo);

}
