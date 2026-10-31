// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../gen/assets.gen.dart';

// class CustomStories extends StatelessWidget {
//   const CustomStories({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100.h,
//       child: ListView.separated(
//         separatorBuilder: (context, index) => SizedBox(width: 10.w),
//         itemCount: 10,
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) => index == 0
//             ? Container(
//                 height: 70.w,
//                 width: 70.w,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withAlpha(50),
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     width: 2.w,
//                     color: ColorTween(
//                       begin: Colors.red,
//                       end: Colors.blue,
//                     ).lerp(index / 10)!,
//                   ),
//                 ),
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Center(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(500.r),
//                         child: Image.asset(
//                           Assets.img.logo.path,
//                           height: 55.w,
//                           width: 55.w,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     PositionedDirectional(
//                       bottom: 20.h,
//                       end: -4.w,
//                       child: CircleAvatar(
//                         radius: 10.r,
//                         child: Center(child: Icon(Icons.add, size: 20.sp)),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : Container(
//                 height: 70.w,
//                 width: 70.w,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withAlpha(50),
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     width: 2.w,
//                     color: ColorTween(
//                       begin: Colors.red,
//                       end: Colors.blue,
//                     ).lerp(index / 10)!,
//                   ),
//                 ),
//                 child: Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(500.r),
//                     child: Image.asset(
//                       Assets.img.img.path,
//                       height: 55.w,
//                       width: 55.w,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';

import '../../../../gen/assets.gen.dart';

class CustomStories extends StatelessWidget {
  const CustomStories({super.key});

  @override
  Widget build(BuildContext context) {
    final List<StoryItem> storyItems = [
      StoryItem(
        name: 'Ahmed',
        thumbnail: AssetImage(Assets.img.img.path),
        stories: [
          _storyPage(Assets.img.img.path),
          _storyPage(Assets.img.logo.path),
        ],
      ),
      StoryItem(
        name: 'Mohamed',
        thumbnail: AssetImage(Assets.img.img.path),
        stories: [_storyPage(Assets.img.logo.path)],
      ),
      StoryItem(
        name: 'Sarah',
        thumbnail: AssetImage(Assets.img.logo.path),
        stories: [
          _storyPage(Assets.img.img.path),
          _storyPage(Assets.img.logo.path),
        ],
      ),
      StoryItem(
        name: 'Ali',
        thumbnail: AssetImage(Assets.img.img.path),
        stories: [_storyPage(Assets.img.img.path)],
      ),
      StoryItem(
        name: 'Mika',
        thumbnail: AssetImage(Assets.img.logo.path),
        stories: [_storyPage(Assets.img.logo.path)],
      ),
    ];

    return SizedBox(
      height: 150.h,
      child: Row(
        children: [
          // Add Story
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 10.w,
              end: 10.w,
              top: 15.h,
              bottom: 70.h,
            ),
            child: GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: 70.w,
                height: 70.w,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(50),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 2.w),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          Assets.img.logo.path,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      bottom: -2.h,
                      end: -4.w,
                      child: Container(
                        height: 22.w,
                        width: 22.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2.w),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Other Stories
          Expanded(
            child: Stories(
              storyItemList: storyItems,
              displayProgress: true,
              showStoryName: true,
              circleRadius: 30.r,
              circlePadding: 3.r,
              borderThickness: 2.r,
              spaceBetweenStories: 12.w,
              highLightColor: Colors.red,
              paddingColor: Colors.black,
              fullpageVisitedColor: Colors.red,
              fullpageUnisitedColor: Colors.white24,
              storyStatusBarColor: Colors.black,
              fullPagetitleStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              storyCircleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
              ),
              autoPlayDuration: const Duration(seconds: 5),
              showThumbnailOnFullPage: true,
              showStoryNameOnFullPage: true,
            ),
          ),
        ],
      ),
    );
  }

  Scaffold _storyPage(String imagePath) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(child: Image.asset(imagePath, fit: BoxFit.cover)),
    );
  }
}
