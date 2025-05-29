import 'package:capture/models/product.dart';
import 'package:capture/screens/Product/product_screen.dart';
import 'package:flutter/material.dart';

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
          width: 175,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product.mainImage.isEmpty
                  ? Container(
                      width: 175,
                      height: 300,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                    )
                  : Image.network(
                      product.mainImage,
                      width: 175,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 8),
              Text(
                product.brand,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 175,
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 14,
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
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 5),
          Text(
            '★${product.rate.toStringAsFixed(1)}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFA20C),
            ),
          ),
        ],
      ),
    ],
  );
}
