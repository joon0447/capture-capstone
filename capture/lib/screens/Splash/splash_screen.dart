import 'package:capture/database/category_api.dart';
import 'package:capture/database/data.dart';
import 'package:capture/screens/Main/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showLoginImage = false; // 로그인 버튼 보여주기

  void _fetchHomeData() async {
    try {
      print('데이터 로딩 시작');
      await CategoryData.loadCategoryData('exercise');
      await CategoryApi.getAllData();
      print('데이터 로딩 완료');

      setState(() {
        _showLoginImage = true;
      });
    } catch (e) {
      print('카테고리 데이터 로딩 실패: $e');
      setState(() {
        _showLoginImage = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'CAPTURE',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard',
              ),
            ),
            const Text(
              '쇼핑의 즐거움',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Pretendard',
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 50),
            // if (_showLoginImage)
            //   // 카카오 로그인
            //   GestureDetector(
            //     onTap: () async {
            //       await KakaoLoginApi().login(context);
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 40,
            //         vertical: 20,
            //       ),
            //       child: Image.asset(
            //         'assets/images/kakao_login_large_wide.png',
            //       ),
            //     ),
            //   ),
            GestureDetector(
              onTap: () {
                print('버튼 누름');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
