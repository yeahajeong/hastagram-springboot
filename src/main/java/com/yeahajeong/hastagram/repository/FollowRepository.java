package com.yeahajeong.hastagram.repository;

import com.yeahajeong.hastagram.domain.Follow;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import javax.transaction.Transactional;
import java.util.List;

public interface FollowRepository extends JpaRepository<Follow, Long> {

    //팔로우 리스트 가져오기
    public List<Follow> findByActiveUser_UserNo(Long activeUser);

    //팔로워 리스트 가져오기
    public List<Follow> findByPassiveUser_UserNo(Long passiveUser);

    //팔로우 언팔로우 유무
    @Query(value = "select count(*) from follow where active_user=?1 and passive_user=?2", nativeQuery = true)
    public int findByActiveUser_UserNoAndPassiveUser_UserNo(Long activeUser, Long passiveUser);

    // 언팔로우
    @Transactional
    public void deleteByActiveUser_UserNoAndPassiveUser_UserNo(Long activeUser, Long passiveUser);

    //탈퇴시 팔로우 삭제
    @Transactional
    public void deleteFollowByActiveUser_UserNo(Long activeUserNo);
}
