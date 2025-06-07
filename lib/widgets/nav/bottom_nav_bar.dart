import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:capture/constants/nav_constants.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: NavConstants.navBarHeight.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavIcon(currentIndex: currentIndex, index: 0, onTap: onTap),
          _NavIcon(currentIndex: currentIndex, index: 1, onTap: onTap),
          _NavMainIcon(currentIndex: currentIndex, index: 2, onTap: onTap),
          _NavIcon(currentIndex: currentIndex, index: 3, onTap: onTap),
          _NavIcon(currentIndex: currentIndex, index: 4, onTap: onTap),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final int index;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            NavConstants.navItems[index].icon,
            size: NavConstants.iconSize.w,
            color: currentIndex == index ? Colors.black : Colors.grey,
          ),
          SizedBox(height: NavConstants.iconSpacing.h),
          Text(
            NavConstants.navItems[index].label,
            style: TextStyle(
              color: currentIndex == index ? Colors.black : Colors.grey,
              fontSize: NavConstants.textSize.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavMainIcon extends StatelessWidget {
  const _NavMainIcon({
    required this.currentIndex,
    required this.onTap,
    required this.index,
  });

  final int currentIndex;
  final int index;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(2);
      },
      child: SizedBox(
        height: NavConstants.navBarHeight.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: NavConstants.mainTextOffset.h + 5.h,
              child: Text(
                '미리보기',
                style: TextStyle(
                  color: currentIndex == 2 ? Colors.black : Colors.grey,
                  fontSize: NavConstants.textSize.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, NavConstants.mainIconOffset.h),
              child: Container(
                width: 60.w,
                height: 60.w,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  NavConstants.navItems[2].icon,
                  size: NavConstants.mainIconSize.w,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
