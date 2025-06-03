import 'package:capture/constants/ar_controller.dart';
import 'package:capture/models/product.dart';
import 'package:capture/widgets/product/product_ar_card.dart';
import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ARProductScreen extends StatefulWidget {
  final Product product;
  const ARProductScreen({super.key, required this.product});

  @override
  State<ARProductScreen> createState() => _ARProductScreenState();
}

class _ARProductScreenState extends State<ARProductScreen> {
  Widget buildCameraPreview() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Transform.scale(
          scale: 1.5,
          child: DeepArPreview(deepArController),
        ),
      );

  Future<void> _switchEffect() async {
    await deepArController.switchEffectWithSlot(
      slot: 'cap',
      path: widget.product.arPath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildCameraPreview(),
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 200.h,
              child: productARCard(
                widget.product,
                context,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
