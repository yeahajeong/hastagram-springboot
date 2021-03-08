# [SpringBoot] 하스타그램

SNS인 인스타그램을 클론하여 제작한 웹사이트입니다. 사용자는 사이트에 가입하여 로그인할 수 있고 자신의 사진과 글을 업로드 혹은 삭제할 수 있습니다. 본인의 게시글과 다른 사용자들의 게시글을 볼 수 있으며, 원하는 다른 사용자를 팔로우 및 언팔로우 할 수 있습니다.

기존에 spring으로 진행했던 팀프로젝트를 spring-boot로 변경해 개인 프로젝트로 진행하였으며, 당시에 맡았던 user 기능에 소셜 로그인 기능과 팔로우 기능이 추가되었습니다. *(팀원 담당 기능 - post)*



## 🔗실서버 링크

[하스타그램 바로가기](#http://qec2-3-35-126-40.ap-northeast-2.compute.amazonaws.com:8080/server-down)  *=> 현재 서버 비용 문제로 내려가있습니다.*



## 📃기능 설명

본인이 구현한 기능만 명시되어 있습니다.

- 회원가입 - 비밀번호 암호화 BCryptPasswordEncoder 사용
- 본인인증 - 메일 API를 사용해 본인인증
- 로그인 - 카카오 API 사용, 세션을 통해 로그인 유지
- 중복확인 - 비동기통신으로 데이터를 받아 확인
- 비밀번호 찾기 - 메일 API를 사용해 UUID를 통한 임시 비밀번호 발급 (소셜로그인은 제한)
- 로그아웃 - 세션 삭제
- 회원 정보 변경 - 변경된 값만 변경되도록 로직 작성, 소개글의 엔터키와 스페이스바 처리
- 비밀번호 변경/확인 - DB 값 조회 후 사용자가 입력한 값과 비교
- 회원 탈퇴 - 비밀번호 확인 후 DB에서 데이터(회원의 정보, 게시물, 팔로우) 삭제, 세션 삭제
- 팔로우/언팔로우 - 회원의 user_id값을 받아 DB에 저장/삭제
- 인터셉터 - 로그인 여보에 따라 접근할 수 있는 페이지 분리



## 📽실행 영상

[유튜브 바로가기](#https://youtu.be/yvMG--1sgAU)



## 📡서버(DB & API) 명세서

### DB 명세

- User
  - **user_no** : 유저 고유값
  - email : 사용자 이메일
  - id : 사용자 아이디
  - intro : 소개글
  - name : 이름
  - phone : 전화번호
  - pw : 비밀번호
  - reg_date : 회원 등록 날짜
  - social : 소셜 회원 여부
- follow
  - **follow_no** : 팔로우 고유값
  - reg_date : 팔로우 등록 날짜
  - active_user : 팔로우를 행한 유저 번호
  - passive_user : 팔로우를 당한 유저 번호
- Post
  - **post_no** : 게시글 고유값
  - caption : 게시글 내용
  - file_content_type : 사진 업로드 파일의 타입
  - file_data : 사진 파일의 실제 데이터 배열
  - file_name : 사진 파일의 이름
  - file_size : 사진 파일의 크기
  - reg_date : 게시글 등록 날짜
  - user_no : 게시글을 작성한 사용자 고유 값으로 외래키

### API 명세

- user
  - 회원가입 페이지 열람
    - GET user/join
  - 사용자 정보 등록
    - POST user
  - 회원 이메일 인증 요청
    - GET user/emailauth
  - 이메일 중복 체크 요청
    - POST user/emailCheck
  - 아이디 중복 체크 요청
    - POST user/idCheck
  - 사용자 로그인
    - POST user/loginCheck
  - 사용자 로그아웃
    - GET user/logout
  - 회원 정보 변경 페이지 열람
    - GET user/update
  - 회원 정보 변경
    - POST user/update
  - 비밀번호 변경 페이지 열람
    - GET user/pw-change
  - 비밀번호 확인 요청
    - POST user/checkPw
  - 비밀번호 변경 요청
    - POST user/pw-change
  - 비밀번호 찾기 페이지 열람
    - GET user/pw-find
  - 비밀번호 찾기 메일 발송
    - POST user/pw-find
  - 회원 탈퇴 페이지 열람
    - GET user/withdrawal
  - 탈퇴 요청
    - POST user/withdrawal
- social login
  - 카카오로 로그인 요청
    - GET social_login/kakao
  - 카카오 로그아웃 요청
    - GET social_login/logout
- follow
  - 팔로우 요청
    - POST follow/{id}
  - 언팔로우 요청
    - POST unfollow/{id}
- post
  - 전체 게시글 조회
    - GET post/list
  - 특정 사용자 조회, 특정 사용자의 게시글 조회, 특정 사용자의 팔로워 팔로잉 리스트 조회
    - GET post/{id}
  - 게시글 작성 페이지 요청
    - GET {id}/personal-write
  - 업로드 사진 파일 불러오기 요청
    - file/{postNo}
  - 게시글 등록
    - POST delete/upload
  - 게시글 삭제
    - POST post/delete

