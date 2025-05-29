import 'package:capture/models/product.dart';
import 'package:capture/screens/Product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget productPreviewLargeCard(Product product, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          // TODO: Add navigation or action when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(
                product: product,
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
        child: SizedBox(
          width: 175.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product.mainImage.isEmpty
                  ? Container(
                      width: 175.w,
                      height: 300.h,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                    )
                  : Image.network(
                      product.mainImage,
                      width: 175.w,
                      height: 300.h,
                      fit: BoxFit.cover,
                    ),
              SizedBox(height: 8.h),
              Text(
                product.brand,
                style: TextStyle(
                  fontSize: 27.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 175.w,
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      Row(
        children: [
          Text(
            '${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
            style: TextStyle(
              fontSize: 25.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 5.w),
          Text(
            '★${product.rate.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFFFA20C),
            ),
          ),
        ],
      ),
    ],
  );
}
