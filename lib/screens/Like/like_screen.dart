import 'package:capture/widgets/appbar/search_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:capture/database/like_provider.dart';
import 'package:capture/models/product.dart';
import 'package:capture/database/category_api.dart';
import 'package:capture/widgets/product/product_preview_large_card.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    final likeProvider = Provider.of<LikeProvider>(context);

    return Scaffold(
      appBar: const SearchAppBarWidget(title: '찜'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      '찜한 상품',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 16.h,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    itemCount: likeProvider.likeList.length,
                    itemBuilder: (context, index) {
                      return productPreviewLargeCard(
                        Product.fromMap(CategoryApi.allData.firstWhere(
                          (product) =>
                              product['_id'].toString() ==
                              likeProvider.likeList[index],
                        )),
                        context,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
