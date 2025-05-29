import 'package:capture/database/category_api.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/Home/widget/app_bar_widget.dart';
import 'package:capture/widgets/product/product_preview_large_card.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: MainAppBar(title: '모든 제품 보기', onBack: widget.onBack),
      body: Column(
        children: [
          GestureDetector(
            onTap: _toggleFilter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.tune, size: 24, color: Colors.black),
                  const SizedBox(width: 10),
                  _selectedFilter['category'] == '' &&
                          _selectedFilter['price'] == ''
                      ? const Text(
                          "필터를 선택해보세요!",
                          style: TextStyle(
                            fontFamily: 'Prentendard',
                            fontSize: 15,
                            color: Color(0xFF828282),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Row(
                          children: [
                            if (_selectedFilter['category'] != '')
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                margin: const EdgeInsets.only(right: 8),
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
                                      const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        _selectedFilter['category']!,
                                        style: const TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontSize: 14,
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
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
                                      const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        _selectedFilter['price']!,
                                        style: const TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontSize: 14,
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '필터',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '가격',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF828282),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 120,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    '${_priceRange.start.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    '${_priceRange.end.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
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
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '분류',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF828282),
                        ),
                      ),
                      const SizedBox(height: 16),
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
                                      padding: const EdgeInsets.all(15),
                                      child: Image.asset(
                                        'assets/images/ball-cap.png',
                                        width: 75,
                                        height: 75,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '볼캡',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 14,
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
                                      padding: const EdgeInsets.all(15),
                                      child: Image.asset(
                                        'assets/images/beani.png',
                                        width: 75,
                                        height: 75,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '비니',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 14,
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
                                      padding: const EdgeInsets.all(15),
                                      child: Image.asset(
                                        'assets/images/bucket-hat.png',
                                        width: 75,
                                        height: 75,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '버킷햇',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 14,
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
              const PopupMenuItem<String>(
                value: '추천순',
                child: Text(
                  '추천순',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: '인기순',
                child: Text(
                  '인기순',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: '가격순',
                child: Text(
                  '가격순',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            onSelected: _sortProducts,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    _selectedSort,
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 24,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
