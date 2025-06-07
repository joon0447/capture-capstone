import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavConstants {
  static const List<NavItem> navItems = [
    NavItem(Icons.home, '홈'),
    NavItem(Icons.menu, '카테고리'),
    NavItem(Icons.camera, '미리보기'),
    NavItem(Icons.favorite, '찜'),
    NavItem(Icons.person, '마이'),
  ];

  static double navBarHeight = 200.h;
  static double iconSize = 40.0;
  static double mainIconSize = 50.0;
  static double textSize = 25.0;
  static const double iconSpacing = 8.0;
  static const double mainIconOffset = -40.0;
  static const double mainTextOffset = 5.0;
}

class NavItem {
  final IconData icon;
  final String label;

  const NavItem(this.icon, this.label);
}
