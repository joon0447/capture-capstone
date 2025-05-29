import 'package:capture/database/category_api.dart';
import 'package:capture/database/data.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/Category/Use/use_screen.dart';
import 'package:capture/screens/Home/all_product_screen.dart';
import 'package:capture/screens/Home/best_product_screen.dart';
import 'package:capture/screens/Home/low_price_product_screen.dart';
import 'package:capture/screens/Home/widget/see_more_widget.dart';
import 'package:capture/screens/Search/search_screen.dart';
import 'package:capture/screens/Product/product_screen.dart';
import 'package:capture/widgets/product/product_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/banner.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onNavigate;
  const HomeScreen({required this.onNavigate, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  Product? _selectedProduct;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showProductDetail(Product product) {
    setState(() {
      _selectedProduct = product;
    });
  }

  void _closeProductDetail() {
    setState(() {
      _selectedProduct = null;
    });
  }

  List<Widget> get _screens => [
        AllProductScreen(onBack: () => _onItemTapped(0)),
        LowPriceProductScreen(onBack: () => _onItemTapped(0)),
        BestProductScreen(onBack: () => _onItemTapped(0)),
        SearchScreen(onBack: () => _onItemTapped(0)),
      ];

  @override
  void initState() {
    super.initState();
    CategoryApi.getAllData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 운동 카테고리 제품 프리페치
    final exerciseList = CategoryData.getUseData('exercise');
    for (final item in exerciseList) {
      final product = Product.fromMap(item);
      precacheImage(NetworkImage(product.mainImage), context);
      if (product.subImage.isNotEmpty) {
        precacheImage(NetworkImage(product.subImage), context);
      }
    }
    // 필요하다면 다른 카테고리도 반복
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedProduct != null) {
      // 상세 페이지 모드
      return ProductScreen(
        product: _selectedProduct!,
        onBack: _closeProductDetail,
      );
    }

    // 기존 HomeScreen UI (아래 기존 코드)
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    'CAPTURE',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: ImagePaths.bannerImages.length,
                        padEnds: false,
                        pageSnapping: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ImagePaths.bannerImages[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 5,
                                bottom: 50,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    ImagePaths.bannerText(index),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 17,
                      bottom: 20,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: ImagePaths.bannerImages.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.white,
                          dotColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 모든 제품 클릭 처리
                        _onItemTapped(1);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/all-product-icon.svg',
                              width: 73,
                              height: 73,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '모든 제품',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onItemTapped(2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/low-price-icon.svg',
                              width: 73,
                              height: 73,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '낮은 가격순',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onItemTapped(3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/best-icon.svg',
                              width: 73,
                              height: 73,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '베스트',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // 검색 클릭 처리
                        _onItemTapped(4);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/search-icon.svg',
                              width: 73,
                              height: 73,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '검색',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "운동할 때 뭐 써?",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            "가볍고 쿨하게, 운동 모자 총 집합",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                          SizedBox(
                            height: 400,
                            child: FutureBuilder<List<dynamic>>(
                              future: CategoryApi.getUseData(use: 'exercise'),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(child: Text('데이터 로드 오류'));
                                }

                                final exerciseData = CategoryData.getUseData(
                                  'exercise',
                                );
                                if (exerciseData.isEmpty) {
                                  return const Center(child: Text('데이터가 없습니다'));
                                }

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: exerciseData.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        top: 10,
                                      ),
                                      child: GestureDetector(
                                        onTap: () => _showProductDetail(
                                          Product.fromMap(
                                            exerciseData[index],
                                          ),
                                        ),
                                        child: productPreviewCard(
                                          Product.fromMap(
                                            exerciseData[index],
                                          ),
                                          context,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UseScreen(
                                    use: 'exercise',
                                    title: '트레이닝',
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '더 많은 상품 보기',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "평점이 인증하는 인기 제품",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            "별점 4.8 이상의 프리미엄 인기템만 모았어요",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                          SizedBox(
                            height: 400,
                            child: FutureBuilder<List<dynamic>>(
                              future: CategoryApi.getRateData(rate: 4.8),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(child: Text('데이터 로드 오류'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(child: Text('데이터가 없습니다'));
                                }

                                final rateData = snapshot.data!;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: rateData.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        top: 10,
                                      ),
                                      child: GestureDetector(
                                        onTap: () => _showProductDetail(
                                          Product.fromMap(
                                            rateData[index],
                                          ),
                                        ),
                                        child: productPreviewCard(
                                          Product.fromMap(rateData[index]),
                                          context,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SeeMoreWidget(
                            category: 'popular',
                            onTap: _onItemTapped,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ..._screens,
        ],
      ),
    );
  }
}
