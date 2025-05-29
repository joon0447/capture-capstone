import 'package:capture/screens/Category/Brand/brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({super.key});

  void _handleNeweraTap(BuildContext context) {
    // 뉴에라
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BrandScreen(brand: '뉴에라', title: '뉴에라'),
      ),
    );
  }

  void _handleNikeTap(BuildContext context) {
    // 나이키 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BrandScreen(brand: '나이키', title: '나이키'),
      ),
    );
  }

  void _handleAdidasTap(BuildContext context) {
    // 아디다스 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BrandScreen(brand: '아디다스', title: '아디다스'),
      ),
    );
  }

  void _handleNewBalanceTap(BuildContext context) {
    // 뉴발란스 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BrandScreen(brand: '뉴발란스', title: '뉴발란스'),
      ),
    );
  }

  void _handleMLBTap(BuildContext context) {
    // MLB 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BrandScreen(brand: 'MLB', title: 'MLB'),
      ),
    );
  }

  void _handleKodakTap(BuildContext context) {
    // 기타 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BrandScreen(brand: '코닥', title: '코닥'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildBrandRow(
            context,
            '뉴에라',
            'assets/images/newera-logo.png',
            _handleNeweraTap,
            '나이키',
            'assets/images/nike-logo.png',
            _handleNikeTap,
          ),
          SizedBox(height: 20.h),
          _buildBrandRow(
            context,
            '아디다스',
            'assets/images/adidas-logo.png',
            _handleAdidasTap,
            '뉴발란스',
            'assets/images/newbalance-logo.png',
            _handleNewBalanceTap,
          ),
          SizedBox(height: 20.h),
          _buildBrandRow(
            context,
            'MLB',
            'assets/images/mlb-logo.png',
            _handleMLBTap,
            '코닥',
            'assets/images/kodak-logo.png',
            _handleKodakTap,
          ),
        ],
      ),
    );
  }

  Widget _buildBrandRow(
    BuildContext context,
    String leftTitle,
    String leftImage,
    Function(BuildContext) leftOnTap,
    String rightTitle,
    String rightImage,
    Function(BuildContext) rightOnTap,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildBrandItem(context, leftTitle, leftImage, leftOnTap),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildBrandItem(context, rightTitle, rightImage, rightOnTap),
        ),
      ],
    );
  }

  Widget _buildBrandItem(
    BuildContext context,
    String title,
    String imagePath,
    Function(BuildContext) onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(0.w),
                  child: Image.asset(
                    imagePath,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
