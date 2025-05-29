import 'package:capture/database/category_api.dart';
import 'package:capture/database/data.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/Home/widget/app_bar_widget.dart';
import 'package:capture/widgets/nav/bottom_nav_bar.dart';
import 'package:capture/widgets/product/product_preview_large_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestProductScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const BestProductScreen({super.key, required this.onBack});

  @override
  State<BestProductScreen> createState() => _BestProductScreenState();
}

class _BestProductScreenState extends State<BestProductScreen> {
  final int _selectedIndex = 0;
  String _selectedSort = '인기순';
  List<dynamic> _sortedProducts = [];

  @override
  void initState() {
    super.initState();
    // Future를 List로 변환하기 위해 비동기 함수 호출
    CategoryApi.getAllData().then((data) {
      setState(() {
        _sortedProducts = List.from(data)
          ..sort((a, b) => (b['rate'] ?? 0).compareTo(a['rate'] ?? 0));
      });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: '베스트', onBack: widget.onBack),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/best-banner.png'),
            const SizedBox(height: 20),
            const Text(
              '후회 없는 선택,',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                fontFamily: 'Pretendard',
              ),
            ),
            const Text(
              '베스트 모자만 모았어요',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                fontFamily: 'Pretendard',
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
                padding: const EdgeInsets.only(left: 20, right: 12, top: 20),
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
          ],
        ),
      ),
    );
  }
}
