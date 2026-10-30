import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/cubit/theme_cubit.dart';
import '../../../../core/widgets/confirm_exit.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../widgets/custom_top_auth.dart';
import 'widgets/login_fields.dart';
import 'widgets/login_new_user.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) confirmExit(context);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 100.h),
              IconButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              ),
              CustomTopAuth(title: LocaleKeys.login.tr()),
              CustomLoginFields(),
              CustomLoginNewUser(),
            ],
          ),
        ),
      ),
    );
  }
}
