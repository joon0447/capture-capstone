import 'package:capture/database/category_api.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/Home/widget/app_bar_widget.dart';
import 'package:capture/widgets/product/product_preview_large_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleScreen extends StatefulWidget {
  final String style;
  final String title;
  const StyleScreen({super.key, required this.style, required this.title});

  @override
  State<StyleScreen> createState() => _StyleScreenState();
}

class _StyleScreenState extends State<StyleScreen> {
  String _selectedSort = '추천순';
  List<dynamic> _sortedProducts = [];

  @override
  void initState() {
    super.initState();
    if (CategoryApi.allData.isNotEmpty) {
      _sortedProducts = CategoryApi.allData
          .where((product) => product['style'] == widget.style)
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
      body: Column(
        children: [
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
                    fontSize: 25.sp,
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
                    fontSize: 25.sp,
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
                    fontSize: 25.sp,
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
                      fontSize: 25.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, size: 45.sp, color: Colors.black),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
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
          ),
        ],
      ),
    );
  }
}
