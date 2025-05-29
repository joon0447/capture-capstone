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
  RangeValues _priceRange = const RangeValues(0, 1000000);

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
            GestureDetector(
              onTap: _toggleFilter,
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.tune, size: 35.sp, color: Colors.black),
                    SizedBox(width: 10.w),
                    _selectedFilter['category'] == '' &&
                            _selectedFilter['price'] == ''
                        ? Text(
                            "필터를 선택해보세요!",
                            style: TextStyle(
                              fontFamily: 'Prentendard',
                              fontSize: 25.sp,
                              color: const Color(0xFF828282),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Row(
                            children: [
                              if (_selectedFilter['category'] != '')
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  margin: EdgeInsets.only(right: 8.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedFilter['category'] = '';
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.close,
                                          size: 25.sp,
                                          color: Colors.blue,
                                        ),
                                        Text(
                                          _selectedFilter['category']!,
                                          style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 20.sp,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (_selectedFilter['price'] != '')
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedFilter['price'] = '';
                                        _priceRange = const RangeValues(
                                          0,
                                          1000000,
                                        );
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.close,
                                          size: 25.sp,
                                          color: Colors.blue,
                                        ),
                                        Text(
                                          _selectedFilter['price']!,
                                          style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 20.sp,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
            if (_isFilterVisible)
              Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '필터',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '가격',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF828282),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 120.h,
                            child: Stack(
                              children: [
                                SliderTheme(
                                  data: const SliderThemeData(
                                    activeTrackColor: Colors.blue,
                                    inactiveTrackColor: Colors.black,
                                    thumbColor: Colors.white,
                                    trackHeight: 1.0,
                                    overlayColor: Color.fromARGB(
                                      0,
                                      255,
                                      255,
                                      255,
                                    ),
                                  ),
                                  child: RangeSlider(
                                    values: _priceRange,
                                    min: 0,
                                    max: 1000000,
                                    divisions: 100,
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        _priceRange = values;
                                        _selectedFilter['price'] =
                                            '${values.start.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원 ~ ${values.end.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원';
                                      });
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: (_priceRange.start / 1000000) *
                                          MediaQuery.of(context).size.width -
                                      40,
                                  top: 50,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    child: Text(
                                      '${_priceRange.start.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Pretendard',
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: (_priceRange.end / 1000000) *
                                          MediaQuery.of(context).size.width -
                                      80,
                                  top: 50,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    child: Text(
                                      '${_priceRange.end.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Pretendard',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '분류',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF828282),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedFilter['category'] = '볼캡';
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            _selectedFilter['category'] == '볼캡'
                                                ? Colors.blue
                                                : const Color(0xFF8D8D8D),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      child: Padding(
                                        padding: EdgeInsets.all(15.w),
                                        child: Image.asset(
                                          'assets/images/ball-cap.png',
                                          width: 75.w,
                                          height: 75.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '볼캡',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: _selectedFilter['category'] == '볼캡'
                                          ? Colors.blue
                                          : const Color(0xFF8D8D8D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedFilter['category'] = '비니';
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            _selectedFilter['category'] == '비니'
                                                ? Colors.blue
                                                : const Color(0xFF8D8D8D),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      child: Padding(
                                        padding: EdgeInsets.all(15.w),
                                        child: Image.asset(
                                          'assets/images/beani.png',
                                          width: 75.w,
                                          height: 75.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '비니',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: _selectedFilter['category'] == '비니'
                                          ? Colors.blue
                                          : const Color(0xFF8D8D8D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedFilter['category'] = '버킷햇';
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            _selectedFilter['category'] == '버킷햇'
                                                ? Colors.blue
                                                : const Color(0xFF8D8D8D),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      child: Padding(
                                        padding: EdgeInsets.all(15.w),
                                        child: Image.asset(
                                          'assets/images/bucket-hat.png',
                                          width: 75.w,
                                          height: 75.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '버킷햇',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          _selectedFilter['category'] == '버킷햇'
                                              ? Colors.blue
                                              : const Color(0xFF8D8D8D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
