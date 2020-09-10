package com.yeahajeong.hastagram.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

@Service
public class KakaoService {

//    private static final String APP_KEY = ""; //REST API KEY
    @Value("${spring.security.oauth2.client.registration.kakao.client-id}")
    private String APP_KEY;

    private static final String REDIRECT_URI = "http://ec2-3-35-126-40.ap-northeast-2.compute.amazonaws.com/social_login/kakao"; //끝나면 토큰을 여기다가 가져다줌

    //사용자 접근 토큰을 얻어오는 메소드
    public String getAccessToken(String code) throws Exception {

        String accessToken = "";

        //POST 요청 URL
        String requestURL = "https://kauth.kakao.com/oauth/token";

        BufferedWriter bw = null;
        BufferedReader br = null;

        try {
            //자바코드로 서버에 요청을 보내는 URL객체 생성
            URL url = new URL(requestURL);

            //오픈커넥션은 해당 URL로 서버 연결하기 위한 객체
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            //요청 방식 지정
            connection.setRequestMethod("POST");
            //post 요청시에는 setDoOutput메서드의 매개값을 true로 전달
            connection.setDoOutput(true);

            //POST요청에 필요한 파라미터를 파일 스트림을 통해 전달
            //BufferedWriter는 보조 스트림이기 때문에 메인스트림 객체가 필요함
            bw = new BufferedWriter(new OutputStreamWriter(connection.getOutputStream()));

            String param = "";
            param += "grant_type=authorization_code" +
                    "&client_id=" + APP_KEY +
                    "&redirect_uri=" + REDIRECT_URI +
                    "&code=" + code;

            bw.write(param);    //출력 버퍼를 통해 문자열 데이터 전송
            bw.flush();         //출력 버퍼를 비우는 코드


            //요청 성공? -> 요청이 성공했다면 Http Status가 200번으로 응답된다.
            int responseCode = connection.getResponseCode();

            //응답된 JSON데이터 문자열로 읽기
            br = new BufferedReader(new InputStreamReader(connection.getInputStream()));

            //JSON 문자열을 줄 단위로 읽는게 속도면에서 훨씬 효율적이다.
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }

            //result 데이터를 JSON 형태로 파싱
            JsonParser jsonParser = new JsonParser();
            JsonElement jsonElement = jsonParser.parse(result);

            //엑세스 값만 뽑아내기
            accessToken = jsonElement.getAsJsonObject().get("access_token").getAsString();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            br.close();
            bw.close();
        }
        return accessToken;
    }

    //카카오 로그인 사용자 정보 요청 메서드
    public Map<String, Object> getKakaoUserData(String accessToken) throws Exception {

        Map<String, Object> userData = new HashMap<>();

        String reqURL = "https://kapi.kakao.com/v2/user/me";

        BufferedReader br = null;

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection(); //해당 URL로 서버 연결하기 위한 객체
            conn.setRequestMethod("GET");

            //요청 헤더에 데이터 담기
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            ///////////////요청성공?////////////////////
            //요청이 성공했다면 HTTP Status가 200번으로 응답됨.
            int resCode = conn.getResponseCode();
            System.out.println("userData Req -> response status : " + resCode);

            //응답된 JSON 데이터 문자열로 읽기
            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            //JSON문자열을 줄단위로 읽는게 속도면에서 훨씬 효율적이다.
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("결과데이터 : " + result);

            //result데이터를 JSON형태로 파싱
            JsonParser jParser = new JsonParser();
            JsonElement element = jParser.parse(result);


            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            String nickname = properties.get("nickname").getAsString();
//            String profileImagePath = properties.get("profile_image").getAsString();
            String email = kakaoAccount.get("email").getAsString();

            userData.put("nickname", nickname);
//            userData.put("image", profileImagePath);
            userData.put("email", email);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            br.close();
        }
        return userData;
    }

    //로그아웃 처리
    public void kakaoLogout(String accessToken) throws Exception {
        String requestURL = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(requestURL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Authorization", "Bearer " + accessToken);

            int responseCode = connection.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));

            String result = "";
            String line = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
