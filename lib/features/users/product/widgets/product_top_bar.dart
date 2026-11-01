import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/extentions.dart';
import '../../../../core/widgets/animation_gradient.dart';
import '../../../../core/widgets/logo_animations.dart';
import '../../../../gen/assets.gen.dart';

class ProductTopBar extends StatelessWidget {
  const ProductTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50.h),
        Row(
          children: [
            SizedBox(width: 10.w),

            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back, size: 25.h),
            ),
            AnimatedGradientCircle(
              child: AlphaLogoFX(
                style: LogoAnimationStyle.auth,
                child: Image.asset(
                  Assets.img.logo.path,
                  width: 30.w,
                  height: 30.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send_outlined, size: 25.h),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.bookmark_outline, size: 25.h),
                ),
              ],
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ],
    );
  }
}
