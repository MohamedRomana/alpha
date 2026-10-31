import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_polls/flutter_polls.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';

class CustomVotesPosts extends StatefulWidget {
  const CustomVotesPosts({super.key});

  @override
  State<CustomVotesPosts> createState() => _CustomVotesPostsState();
}

class _CustomVotesPostsState extends State<CustomVotesPosts> {
  late bool isTab = false;
  bool hasVoted = false;
  String? userVotedOptionId;

  final List<int> votes = [715, 1278, 306, 256];

  final List<String> options = [
    'Human Intuition',
    'Artificial Intelligence',
    'Both Together',
    'Neither',
  ];

  int get totalVotes => votes.fold(0, (sum, value) => sum + value);

  Future<bool> onVote(PollOption option, int newTotalVotes) async {
    if (hasVoted) return false;

    setState(() {
      final index = int.parse(option.id!);
      votes[index]++;
      hasVoted = true;
      userVotedOptionId = option.id;
    });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(30),
        border: Border.all(color: Colors.grey.withAlpha(100)),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 16.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(500.r),
                child: Image.asset(
                  Assets.img.img.path,
                  height: 50.w,
                  width: 50.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Mika Rowe',
                    size: 18.sp,

                    family: FontFamily.tajawalBold,
                  ),
                  AppText(
                    text: 'Spatial designer · 18 min',
                    size: 14.sp,
                    color: Colors.grey,
                    family: FontFamily.tajawalRegular,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: 350.w,
            child: AppText(
              start: 16.w,
              end: 16.w,
              text:
                  'A study in quiet infrastructure — where light, material and movement meet  A study in quiet infrastructure — where light, material and movement meet  A study in quiet infrastructure — where light, material and movement meet.',
              color: Colors.grey,
              size: 16.sp,
              lines: 100,
            ),
          ),
          SizedBox(height: 20.h),

          // ListView.separated(
          //   shrinkWrap: true,
          //   itemCount: 5,
          //   physics: NeverScrollableScrollPhysics(),
          //   separatorBuilder: (context, index) => SizedBox(height: 10.h),
          //   itemBuilder: (context, index) => InkWell(
          //     splashColor: Colors.transparent,
          //     highlightColor: Colors.transparent,
          //     onTap: () {
          //       setState(() {
          //         isTab = true;
          //       });
          //     },
          //     child: Container(
          //       width: 343.w,
          //       height: 40.h,
          //       // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          //       margin: EdgeInsets.symmetric(horizontal: 16.w),
          //       decoration: BoxDecoration(
          //         color: isTab == true ? Colors.grey[850] : Colors.grey[900],
          //         borderRadius: BorderRadius.circular(15.r),
          //         border: Border.all(color: Colors.white, width: 0.5.w),
          //       ),
          //       child: Stack(
          //         alignment: Alignment.center,
          //         children: [
          //           isTab == true
          //               ? PositionedDirectional(
          //                   start: 0,
          //                   child: Container(
          //                     width: index == 0
          //                         ? 100.w
          //                         : index == 1
          //                         ? 200.w
          //                         : index == 2
          //                         ? 250.w
          //                         : 40.w,
          //                     height: 40.h,
          //                     decoration: BoxDecoration(
          //                       color: Colors.grey[500],
          //                       borderRadius: BorderRadius.circular(15.r),
          //                     ),
          //                   ),
          //                 )
          //               : SizedBox.fromSize(),
          //           Row(
          //             children: [
          //               AppText(
          //                 start: 16.w,
          //                 text: 'Human Intuition',
          //                 size: 16.sp,
          //                 color: Colors.white,
          //                 family: FontFamily.tajawalBold,
          //               ),
          //               Spacer(),
          //               isTab == true
          //                   ? AppText(
          //                       text: index == 0
          //                           ? '28%'
          //                           : index == 1
          //                           ? "50%"
          //                           : index == 2
          //                           ? "80%"
          //                           : "10%",
          //                       end: 16.w,
          //                       size: 16.sp,
          //                       color: Colors.white,
          //                       family: FontFamily.tajawalBold,
          //                     )
          //                   : SizedBox.fromSize(),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              width: double.infinity,
              child: FlutterPolls(
                pollId: 'alpha_poll_1',
                hasVoted: hasVoted,
                userVotedOptionId: userVotedOptionId,
                onVoted: onVote,
                pollTitle: const SizedBox.shrink(),

                pollOptions: List.generate(
                  options.length,
                  (index) => PollOption(
                    id: index.toString(),
                    title: AppText(
                      text: options[index],
                      size: 16.sp,
                      color: Colors.white,
                      family: FontFamily.tajawalBold,
                    ),
                    votes: votes[index],
                  ),
                ),

                // Layout
                heightBetweenTitleAndOptions: 0,
                heightBetweenOptions: 10.h,
                pollOptionsHeight: 45.h,
                pollOptionsBorderRadius: BorderRadius.circular(15.r),

                // Unvoted Style
                pollOptionsFillColor: Colors.grey.shade900,
                pollOptionsSplashColor: Colors.transparent,
                pollOptionsBorder: Border.all(
                  color: Colors.white24,
                  width: 0.5,
                ),

                // Voted Style
                votedBackgroundColor: Colors.grey.shade900,
                votedProgressColor: Colors.red.withAlpha(120),
                leadingVotedProgessColor: Colors.red,
                voteInProgressColor: Colors.grey.shade800,

                votedPollOptionsBorder: Border.all(
                  color: Colors.white24,
                  width: 0.5,
                ),

                votedPollOptionsRadius: Radius.circular(15.r),

                votedCheckmark: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 17.sp,
                ),

                votedPercentageTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),

                votesText: 'Votes',
                votesTextStyle: TextStyle(color: Colors.grey, fontSize: 13.sp),

                votedAnimationDuration: 900,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 20.w,
                    width: 20.w + (2 - 1) * 15.w,
                    child: ListView.builder(
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,

                      padding: EdgeInsetsDirectional.only(
                        start: 16.w,
                        end: 4.w,
                      ),
                      itemBuilder: (context, index) => Transform.translate(
                        offset: Offset(-index * 5.w, 0),
                        child: Align(
                          alignment: Alignment.center,
                          widthFactor: 0.75,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(500.r),
                            child: Image.asset(
                              Assets.img.img.path,
                              height: 20.w,
                              width: 20.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppText(
                    text: '2,555 Votes',
                    size: 14.sp,
                    start: 4.w,
                    color: Colors.grey,
                    family: FontFamily.tajawalRegular,
                  ),
                ],
              ),
              Spacer(),
              AppText(
                text: '184 comments',
                size: 14.sp,
                end: 16.w,
                color: Colors.grey,
                family: FontFamily.tajawalRegular,
              ),
            ],
          ),
          Divider(color: Colors.grey),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border, size: 21.sp, color: Colors.grey),
                  AppText(
                    text: 'React',
                    size: 14.sp,
                    color: Colors.grey,
                    start: 4.w,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.comment_outlined, size: 21.sp, color: Colors.grey),
                  AppText(
                    text: 'React',
                    size: 14.sp,
                    color: Colors.grey,
                    start: 4.w,
                  ),
                ],
              ),
              Row(
                children: [
                  Transform.rotate(
                    angle: -0.5,
                    child: Icon(
                      Icons.send_outlined,
                      size: 21.sp,
                      color: Colors.grey,
                    ),
                  ),
                  AppText(
                    text: 'React',
                    size: 14.sp,
                    color: Colors.grey,
                    start: 4.w,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
