import 'package:alpha/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/widgets/animation_gradient.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/logo_animations.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.h),
        child: CustomAppBar(),
      ),
      body: AnimationLimiter(
        child: ListView.separated(
          itemCount: 20,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsetsDirectional.only(
            top: 20.h,
            start: 16.w,
            end: 16.w,
            bottom: 120.h,
          ),
          separatorBuilder: (context, index) => SizedBox(height: 20.h),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                verticalOffset: 50.h,
                child: FadeInAnimation(
                  child: Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withAlpha(50),
                          spreadRadius: 0.5.r,
                          blurRadius: 10.r,
                          offset: const Offset(
                            0,
                            0,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20.w),
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
                        SizedBox(width: 20.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 250.w,
                              child: AppText(
                                text: 'User ${index + 1}',
                                size: 18.sp,
                                family: FontFamily.tajawalBold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: 250.w,
                              child: AppText(
                                text: 'Last message from user ${index + 1}',
                                size: 14.sp,
                                family: FontFamily.tajawalRegular,
                                color: Colors.white.withAlpha(150),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
