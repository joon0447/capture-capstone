import 'package:capture/models/product.dart';
import 'package:capture/screens/Product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget productPreviewCard(Product product, BuildContext context) {
  return GestureDetector(
    onTap: () {
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product.mainImage.isEmpty
                  ? Container(
                      width: 100.w,
                      height: 200.h,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                    )
                  : Image.network(
                      product.mainImage,
                      width: 100.w,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
              SizedBox(height: 8.h),
              Text(
                product.brand,
                style: TextStyle(
                  fontSize: 25.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 100.w,
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
        Row(
          children: [
            Text(
              '${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 4.w),
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
    ),
  );
}
