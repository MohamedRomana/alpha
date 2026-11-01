import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class CustomQuantity extends StatefulWidget {
  const CustomQuantity({super.key});

  @override
  State<CustomQuantity> createState() => _CustomQuantityState();
}

class _CustomQuantityState extends State<CustomQuantity> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AppText(
              text: 'Quantity',
              size: 16.sp,
              family: FontFamily.tajawalBold,
              start: 16.w,
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                // vertical: 5.h,
              ),
              margin: EdgeInsetsDirectional.only(end: 16.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withAlpha(100)),
                borderRadius: BorderRadius.circular(500.r),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      decrementQuantity();
                    },
                    icon: Icon(Icons.remove, size: 25.h),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: AppText(
                      text: quantity.toString(),
                      size: 16.sp,
                      family: FontFamily.tajawalBold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      incrementQuantity();
                    },
                    icon: Icon(Icons.add, size: 25.h),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 40.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton(
              onPressed: () {},
              width: 150.w,
              radius: 12.r,
              color: Colors.black,
              borderColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 20.h,
                    color: Colors.white,
                  ),
                  AppText(
                    text: 'Add To Cart',
                    size: 14.sp,
                    color: Colors.white,
                    family: FontFamily.tajawalBold,
                    start: 10.w,
                  ),
                ],
              ),
            ),

            AppButton(
              onPressed: () {},
              width: 150.w,
              radius: 12.r,
              color: Colors.white,
              child: AppText(
                text: 'Buy Now',
                color: Colors.black,
                size: 18.sp,
                family: FontFamily.tajawalBold,
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),

        Row(
          children: [
            SizedBox(width: 16.w),
            Icon(Icons.local_shipping_outlined, size: 25.h, color: Colors.grey),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Delivery',
                  size: 16.sp,
                  family: FontFamily.tajawalBold,
                ),
                AppText(
                  text: '3–5 working days',
                  size: 14.sp,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),

        Divider(
          color: Colors.grey.withAlpha(100),
          thickness: 1.h,
          height: 40.h,
          indent: 16.w,
          endIndent: 16.w,
        ),
        Row(
          children: [
            SizedBox(width: 16.w),
            Icon(Icons.sync, size: 25.h, color: Colors.grey),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Returns',
                  size: 16.sp,
                  family: FontFamily.tajawalBold,
                ),
                AppText(
                  text: '30-day returns',
                  size: 14.sp,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),

        Divider(
          color: Colors.grey.withAlpha(100),
          thickness: 1.h,
          height: 40.h,
          indent: 16.w,
          endIndent: 16.w,
        ),
        Row(
          children: [
            SizedBox(width: 16.w),
            Icon(Icons.verified_user_outlined, size: 25.h, color: Colors.grey),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Seller',
                  size: 16.sp,
                  family: FontFamily.tajawalBold,
                ),
                AppText(
                  text: 'Verified ALPHA Business',
                  size: 14.sp,
                  color: Colors.grey,
                  family: FontFamily.tajawalBold,
                ),
              ],
            ),
          ],
        ),

        Divider(
          color: Colors.grey.withAlpha(100),
          thickness: 1.h,
          height: 40.h,
          indent: 16.w,
          endIndent: 16.w,
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withAlpha(40),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(width: 0.5.r, color: Colors.grey),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  Assets.img.img.path,
                  height: 50.w,
                  width: 50.w,
                  fit: BoxFit.cover,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180.w,
                    child: AppText(
                      start: 12.w,
                      text: 'Sold By Frame Eight · Product',
                      size: 14.sp,
                      lines: 2,
                      family: FontFamily.tajawalBold,
                      bottom: 10.h,
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                    child: AppText(
                      start: 12.w,
                      text: ' 4.9 store rating · Replies within 2h',
                      size: 10.sp,
                      color: Colors.grey,
                      family: FontFamily.tajawalBold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  AppText(
                    start: 12.w,
                    text: 'Message seller',
                    size: 10.sp,
                    color: Colors.deepPurple,
                    end: 5.w,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15.sp,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
