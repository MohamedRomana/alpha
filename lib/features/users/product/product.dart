import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../gen/assets.gen.dart';
import 'widgets/custom_about_product.dart';
import 'widgets/custom_product_color.dart';
import 'widgets/custom_product_images.dart';
import 'widgets/product_top_bar.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    final List images = [
      Assets.img.img.path,
      Assets.img.logo.path,
      Assets.img.img.path,
      Assets.img.logo.path,
      Assets.img.img.path,
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: const ProductTopBar(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomProductImages(images: images),
            CustomAboutProduct(),
            CustomProductColor(),
          ],
        ),
      ),
    );
  }
}
