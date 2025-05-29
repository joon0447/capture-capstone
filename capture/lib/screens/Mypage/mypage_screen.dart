import 'package:capture/screens/Splash/splash_screen.dart';
import 'package:capture/widgets/appbar/search_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  String? userNickname;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      setState(() {
        userNickname = user.kakaoAccount?.profile?.nickname;
        profileImageUrl = user.kakaoAccount?.profile?.profileImageUrl;
      });
    } catch (error) {
      print('사용자 정보를 가져오는데 실패했습니다: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBarWidget(title: '마이페이지'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl!)
                      : null,
                  child: profileImageUrl == null
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
                const SizedBox(width: 16),
                Text(
                  '$userNickname님',
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF808080),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              '찜한 상품',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                color: Color(0xFF808080),
              ),
            ),
            const Divider(color: Color(0xFFE5E5E5), thickness: 1),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                UserApi.instance.logout().then((_) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()),
                    (route) => false,
                  );
                });
              },
              child: Row(
                children: const [
                  Icon(Icons.logout, color: Color(0xFF808080)),
                  SizedBox(width: 10),
                  Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
