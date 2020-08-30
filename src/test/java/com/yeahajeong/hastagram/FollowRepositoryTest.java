package com.yeahajeong.hastagram;

import com.yeahajeong.hastagram.domain.Follow;
import com.yeahajeong.hastagram.domain.User;
import com.yeahajeong.hastagram.repository.FollowRepository;
import com.yeahajeong.hastagram.repository.UserRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class FollowRepositoryTest {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private FollowRepository followRepository;

    @Test
    public void 팔로우한다() throws Exception {

        User user1 = userRepository.findUserByUserNo(2L);
        User user2 = userRepository.findUserByUserNo(3L);

        Follow follow = new Follow();

        follow.setActiveUser(user1);
        follow.setPassiveUser(user2);

        followRepository.save(follow);
    }

    @Test
    public void 언팔로우한다() throws Exception {

        followRepository.deleteByActiveUser_UserNoAndPassiveUser_UserNo(2L,3L);
    }

    @Test
    public void 팔로우유무() {
        int result = followRepository.findByActiveUser_UserNoAndPassiveUser_UserNo(2L,3L);
        if(result == 0) {
            System.out.println("팔로우 되어있지 않음");
        } else {
            System.out.println("팔로우 되어있음");
        }
    }

    @Test
    public void 리스트_조회한다() throws Exception {
        List<Follow> follower = followRepository.findByActiveUser_UserNo(3L);
        List<Follow> following = followRepository.findByPassiveUser_UserNo(3L);

        System.out.println(follower);
        System.out.println(following);
    }

}
