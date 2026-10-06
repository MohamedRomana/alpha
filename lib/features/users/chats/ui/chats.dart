import 'package:alpha/core/helper/extentions.dart';
import 'package:alpha/core/widgets/app_text.dart';
import 'package:alpha/features/users/chats/cubit/chats_cubit.dart';
import 'package:alpha/features/users/chats/data/repo/chat_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/di/dependancy_injection.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/animation_gradient.dart';
import '../../../../core/widgets/confirm_exit.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/logo_animations.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = ChatRepo();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) confirmExit(context);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.h),
          child: BlocProvider(
            create: (context) => ChatsCubit(getIt()),
            child: CustomAppBar(),
          ),
        ),
        body: AnimationLimiter(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: repo.getUsers(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(color: Colors.white);
              }
              if (asyncSnapshot.hasError) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 100.sp,
                      color: Colors.amberAccent,
                    ),
                    AppText(
                      top: 40.h,
                      start: 16.w,
                      end: 16.w,
                      text: "SomeThing Is Error",
                      color: Colors.red,
                      size: 40.sp,
                      family: FontFamily.tajawalBold,
                      fontStyle: FontStyle.italic,
                    ),
                  ],
                );
              }

              final users = asyncSnapshot.data?.docs ?? [];
              return ListView.separated(
                itemCount: users.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsetsDirectional.only(
                  top: 20.h,
                  start: 16.w,
                  end: 16.w,
                  bottom: 120.h,
                ),
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                itemBuilder: (context, index) {
                  final user = users[index].data();

                  final uid = user['uid'];
                  final name = user['name'] ?? '';
                  // final email = user['email'] ?? '';

                  // Don't show myself
                  if (uid == repo.currentUid) {
                    return const SizedBox();
                  }
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: const Duration(milliseconds: 100),
                    child: SlideAnimation(
                      verticalOffset: 50.h,
                      child: FadeInAnimation(
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(
                              Routes.chatDetails,
                              arguments: name,
                            );
                          },
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
                                        text: name,
                                        size: 18.sp,
                                        family: FontFamily.tajawalBold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    SizedBox(
                                      width: 250.w,
                                      child: AppText(
                                        text:
                                            'Last message from user ${index + 1}',
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
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
