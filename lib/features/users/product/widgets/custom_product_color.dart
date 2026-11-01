import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';

class CustomProductColor extends StatefulWidget {
  const CustomProductColor({super.key});

  @override
  State<CustomProductColor> createState() => _CustomProductColorState();
}
class _CustomProductColorState extends State<CustomProductColor> {
  List colors = [
    {"color": Colors.red, "name": "Red"},
    {"color": Colors.blue, "name": "Blue"},
    {"color": Colors.green, "name": "Green"},
    {"color": Colors.yellow, "name": "Yellow"},
    {"color": Colors.orange, "name": "Orange"},
  ];

  int currentIndex = 0;
  void colorTab(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AppText(
              start: 16.w,
              end: 16.w,
              text: 'Finish',
              size: 16.sp,
              family: FontFamily.tajawalBold,
            ),
            AppText(
              text: colors[currentIndex]['name'],
              size: 14.sp,
              color: Colors.grey,
              family: FontFamily.tajawalBold,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 50.h,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: colors.length,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  colorTab(index);
                },
                child: Container(
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: colors[index]['color'],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: currentIndex == index
                          ? Colors.grey
                          : Colors.transparent,
                      width: 2.w,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
