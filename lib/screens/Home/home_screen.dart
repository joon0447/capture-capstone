import 'package:capture/database/category_api.dart';
import 'package:capture/database/data.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/Category/Style/style_screen.dart';
import 'package:capture/screens/Category/Use/use_screen.dart';
import 'package:capture/screens/Home/all_product_screen.dart';
import 'package:capture/screens/Home/best_product_screen.dart';
import 'package:capture/screens/Home/low_price_product_screen.dart';
import 'package:capture/screens/Home/widget/see_more_widget.dart';
import 'package:capture/screens/Search/search_screen.dart';
import 'package:capture/screens/Product/product_screen.dart';
import 'package:capture/widgets/product/product_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'CAPTURE',
                        style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          height: 500.h,
                          width: double.infinity,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: ImagePaths.bannerImages.length,
                            padEnds: false,
                            pageSnapping: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // 배너 클릭 시 처리
                                  if (index == 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const StyleScreen(
                                            style: 'ballcap', title: '볼캡'),
                                      ),
                                    );
                                  } else if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const UseScreen(
                                            use: 'outdoor', title: '등산'),
                                      ),
                                    );
                                  } else if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const UseScreen(
                                            use: 'golf', title: '골프'),
                                      ),
                                    );
                                  }
                                },
                                child: Stack(
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
                                      left: 5.w,
                                      bottom: 50.h,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 8.h,
                                        ),
                                        child: Text(
                                          ImagePaths.bannerText(index),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40.sp,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          left: 17.w,
                          bottom: 20.h,
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: ImagePaths.bannerImages.length,
                            effect: ExpandingDotsEffect(
                              dotHeight: 8.h,
                              dotWidth: 8.w,
                              activeDotColor: Colors.white,
                              dotColor: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 26.h),
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
                              SizedBox(
                                width: 70.w,
                                height: 70.h,
                                child: Image.asset(
                                  'assets/icons/all-product-icon.png',
                                  width: 70.w,
                                  height: 70.h,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                '모든 제품',
                                style: TextStyle(
                                  fontSize: 25.sp,
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
                              SizedBox(
                                width: 70.w,
                                height: 70.h,
                                child: Image.asset(
                                  'assets/icons/low-price-icon.png',
                                  width: 70.w,
                                  height: 70.h,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                '낮은 가격순',
                                style: TextStyle(
                                  fontSize: 25.sp,
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
                              SizedBox(
                                width: 70.w,
                                height: 70.h,
                                child: Image.asset(
                                  'assets/icons/best-icon.png',
                                  width: 70.w,
                                  height: 70.h,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                '베스트',
                                style: TextStyle(
                                  fontSize: 25.sp,
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
                              SizedBox(
                                width: 70.w,
                                height: 70.h,
                                child: Image.asset(
                                  'assets/icons/search-icon.png',
                                  width: 70.w,
                                  height: 70.h,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                '검색',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 26.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "운동할 때 뭐 써?",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40.sp,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "가볍고 쿨하게, 운동 모자 총 집합",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25.sp,
                                  color: const Color(0xFF4D4D4D),
                                ),
                              ),
                              SizedBox(
                                height: 350.h,
                                child: FutureBuilder<List<dynamic>>(
                                  future:
                                      CategoryApi.getUseData(use: 'exercise'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                          child: Text('데이터 로드 오류'));
                                    }

                                    final exerciseData =
                                        CategoryData.getUseData(
                                      'exercise',
                                    );
                                    if (exerciseData.isEmpty) {
                                      return const Center(
                                          child: Text('데이터가 없습니다'));
                                    }

                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: exerciseData.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            right: 10.w,
                                            top: 10.h,
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
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.3,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '더 많은 상품 보기',
                                          style: TextStyle(
                                            fontSize: 25.sp,
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
                              Text(
                                "평점이 인증하는 인기 제품",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40.sp,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "별점 4.8 이상의 프리미엄 인기템만 모았어요",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25.sp,
                                  color: const Color(0xFF4D4D4D),
                                ),
                              ),
                              SizedBox(
                                height: 350.h,
                                child: FutureBuilder<List<dynamic>>(
                                  future: CategoryApi.getRateData(rate: 4.8),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                          child: Text('데이터 로드 오류'));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                          child: Text('데이터가 없습니다'));
                                    }

                                    final rateData = snapshot.data!;
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: rateData.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            right: 10.w,
                                            top: 10.h,
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
                              SizedBox(height: 50.h),
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
        ),
      ),
    );
  }
}
