import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeeMoreWidget extends StatelessWidget {
  final String category;
  final Function(int)? onTap;

  const SeeMoreWidget({super.key, required this.category, this.onTap});

  void _handleCategoryTap() {
    switch (category) {
      case 'exercise':
        // 운동 화면
        break;
      case 'popular':
        onTap?.call(3); // 베스트 제품 화면으로 이동
        break;
      default:
        // 기본 동작
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleCategoryTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Center(
              child: Text(
                '더 많은 상품 보기',
                style: TextStyle(
                  fontSize: 25.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
