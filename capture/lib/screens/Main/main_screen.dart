import 'package:capture/screens/Category/category_screen.dart';
import 'package:capture/screens/Face/face_screen.dart';
import 'package:capture/screens/Home/home_screen.dart';
import 'package:capture/screens/Like/like_screen.dart';
import 'package:capture/screens/Mypage/mypage_screen.dart';
import 'package:capture/widgets/nav/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> get _screens => [
        HomeScreen(
            onNavigate: (index) => setState(() => _selectedIndex = index)),
        const CategoryScreen(),
        const FaceScreen(),
        const LikeScreen(),
        const MypageScreen(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
