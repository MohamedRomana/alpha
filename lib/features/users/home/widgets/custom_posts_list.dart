import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'posts_widgets/custom_normal_posts.dart';
import 'posts_widgets/custom_reels.dart';
import 'posts_widgets/custom_suggest_people.dart';
import 'posts_widgets/custom_votes_posts.dart';

class CustomPostsList extends StatelessWidget {
  const CustomPostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 25.h),
      itemBuilder: (context, index) {
        return index == 0
            ? CustomNormalPosts()
            : index == 1
            ? CustomSuggestPeople()
            // : index == 2
            // ? CustomReels()
            : index == 3
            ? CustomVotesPosts()
            : CustomNormalPosts();
      },
    );
  }
}

