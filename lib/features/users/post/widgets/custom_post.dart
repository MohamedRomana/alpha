import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class CustomPost extends StatelessWidget {
  const CustomPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(30),
        border: Border.all(color: Colors.grey.withAlpha(100)),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 16.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(500.r),
                child: Image.asset(
                  Assets.img.img.path,
                  height: 50.w,
                  width: 50.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Mika Rowe',
                    size: 18.sp,

                    family: FontFamily.tajawalBold,
                  ),
                  AppText(
                    text: 'Spatial designer · 18 min',
                    size: 14.sp,
                    color: Colors.grey,
                    family: FontFamily.tajawalRegular,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: 350.w,
            child: AppText(
              start: 16.w,
              end: 16.w,
              text:
                  'A study in quiet infrastructure — where light, material and movement meet  A study in quiet infrastructure — where light, material and movement meet  A study in quiet infrastructure — where light, material and movement meet.',
              color: Colors.grey,
              size: 16.sp,
              lines: 100,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 500.h,
            child: PageView.builder(
              itemCount: 5,
              controller: PageController(),
              physics: const PageScrollPhysics(),
              itemBuilder: (context, index) => Image.asset(
                Assets.img.img.path,
                width: double.infinity,
                height: 500.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 30.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withAlpha(20),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(width: 1.r, color: Colors.grey),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: Image.asset(
                    Assets.img.img.path,
                    height: 50.w,
                    width: 80.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: AppText(
                        start: 12.w,
                        text: 'FRAME EIGHT · PRODUCT',
                        size: 10.sp,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(
                      child: AppText(
                        start: 12.w,
                        text: 'Luma Object Lamp',
                        size: 10.sp,

                        family: FontFamily.tajawalBold,
                      ),
                    ),
                    SizedBox(
                      child: AppText(
                        start: 12.w,
                        text: '£248',
                        size: 10.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    AppText(
                      start: 12.w,
                      text: 'view products',
                      size: 10.sp,
                      color: Colors.deepPurple,
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
          Row(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 20.w,
                    width: 20.w + (2 - 1) * 15.w,
                    child: ListView.builder(
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,

                      padding: EdgeInsetsDirectional.only(
                        start: 16.w,
                        end: 4.w,
                      ),
                      itemBuilder: (context, index) => Transform.translate(
                        offset: Offset(-index * 5.w, 0),
                        child: Align(
                          alignment: Alignment.center,
                          widthFactor: 0.75,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(500.r),
                            child: Image.asset(
                              Assets.img.img.path,
                              height: 20.w,
                              width: 20.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppText(
                    text: '2,555 reactions',
                    size: 14.sp,
                    start: 4.w,
                    color: Colors.grey,
                    family: FontFamily.tajawalRegular,
                  ),
                ],
              ),
              Spacer(),
              AppText(
                text: '184 comments',
                size: 14.sp,
                end: 16.w,
                color: Colors.grey,
                family: FontFamily.tajawalRegular,
              ),
            ],
          ),
          Divider(color: Colors.grey),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border, size: 21.sp, color: Colors.grey),
                  AppText(
                    text: 'React',
                    size: 14.sp,
                    color: Colors.grey,
                    start: 4.w,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.comment_outlined, size: 21.sp, color: Colors.grey),
                  AppText(
                    text: 'React',
                    size: 14.sp,
                    color: Colors.grey,
                    start: 4.w,
                  ),
                ],
              ),
              Row(
                children: [
                  Transform.rotate(
                    angle: -0.5,
                    child: Icon(
                      Icons.send_outlined,
                      size: 21.sp,
                      color: Colors.grey,
                    ),
                  ),
                  AppText(
                    text: 'React',
                    size: 14.sp,
                    color: Colors.grey,
                    start: 4.w,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
