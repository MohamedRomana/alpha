import 'package:alpha/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/custom_conve_text.dart';
import 'widgets/custom_convers_list.dart';
import 'widgets/custom_join_conv.dart';
import 'widgets/custom_post.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: CustomAppBar(title: 'post', arrow: true),
      ),
      bottomNavigationBar: CustomJoinConv(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomPost(),
            CustomConverText(),
            CustomConversList(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

