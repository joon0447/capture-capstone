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
  int currentPageIndex = 0;

  Future<void> _switchEffect(
      DeepArController deepArController, Product product) async {
    await deepArController.switchEffectWithSlot(
      slot: 'cap',
      path: product.arPath,
    );
  }

  @override
  void initState() {
    super.initState();
    Product product = Product.fromMap(CategoryApi.allData[0]);
    setState(() {
      _switchEffect(deepArController, product);
    });
  }

  void onPageChanged(int index) {
    Product product = Product.fromMap(CategoryApi.allData[index]);
    setState(() {
      _switchEffect(deepArController, product);
    });
    // 여기에 페이지가 변경될 때 실행할 함수를 추가하세요
  }

  Widget buildCameraPreview() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
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
            bottom: 0,
            child: SizedBox(
              height: 200.h,
              child: PageView.builder(
                itemCount: CategoryApi.allData.length,
                onPageChanged: onPageChanged,
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
