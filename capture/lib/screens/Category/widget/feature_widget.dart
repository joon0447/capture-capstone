import 'package:capture/screens/Category/Use/use_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({super.key});

  void _handleMountainTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UseScreen(use: 'outdoor', title: '등산'),
      ),
    );
  }

  void _handleGolfTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UseScreen(use: 'golf', title: '골프'),
      ),
    );
  }

  void _handleTrainingTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UseScreen(use: 'exercise', title: '트레이닝'),
      ),
    );
  }

  void _handleSafetyTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UseScreen(use: 'safe', title: '안전모'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildFeatureRow(
            context,
            '등산',
            'assets/images/mountain-hat.png',
            _handleMountainTap,
            '골프',
            'assets/images/golf-cap.png',
            _handleGolfTap,
          ),
          SizedBox(height: 20.h),
          _buildFeatureRow(
            context,
            '트레이닝',
            'assets/images/ball-cap.png',
            _handleTrainingTap,
            '안전모',
            'assets/images/safety-hat.png',
            _handleSafetyTap,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(
    BuildContext context,
    String leftTitle,
    String leftIcon,
    Function(BuildContext) leftOnTap,
    String rightTitle,
    String rightIcon,
    Function(BuildContext) rightOnTap,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildFeatureItem(context, leftTitle, leftIcon, leftOnTap),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildFeatureItem(context, rightTitle, rightIcon, rightOnTap),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    String title,
    String iconPath,
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
                    iconPath,
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
