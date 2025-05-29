import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                '더 많은 상품 보기',
                style: TextStyle(
                  fontSize: 14,
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
