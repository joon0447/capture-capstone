import 'package:capture/constants/ar_controller.dart';
import 'package:capture/database/category_api.dart';
import 'package:capture/database/data.dart';
import 'package:capture/functions/kakao_login.dart';
import 'package:capture/screens/Main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  Future<void> _initialController() async {
    await deepArController.initialize(
        androidLicenseKey:
            'f305df4f09294395cc3bd643461efe288b6f1dfad2e9d4e7cfd92420c6e7af888830f735309108df',
        iosLicenseKey: '');
  }

  @override
  void initState() {
    super.initState();
    _fetchHomeData();
    _initialController();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 1253),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
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
                Text(
                  'AR로 미리보는 모자 쇼핑',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontFamily: 'Pretendard',
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 50),
                if (_showLoginImage)
                  // 카카오 로그인
                  GestureDetector(
                    onTap: () async {
                      await KakaoLoginApi().login(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Image.asset(
                        'assets/images/kakao_login_large_wide.png',
                      ),
                    ),
                  ),
                if (_showLoginImage)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          '로그인 없이 시작 (테스트)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
