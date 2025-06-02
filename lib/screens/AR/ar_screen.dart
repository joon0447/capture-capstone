import 'package:capture/constants/ar_controller.dart';
import 'package:capture/database/category_api.dart';
import 'package:capture/models/product.dart';
import 'package:capture/widgets/product/product_ar_card.dart';
import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  Widget buildCameraPreview() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.82,
        child: Transform.scale(
          scale: 1.5,
          child: DeepArPreview(deepArController),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildCameraPreview(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: SizedBox(
              height: 150.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: CategoryApi.allData.length,
                itemBuilder: (context, index) {
                  return productARCard(
                    Product.fromMap(CategoryApi.allData[index]),
                    context,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
