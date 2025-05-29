import 'package:capture/database/category_api.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/Home/widget/app_bar_widget.dart';
import 'package:capture/widgets/product/product_preview_large_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UseScreen extends StatefulWidget {
  final String use;
  final String title;
  const UseScreen({super.key, required this.use, required this.title});

  @override
  State<UseScreen> createState() => _UseScreenState();
}

class _UseScreenState extends State<UseScreen> {
  String _selectedSort = '추천순';
  List<dynamic> _sortedProducts = [];

  String _getImagePath() {
    switch (widget.use) {
      case 'outdoor':
        return 'assets/images/outdoor.png';
      case 'exercise':
        return 'assets/images/exercise.png';
      case 'golf':
        return 'assets/images/golf.png';
      case 'safe':
        return 'assets/images/safe.png';
      default:
        return 'assets/images/outdoor.png';
    }
  }

  String _getBannerText() {
    switch (widget.use) {
      case 'outdoor':
        return '햇살은 피하고, \n스타일은 챙기자';
      case 'exercise':
        return '운동할 때도 \n스타일리시하게';
      case 'golf':
        return '골프장에서도 \n멋스럽게';
      case 'safe':
        return '안전과 스타일을 \n동시에';
      default:
        return '햇살은 피하고, \n스타일은 챙기자';
    }
  }

  @override
  void initState() {
    super.initState();
    if (CategoryApi.allData.isNotEmpty) {
      _sortedProducts = CategoryApi.allData
          .where((product) => product['use'] == widget.use)
          .toList();
    }
  }

  void _sortProducts(String sortType) {
    setState(() {
      _selectedSort = sortType;

      switch (sortType) {
        case '추천순':
          _sortedProducts = List.from(_sortedProducts);
          break;
        case '인기순':
          _sortedProducts.sort(
            (a, b) => (b['rate'] ?? 0).compareTo(a['rate'] ?? 0),
          );
          break;
        case '가격순':
          _sortedProducts.sort(
            (a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: widget.title,
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(_getImagePath(), fit: BoxFit.contain),
                Positioned(
                  left: 20.w,
                  bottom: 20.h,
                  child: Text(
                    _getBannerText(),
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            PopupMenuButton<String>(
              offset: const Offset(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black, width: 1),
              ),
              color: Colors.white,
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: '추천순',
                  child: Text(
                    '추천순',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: '인기순',
                  child: Text(
                    '인기순',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: '가격순',
                  child: Text(
                    '가격순',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              onSelected: _sortProducts,
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _selectedSort,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.h,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              itemCount: _sortedProducts.length,
              itemBuilder: (context, index) {
                return productPreviewLargeCard(
                  Product.fromMap(_sortedProducts[index]),
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
