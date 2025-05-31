import 'package:capture/database/category_api.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/Splash/splash_screen.dart';
import 'package:capture/widgets/appbar/search_app_bar_widget.dart';
import 'package:capture/widgets/product/product_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:capture/database/like_provider.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  String? userNickname;
  String? profileImageUrl;
  String? userId;

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
        userId = user.id.toString();
      });
      await Provider.of<LikeProvider>(context, listen: false)
          .updateLikeList(userId!);
    } catch (error) {
      print('사용자 정보를 가져오는데 실패했습니다: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final likeProvider = Provider.of<LikeProvider>(context);
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
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF808080),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              '찜한 상품',
              style: TextStyle(
                fontSize: 30.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                color: const Color(0xFF808080),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 350.h,
              child: likeProvider.likeList.isEmpty
                  ? const Center(child: Text('찜한 상품이 없습니다'))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: likeProvider.likeList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 10.w,
                            top: 10.h,
                          ),
                          child: productPreviewCard(
                            Product.fromMap(CategoryApi.allData.firstWhere(
                              (product) =>
                                  product['_id'].toString() ==
                                  likeProvider.likeList[index],
                            )),
                            context,
                          ),
                        );
                      },
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
                children: [
                  const Icon(Icons.logout, color: Color(0xFF808080)),
                  const SizedBox(width: 10),
                  Text(
                    '로그아웃',
                    style: TextStyle(
                      color: const Color(0xFF808080),
                      fontSize: 30.sp,
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
