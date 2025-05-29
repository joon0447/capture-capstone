import 'package:flutter/material.dart';

import 'package:capture/constants/nav_constants.dart';
import 'package:capture/screens/Home/home_screen.dart';

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
      height: NavConstants.navBarHeight,
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
            size: NavConstants.iconSize,
            color: currentIndex == index ? Colors.black : Colors.grey,
          ),
          const SizedBox(height: NavConstants.iconSpacing),
          Text(
            NavConstants.navItems[index].label,
            style: TextStyle(
              color: currentIndex == index ? Colors.black : Colors.grey,
              fontSize: NavConstants.textSize,
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
        height: NavConstants.navBarHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: NavConstants.mainTextOffset,
              child: Text(
                '미리보기',
                style: TextStyle(
                  color: currentIndex == 2 ? Colors.black : Colors.grey,
                  fontSize: NavConstants.textSize,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, NavConstants.mainIconOffset),
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  NavConstants.navItems[2].icon,
                  size: NavConstants.mainIconSize,
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
