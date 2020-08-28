package com.yeahajeong.hastagram;

import com.yeahajeong.hastagram.domain.post.Post;
import com.yeahajeong.hastagram.domain.user.User;
import com.yeahajeong.hastagram.repository.PostRepository;
import com.yeahajeong.hastagram.repository.UserRepository;
import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.transaction.Transactional;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@SpringBootTest
public class PostRepositoryTest {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PostRepository postRepository;

    @After
    public void cleanup() {
        userRepository.deleteAll();
        postRepository.deleteAll();
    }

    @Test
    @Transactional
    public void 게시물_등록한다() throws Exception {
        //given
        User user = new User();
        user.setEmail("test_email@naver.com");
        user.setId("testId");
        user.setPw("123123123!");

        userRepository.save(user);

        byte[] b = new byte[1024];

        Post post = new Post();
        post.setUser(user);
        post.setCaption("내용");
        post.setFileName("care.jpg");
        post.setFileSize(372337);
        post.setFileContentType("image/jpeg");
        post.setFileData(b);

        postRepository.save(post);

        //when
        List<Post> postList = postRepository.findAll();

        //then
        Post p = postList.get(0);
        assertThat(post.getCaption()).isEqualTo("내용");
    }

    @Test
    public void 게시물_삭제한다() throws Exception {
        postRepository.deleteById((long)1);
    }
    
    @Test
    public void 게시물_조회한다() throws Exception {
        Post post = postRepository.findPostByPostNo((long) 1);
        System.out.println("post = " + post);
        
    }

    @Test
    public void 해당아이디의_게시물만_조회() throws Exception {
        List<Post> postList = postRepository.findByUser_UserNoOrderByPostNoDesc((long)3);
        System.out.println("postList = " + postList);
    }
}
