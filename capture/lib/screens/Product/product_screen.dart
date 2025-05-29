import 'package:capture/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  final Product? product;
  final VoidCallback onBack;
  const ProductScreen({super.key, required this.product, required this.onBack});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onBack();
        return false; // 직접 처리했으니 pop 하지 않음
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 90.h), // 버튼 공간 확보
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      widget.product != null
                          ? CachedNetworkImage(
                              imageUrl: widget.product!.mainImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 600.h,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.broken_image,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      // 뒤로가기 버튼
                      Positioned(
                        top: 40,
                        left: 16,
                        child: GestureDetector(
                          onTap: widget.onBack,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 24.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product?.brand ?? '',
                                style: TextStyle(
                                  fontSize: 35.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF434343),
                                ),
                              ),
                              Text(
                                widget.product?.name ?? '',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                '${widget.product?.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: 미리보기 기능 구현
                            print('미리보기 클릭');
                          },
                          child: Column(
                            children: [
                              SizedBox(height: 8.h),
                              Column(
                                children: [
                                  Container(
                                    width: 55.w,
                                    height: 55.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF4D76E0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.camera,
                                        size: 50.w,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    '미리보기',
                                    style: TextStyle(
                                      color: const Color(0xFF5A86E8),
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Pretendard',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.product?.subImage.isNotEmpty ?? false)
                    CachedNetworkImage(
                      imageUrl: widget.product!.subImage,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        height: 300.h,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        height: 300.h,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.product?.url != null) {
                      final Uri url = Uri.parse(widget.product!.url);
                      launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F9BF3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    elevation: 0,
                  ),
                  child: Text(
                    '쇼핑몰 바로가기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              IconButton(
                onPressed: () {
                  // TODO: 찜하기 로직 추가
                  print('찜하기 클릭');
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: Color(0xFF2F9BF3),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
