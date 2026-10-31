import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';

class CustomStories extends StatelessWidget {
  const CustomStories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemCount: 10,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => index == 0
            ? Container(
                height: 80.w,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.w,
                    color: ColorTween(
                      begin: Colors.red,
                      end: Colors.blue,
                    ).lerp(index / 10)!,
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500.r),
                        child: Image.asset(
                          Assets.img.logo.path,
                          height: 75.w,
                          width: 75.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 20.h,
                      end: -4.w,
                      child: CircleAvatar(
                        radius: 10.r,
                        child: Center(child: Icon(Icons.add, size: 20.sp)),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 80.w,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.w,
                    color: ColorTween(
                      begin: Colors.red,
                      end: Colors.blue,
                    ).lerp(index / 10)!,
                  ),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500.r),
                    child: Image.asset(
                      Assets.img.img.path,
                      height: 75.w,
                      width: 75.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
