import 'package:alpha/core/helper/extentions.dart';
import 'package:alpha/core/widgets/animation_gradient.dart';
import 'package:alpha/core/widgets/flash_message.dart';
import 'package:alpha/features/users/chats/cubit/chats_cubit.dart';
import 'package:alpha/features/users/chats/cubit/chats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../constants/colors.dart';
import '../routing/routes.dart';
import 'app_text.dart';
import 'logo_animations.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      padding: EdgeInsetsDirectional.only(top: 30.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(20.r),
          bottomEnd: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha(50),
            spreadRadius: 5.r,
            blurRadius: 10.r,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          AppText(
            text: title ?? "Alpha",
            size: 20.sp,
            fontStyle: FontStyle.italic,
            family: FontFamily.tajawalBold,
            color: Colors.white,
          ),
          Spacer(),
          BlocConsumer<ChatsCubit, ChatsState>(
            listener: (context, state) {
              state.mapOrNull(
                logOutSuccess: (value) {
                  showFlashMessage(
                    message: 'Success',
                    type: FlashMessageType.success,
                    context: context,
                  );
                  context.pushNamedAndRemoveUntil(
                    Routes.login,
                    predicate: (Route<dynamic> route) {
                      return false;
                    },
                  );
                },
                logOutFailure: (value) {
                  showFlashMessage(
                    message: "Error",
                    type: FlashMessageType.error,
                    context: context,
                  );
                },
              );
            },
            builder: (context, state) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  context.read<ChatsCubit>().logOut();
                },
                child: Icon(
                  Icons.logout,
                  size: 40.sp,
                  color: AppColors.darkRed,
                ),
              );
            },
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }
}
