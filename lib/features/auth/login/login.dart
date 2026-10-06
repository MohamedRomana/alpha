import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../generated/locale_keys.g.dart';
import '../widgets/custom_top_auth.dart';
import 'widgets/login_fields.dart';
import 'widgets/login_new_user.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomTopAuth(title: LocaleKeys.login.tr()),
            CustomLoginFields(),
            CustomLoginNewUser(),
          ],
        ),
      ),
    );
  }
}
