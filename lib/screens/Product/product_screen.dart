import 'package:capture/constants/ar_controller.dart';
import 'package:capture/database/like.dart';
import 'package:capture/database/like_provider.dart';
import 'package:capture/models/product.dart';
import 'package:capture/screens/AR/ar_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:capture/functions/get_user_id.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final Product? product;
  final VoidCallback onBack;
  const ProductScreen({super.key, required this.product, required this.onBack});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String? userId;
  bool? isLiked;

  @override
  void initState() {
    super.initState();
    getUserId().then((id) {
      setState(() {
        userId = id;
      });

      if (id != null && widget.product != null) {
        Like.getLike(widget.product!.id, id).then((liked) {
          print('getLike 응답: $liked'); // 디버깅용
          if (mounted) {
            // mounted 체크 추가
            setState(() {
              isLiked = liked;
            });
            print('isLiked 업데이트 후: $isLiked'); // 디버깅용
          }
        });
      }
    });
  }

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
                              Text(
                                '★${widget.product?.rate.toStringAsFixed(1)}',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFFFA20C),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            try {
                              // 로딩 표시
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                              // AR 효과 로드
                              await deepArController.switchEffectWithSlot(
                                slot: 'cap',
                                path: widget.product!.arPath,
                              );

                              // 로딩 닫기
                              if (mounted) {
                                Navigator.pop(context);
                              }

                              // AR 화면으로 이동
                              if (mounted) {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ARProductScreen(
                                      product: widget.product!,
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              // 에러 발생 시 로딩 닫기
                              if (mounted) {
                                Navigator.pop(context);
                                // 에러 메시지 표시
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'AR 효과를 불러오는데 실패했습니다: ${e.toString()}'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
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
                onPressed: () async {
                  print('찜하기 버튼 클릭됨');
                  print('Product 객체: ${widget.product}');
                  print('Product ID: ${widget.product?.id}');
                  print('User ID: $userId');

                  if (widget.product == null) {
                    print('Product가 null입니다!');
                    return;
                  }

                  if (userId == null) {
                    print('User ID가 null입니다!');
                    return;
                  }

                  try {
                    if (isLiked == true) {
                      await Provider.of<LikeProvider>(context, listen: false)
                          .deleteLike(widget.product!.id, userId!);
                      if (mounted) {
                        setState(() {
                          isLiked = false;
                        });
                      }
                    } else {
                      await Provider.of<LikeProvider>(context, listen: false)
                          .addLike(widget.product!.id, userId!);
                      if (mounted) {
                        setState(() {
                          isLiked = true;
                        });
                      }
                    }
                  } catch (e) {
                    print('찜하기 처리 중 오류 발생: $e');
                    if (mounted) {
                      setState(() {
                        isLiked = isLiked == true ? false : true;
                      });
                    }
                  }
                },
                icon: Icon(
                  isLiked == true ? Icons.favorite : Icons.favorite_border,
                  color: isLiked == true ? Colors.red : const Color(0xFF2F9BF3),
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
