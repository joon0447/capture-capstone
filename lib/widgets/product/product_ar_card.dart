import 'package:capture/models/product.dart';
import 'package:capture/screens/Product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget productARCard(Product product, BuildContext context) {
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
    child: Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                product.mainImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              width: 200.w,
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
          ])
        ],
      ),
    ),
  );
}
