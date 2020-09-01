package com.yeahajeong.hastagram;

import com.yeahajeong.hastagram.domain.User;
import com.yeahajeong.hastagram.repository.UserRepository;
import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class UserRepositoryTest {

    @Autowired
    private UserRepository userRepository;

    @After
    public void cleanup() {
        userRepository.deleteAll();
    }

    @Test
    public void 유저_회원가입_테스트() {
        //given
        User user = new User();
        user.setEmail("hi@naver.com");
        user.setName("안녕");

        userRepository.save(user);
//
//        //when
//        List<User> userList = userRepository.findAll();
//
//        //then
//        User u = userList.get(0);
//        assertThat(user.getEmail()).isEqualTo("test_email@naver.com");
//        assertThat(user.getId()).isEqualTo("testId");
//        assertThat(user.getPw()).isEqualTo("123123123!");

    }

    @Test
    public void 이메일_중복_테스트() {
        System.out.println(userRepository.findAll());
        System.out.println(userRepository.findUserByEmail("test_email@naver.com"));
        if (userRepository.findUserByEmail("test_email@naver.com") == null) {
            System.out.println("이메일 사용가능");
        } else {
            System.out.println("이메일 사용 불가");
        }
    }

    @Test
    public void 아이디_중복_테스트() {
        if (userRepository.findUserById("testId") == null) {
            System.out.println("아이디 사용가능");
        } else {
            System.out.println("아이디 사용 불가");
        }
    }




}
