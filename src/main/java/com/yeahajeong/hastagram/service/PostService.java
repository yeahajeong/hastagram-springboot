package com.yeahajeong.hastagram.service;

import com.yeahajeong.hastagram.domain.Post;
import com.yeahajeong.hastagram.repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PostService {

    @Autowired
    private PostRepository postRepository;

    public void save(Post post) throws Exception {

        //엔터키와 스페이스바 처리 제약 로직을 게시글 등록시에 처리
        String adjustCaption = post.getCaption()
                .replace("\n", "<br>")
                .replace("u0020", "&nbsp;");

        post.setCaption(adjustCaption);
        postRepository.save(post);
    }

}
