import 'package:capture/screens/Category/widget/brand_widget.dart';
import 'package:capture/screens/Category/widget/feature_widget.dart';
import 'package:capture/screens/Category/widget/style_widget.dart';
import 'package:capture/screens/Category/widget/theme_widget.dart';
import 'package:capture/widgets/appbar/search_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _selectedCategory = '스타일';

  final List<String> _categories = ['스타일', '기능', '브랜드', '테마'];

  Widget _buildCategoryContent() {
    switch (_selectedCategory) {
      case '스타일':
        return const StyleWidget();
      case '기능':
        return const FeatureWidget();
      case '브랜드':
        return const BrandWidget();
      case '테마':
        return const ThemeWidget();
      default:
        return const Center(child: Text('선택된 카테고리가 없습니다'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBarWidget(title: '카테고리'),
      body: Row(
        children: [
          Container(
            width: 100,
            height: double.infinity,
            color: const Color(0xFFEDEDED),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                ...List.generate(_categories.length, (index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 15,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      child: Text(
                        category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w400,
                          fontSize: 15,
                          color: isSelected
                              ? Colors.black
                              : const Color(0xFF8D8D8D),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: _buildCategoryContent(),
            ),
          ),
        ],
      ),
    );
  }
}
