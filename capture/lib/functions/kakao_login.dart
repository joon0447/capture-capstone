import 'package:capture/constants/url.dart';
import 'package:capture/screens/Main/main_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KakaoLoginApi {
  Future<bool> login(BuildContext context) async {
    try {
      // 1. 카카오 install 여부 확인 : true / false
      bool isInstalled = await isKakaoTalkInstalled();
      // 1-1. install이 되어있다면, 카카오톡으로 로그인 유도
      if (isInstalled) {
        try {
          print('카카오톡 로그인 시도...');
          await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공');

          // 사용자 정보 가져오기
          User user = await UserApi.instance.me();
          print('로그인한 사용자 ID: ${user.id}');
          print('로그인한 사용자 닉네임: ${user.kakaoAccount?.profile?.nickname}');

          // 서버로 로그인 정보 전송
          await _sendLoginInfoToServer(
            user.id.toString(),
            user.kakaoAccount?.profile?.nickname ?? '',
          );

          _navigateToHome(context);
          return true;
        } catch (e) {
          print('카카오톡 로그인 실패: $e');
          // 카카오톡 로그인 실패 시 카카오 계정으로 로그인 시도
          try {
            await UserApi.instance.loginWithKakaoAccount();

            // 사용자 정보 가져오기
            User user = await UserApi.instance.me();
            print('로그인한 사용자 ID: ${user.id}');
            print('로그인한 사용자 닉네임: ${user.kakaoAccount?.profile?.nickname}');

            // 서버로 로그인 정보 전송
            await _sendLoginInfoToServer(
              user.id.toString(),
              user.kakaoAccount?.profile?.nickname ?? '',
            );

            _navigateToHome(context);
            return true;
          } catch (e) {
            print('카카오 계정 로그인 실패: $e');
            return false;
          }
        }
      } else {
        // 1-2. install이 되어있지 않다면, 카카오 계정으로 로그인 유도
        try {
          await UserApi.instance.loginWithKakaoAccount();
          // 사용자 정보 가져오기
          User user = await UserApi.instance.me();
          print('로그인한 사용자 ID: ${user.id}');
          print('로그인한 사용자 닉네임: ${user.kakaoAccount?.profile?.nickname}');

          // 서버로 로그인 정보 전송
          await _sendLoginInfoToServer(
            user.id.toString(),
            user.kakaoAccount?.profile?.nickname ?? '',
          );

          _navigateToHome(context);
          return true;
        } catch (e) {
          print('카카오 계정 로그인 실패: $e');
          return false;
        }
      }
    } catch (e) {
      print('카카오 로그인 전체 프로세스 실패: $e');
      return false;
    }
  }

  Future<void> _sendLoginInfoToServer(String id, String nickname) async {
    try {
      final response = await http.post(
        Uri.parse('${UrlConstants.currentUrl}/api/login/save'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'nickname': nickname}),
      );

      if (response.statusCode == 200) {
      } else {
        print('서버 로그인 정보 전송 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('서버 로그인 정보 전송 중 오류 발생: $e');
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }
}
