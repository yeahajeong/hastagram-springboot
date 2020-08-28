package com.yeahajeong.hastagram.controller;

import com.yeahajeong.hastagram.domain.post.Post;
import com.yeahajeong.hastagram.domain.user.User;
import com.yeahajeong.hastagram.repository.PostRepository;
import com.yeahajeong.hastagram.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("/post")
public class PostController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PostRepository postRepository;

    //list.jsp 페이지 열람 요청
    @GetMapping("/list")
    public ModelAndView list(Model model) throws Exception {

        //모든 게시물
        List<Post> postList = postRepository.findAll(Sort.by("postNo").descending());
        model.addAttribute("post", postList);

        return new ModelAndView("post/list");
    }

    //personal-list.jsp(개인 게시물이 보이는)페이지 열람 요청
    @GetMapping("/{id}")
    public ModelAndView personalList(@PathVariable String id, Model model, HttpSession session) throws Exception {

        //아이디로 개인 페이지의 주인 정보 담기
        User user = userRepository.findUserById(id);
        //현재 로그인 중인 회원(=나)의 정보 담기
        User loginUser = (User)session.getAttribute("login");

        //유저 번호 가져오기
        Long userNo = user.getUserNo();
        Long loginUserNo = loginUser.getUserNo();

        List<Post> postList = postRepository.findByUser_UserNoOrderByPostNoDesc(userNo);

        model.addAttribute("user", user);
        model.addAttribute("post", postList);

        return new ModelAndView("post/personal-list");
    }

    //게시글 작성 페이지 personal-write.jsp 열람 요청
    @GetMapping("/{id}/personal-write")
    public ModelAndView personalWrite(@PathVariable String id, Model model, HttpSession session) throws Exception {

        //아이디로 회원의 모든 정보 조회
        User user = userRepository.findUserById(id);
        //로그인 중인 회원(=나)의 정보 담기
        User loginUser = (User) session.getAttribute("login");

        //유저 번호 가져오기
        Long userNo = user.getUserNo();
        Long loginUserNo = loginUser.getUserNo();

        model.addAttribute("user", user);

        return new ModelAndView("post/personal-write");
    }

    //업로드 사진 파일 불러오기 요청
    @RequestMapping("/file/{postNo}")
    public ResponseEntity<byte[]> getFile(@PathVariable Long postNo) throws Exception {

        Post post = postRepository.findPostByPostNo(postNo);

        //파일을 클라이언트로 전송하기 위해 전송 정보를 담을 헤더를 설정
        HttpHeaders headers = new HttpHeaders();
        String[] fileTypes = post.getFileContentType().split("/");

        //전송헤더에 파일 정보와 확장자를 셋팅
        headers.setContentType(new MediaType(fileTypes[0], fileTypes[1]));

        //전송헤더에 파일 용량을 셋팅
        headers.setContentLength(post.getFileSize());

        //전송헤더에 파일 명을 셋팅
        headers.setContentDispositionFormData("attachment", post.getFileName());

        return new ResponseEntity<byte[]>(post.getFileData(), headers, HttpStatus.OK);
    }

    //게시글 등록 요청
    @PostMapping("/upload")
    public ModelAndView postUpload(@RequestParam("userNo") Long userNo, @RequestParam("file") MultipartFile file, String caption) throws Exception {

        User user = userRepository.findUserByUserNo(userNo);

        Post post = Post.builder()
                .caption(caption)
                .user(user)
                .fileContentType(file.getContentType())
                .fileData(file.getBytes())
                .fileSize(file.getSize())
                .fileName(file.getOriginalFilename())
                .build();

//        post.setFileName(file.getOriginalFilename());
//        post.setFileSize(file.getSize());
//        post.setFileContentType(file.getContentType());
//        post.setFileData(file.getBytes());

        postRepository.save(post);

        return new ModelAndView("redirect:/post/list");
    }
}
