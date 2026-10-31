import 'package:alpha/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'widgets/custom_add_post.dart';
import 'widgets/custom_posts_list.dart';
import 'widgets/custom_signal_row.dart';
import 'widgets/custom_stories.dart';
import 'widgets/custom_welcome.dart';

class Home extends StatelessWidget {
  final String? name;
  const Home({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final day = DateFormat('EEEE').format(now); // Monday
    final time = DateFormat('hh:mm a').format(now); // 03:58 PM
    final period = DateFormat('a').format(now);

    final hour = now.hour;

    final String greeting;

    if (hour >= 5 && hour < 12) {
      greeting = 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      greeting = 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      greeting = 'Good Evening';
    } else {
      greeting = 'Good Night';
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(isHome: true),
            CustomWelcome(
              day: day,
              time: time,
              period: period,
              name: name,
              greeting: greeting,
            ),
            CustomStories(),
            CustomAddPost(),
            SizedBox(height: 10.h,),
            CustomSignalRow(),
            CustomPostsList(),
          ],
        ),
      ),
    );
  }
}
