import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../widgets/custom_top_auth.dart';
import 'widgets/custom_register_fields.dart';
import 'widgets/custom_register_login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          CustomTopAuth(title: LocaleKeys.newUser.tr(),),
          CustomRegisterFields(),
          CustomRegisterLogin(),
        ],
      ),
    );
  }
}