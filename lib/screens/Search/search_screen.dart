import 'package:capture/screens/Home/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const SearchScreen({super.key, required this.onBack});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RangeValues _priceRange = const RangeValues(0, 1000000);
  final Map<String, String> _selectedFilter = {
    'category': '',
    'price': '',
  };

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 1253),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Scaffold(
        appBar: MainAppBar(title: '검색', onBack: widget.onBack),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 80.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.black, size: 40.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
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
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                                    horizontal: 8.w, vertical: 4.h),
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
                                      Icon(Icons.close,
                                          size: 16.sp, color: Colors.blue),
                                      Text(
                                        _selectedFilter['category']!,
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontSize: 25.sp,
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
                                    horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedFilter['price'] = '';
                                      _priceRange =
                                          const RangeValues(0, 1000000);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.close,
                                          size: 16.sp, color: Colors.blue),
                                      Text(
                                        _selectedFilter['price']!,
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontSize: 25.sp,
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
                                    '',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25.sp,
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
                                    '',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25.sp,
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
                                      color: _selectedFilter['category'] == '볼캡'
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
                                    fontSize: 25.sp,
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
                                      color: _selectedFilter['category'] == '비니'
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
                                    fontSize: 25.sp,
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
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w700,
                                    color: _selectedFilter['category'] == '버킷햇'
                                        ? Colors.blue
                                        : const Color(0xFF8D8D8D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
