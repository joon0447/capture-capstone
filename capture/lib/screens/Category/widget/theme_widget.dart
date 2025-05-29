import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:capture/screens/Category/Theme/theme_screen.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  void _handleCasualTap(BuildContext context) {
    // 캐주얼 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThemeScreen(theme: 'casual', title: '캐주얼'),
      ),
    );
  }

  void _handleSportyTap(BuildContext context) {
    // 스포티 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThemeScreen(theme: 'sporty', title: '스포티'),
      ),
    );
  }

  void _handleClassicTap(BuildContext context) {
    // 포멀 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThemeScreen(theme: 'classic', title: '클래식'),
      ),
    );
  }

  void _handleStreetTap(BuildContext context) {
    // 스트릿 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThemeScreen(theme: 'street', title: '스트릿'),
      ),
    );
  }

  void _handleVintageTap(BuildContext context) {
    // 빈티지 처리 로직
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThemeScreen(theme: 'vintage', title: '빈티지'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildThemeRow(
            context,
            '스트릿',
            'assets/images/street-theme.png',
            _handleStreetTap,
            '빈티지',
            'assets/images/binteage-theme.png',
            _handleVintageTap,
          ),
          SizedBox(height: 20.h),
          _buildThemeRow(
            context,
            '캐주얼',
            'assets/images/casual-theme.png',
            _handleCasualTap,
            '스포티',
            'assets/images/sporty-theme.png',
            _handleSportyTap,
          ),
          SizedBox(height: 20.h),
          _buildSingleThemeItem(
            context,
            '클래식',
            'assets/images/classic-theme.png',
            _handleClassicTap,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeRow(
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
          child: _buildThemeItem(context, leftTitle, leftImage, leftOnTap),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildThemeItem(context, rightTitle, rightImage, rightOnTap),
        ),
      ],
    );
  }

  Widget _buildSingleThemeItem(
    BuildContext context,
    String title,
    String imagePath,
    Function(BuildContext) onTap,
  ) {
    return Row(
      children: [
        Expanded(child: _buildThemeItem(context, title, imagePath, onTap)),
        const Expanded(child: SizedBox()), // 빈 공간을 위한 위젯
      ],
    );
  }

  Widget _buildThemeItem(
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
