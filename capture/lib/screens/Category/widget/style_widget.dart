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
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 20),
          _buildStyleRow(
            '비니',
            'assets/images/beani.png',
            () => _handleBeaniTap(context),
            '페도라',
            'assets/images/pedora.png',
            () => _handlePedoraTap(context),
          ),
          const SizedBox(height: 20),
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
        const SizedBox(width: 16),
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
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
