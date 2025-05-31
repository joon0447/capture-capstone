import 'package:capture/database/category_api.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/Home/widget/screen_bar_widget.dart';
import 'package:capture/widgets/product/product_preview_large_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProductScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AllProductScreen({super.key, required this.onBack});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  String _selectedSort = '추천순';
  List<dynamic> _sortedProducts = [];
  bool _isFilterVisible = false;
  final RangeValues _priceRange = const RangeValues(0, 1000000);

  // 선택한 카테고리
  // category : 모자 종류
  // price : 가격 범위
  final Map<String, String> _selectedFilter = {'category': '', 'price': ''};

  void _toggleFilter() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  void _sortProducts(String sortType) {
    setState(() {
      _selectedSort = sortType;

      switch (sortType) {
        case '추천순':
          CategoryApi.getAllData().then((data) {
            setState(() {
              _sortedProducts = data;
            });
          });
          break;
        case '인기순':
          CategoryApi.getAllData().then((data) {
            setState(() {
              _sortedProducts = List.from(data)
                ..sort((a, b) => (b['rate'] ?? 0).compareTo(a['rate'] ?? 0));
            });
          });
          break;
        case '가격순':
          CategoryApi.getAllData().then((data) {
            setState(() {
              _sortedProducts = List.from(data)
                ..sort((a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0));
            });
          });
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Future를 List로 변환하기 위해 비동기 함수 호출
    CategoryApi.getAllData().then((data) {
      setState(() {
        _sortedProducts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 1253),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Scaffold(
        appBar: ScreenAppBar(title: '모든 제품 보기', onBack: widget.onBack),
        body: Column(
          children: [
            SizedBox(height: 20.h),
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
                    Icon(
                      Icons.arrow_drop_down,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
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
      ),
    );
  }
}
