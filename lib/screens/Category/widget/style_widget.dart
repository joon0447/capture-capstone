import 'package:capture/screens/Category/Style/style_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleWidget extends StatelessWidget {
  const StyleWidget({super.key});

  void _handleBallCapTap(BuildContext context) {
    // 볼캡 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StyleScreen(style: 'ballcap', title: '볼캡'),
      ),
    );
  }

  void _handleBucketHatTap(BuildContext context) {
    // 버킷햇 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StyleScreen(style: 'bucket', title: '버킷햇'),
      ),
    );
  }

  void _handleBeaniTap(BuildContext context) {
    // 비니 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StyleScreen(style: 'beani', title: '비니'),
      ),
    );
  }

  void _handlePedoraTap(BuildContext context) {
    // 페도라 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StyleScreen(style: 'pedora', title: '페도라'),
      ),
    );
  }

  void _handleBeremoTap(BuildContext context) {
    // 베레모 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StyleScreen(style: 'beremo', title: '베레모'),
      ),
    );
  }

  void _handleOtherTap(BuildContext context) {
    // 기타 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StyleScreen(style: 'others', title: '기타'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildStyleRow(
            '볼캡',
            'assets/images/ball-cap.png',
            () => _handleBallCapTap(context),
            '버킷햇',
            'assets/images/bucket-hat.png',
            () => _handleBucketHatTap(context),
          ),
          SizedBox(height: 20.h),
          _buildStyleRow(
            '비니',
            'assets/images/beani.png',
            () => _handleBeaniTap(context),
            '페도라',
            'assets/images/pedora.png',
            () => _handlePedoraTap(context),
          ),
          SizedBox(height: 20.h),
          _buildStyleRow(
            '베레모',
            'assets/images/beremo.png',
            () => _handleBeremoTap(context),
            '기타',
            'assets/images/sun-cap.png',
            () => _handleOtherTap(context),
          ),
        ],
      ),
    );
  }

  Widget _buildStyleRow(
    String leftTitle,
    String leftImage,
    VoidCallback leftOnTap,
    String rightTitle,
    String rightImage,
    VoidCallback rightOnTap,
  ) {
    return Row(
      children: [
        Expanded(child: _buildStyleItem(leftTitle, leftImage, leftOnTap)),
        SizedBox(width: 16.w),
        Expanded(child: _buildStyleItem(rightTitle, rightImage, rightOnTap)),
      ],
    );
  }

  Widget _buildStyleItem(String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
                    width: 130.w,
                    height: 130.h,
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
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
