/*
package com.yeahajeong.hastagram.service;

import com.yeahajeong.hastagram.domain.ProfileImage;
import com.yeahajeong.hastagram.repository.ProfileImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
public class ProfileImageService {

    @Autowired
    private ProfileImageRepository profileImageRepository;

    //프로필 사진 등록
    @Transactional
    public void save(ProfileImage profileImage) throws Exception {
        //삭제하고 등록해야함
        profileImageRepository.deleteProfileImageByUser_UserNo(profileImage.getUser().getUserNo());
        profileImageRepository.save(profileImage);

    }
}
*/
