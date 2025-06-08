import 'package:capture/database/category_api.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/Home/widget/screen_bar_widget.dart';
import 'package:capture/widgets/product/product_preview_card.dart';
import 'package:capture/widgets/product/product_preview_large_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const SearchScreen({super.key, required this.onBack});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  // late final KeyboardVisibilityController _keyboardVisibilityController;
  // late final Stream<bool> _keyboardStream;
  final bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    // _keyboardVisibilityController = KeyboardVisibilityController();
    // _keyboardStream = _keyboardVisibilityController.onChange;
    // _keyboardStream.listen((visible) {
    //   setState(() {
    //     _isKeyboardVisible = visible;
    //     print('Keyboard visibility changed: $visible');
    //   });
    // });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ScreenAppBar(title: '검색', onBack: widget.onBack),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isKeyboardVisible)
                SizedBox(
                  height: 150.h,
                ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 80.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (value) async {
                          if (_searchController.text.isNotEmpty) {
                            final searchResults =
                                await CategoryApi.getSearchData(
                              search: _searchController.text,
                            );
                            setState(() {
                              _searchResults = searchResults;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '검색어를 입력해주세요.',
                          hintStyle: TextStyle(
                            color: const Color(0xFF9E9E9E),
                            fontSize: 25.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                          ),
                          isCollapsed: true,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.sp,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () async {
                        if (_searchController.text.isNotEmpty) {
                          final searchResults = await CategoryApi.getSearchData(
                            search: _searchController.text,
                          );
                          setState(() {
                            _searchResults = searchResults;
                          });
                        }
                      },
                      child:
                          Icon(Icons.search, color: Colors.black, size: 40.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Divider(
                color: const Color(0xFF808080),
                height: 1.h,
              ),
              SizedBox(height: 16.h),
              Text(
                '고객님을 위한 추천 상품',
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF000000),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 350.h,
                child: FutureBuilder<List<dynamic>>(
                  future: CategoryApi.getAllData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('데이터 로드 오류'));
                    }

                    final allData = snapshot.data ?? [];
                    if (allData.isEmpty) {
                      return const Center(child: Text('데이터가 없습니다'));
                    }

                    // 랜덤으로 5개 선택
                    allData.shuffle();
                    final randomData = allData.take(5).toList();

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: randomData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 10.w,
                            top: 10.h,
                          ),
                          child: productPreviewCard(
                            Product.fromMap(
                              randomData[index],
                            ),
                            context,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemHeight = (constraints.maxWidth / 2 - 12.w) / 0.6;
                  final rows = (_searchResults.length / 2).ceil();
                  final totalHeight =
                      (itemHeight * rows) + (16.h * (rows - 1)) + 16.h;

                  return SizedBox(
                    height: totalHeight,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 16.h,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 20.h),
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return productPreviewLargeCard(
                          Product.fromMap(_searchResults[index]),
                          context,
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
