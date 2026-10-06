import 'package:alpha/core/widgets/custom_app_bar.dart';
import 'package:alpha/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animation_gradient.dart';
import '../../../../core/widgets/logo_animations.dart';
import '../../../../gen/fonts.gen.dart';
import 'widgets/back_groung_image.dart';
import 'widgets/see_more_text.dart';
import 'widgets/send_message.dart';

class ChatDetails extends StatelessWidget {
  final String title;
  const ChatDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.h),
        child: CustomAppBar(title: title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: SendMessage(),
      body: Stack(
        children: [
          BackGroundImage(),
          SizedBox(
            width: 500.w,
            child: ListView.separated(
              itemCount: 20,
              reverse: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsetsDirectional.only(
                top: 20.h,
                start: 16.w,
                end: 16.w,
                bottom: 120.h,
              ),
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
              itemBuilder: (context, index) {
                return Align(
                  alignment: index % 2 == 0
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index % 2 == 0
                          ? Row(
                              children: [
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
                                SizedBox(width: 10.w),
                              ],
                            )
                          : SizedBox(),
                      Container(
                        padding: EdgeInsetsDirectional.only(
                          start: 16.w,
                          end: 16.w,
                          top: 10.h,
                          bottom: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(20.r),
                            topEnd: Radius.circular(20.r),
                            bottomStart: index % 2 != 0
                                ? Radius.circular(20.r)
                                : Radius.circular(0.r),
                            bottomEnd: index % 2 == 0
                                ? Radius.circular(20.r)
                                : Radius.circular(0.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withAlpha(50),
                              spreadRadius: 0.5.r,
                              blurRadius: 10.r,
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: 250.w,
                          child: SeeMoreText(
                            text:
                                'Welcoadasdadasasaddasdasdasdsdadadasdasdasdssdsdasdadasdasdsadasdasddadasdasdddasdasdasdasasdsdasme to ALPHA',
                            maxLines: 2,
                            textStyle: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontFamily: FontFamily.tajawalRegular,
                            ),
                            seeMoreStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkRed,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                              fontFamily: FontFamily.tajawalBold,
                            ),
                          ),
                        ),
                      ),
                      index % 2 != 0
                          ? Row(
                              children: [
                                SizedBox(width: 10.w),
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
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


