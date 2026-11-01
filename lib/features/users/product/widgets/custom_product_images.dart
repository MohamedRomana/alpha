// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductImages extends StatefulWidget {
  const CustomProductImages({super.key, required this.images});

  final List<dynamic> images;

  @override
  State<CustomProductImages> createState() => _CustomProductImagesState();
}

class _CustomProductImagesState extends State<CustomProductImages> {
  int currentIndex = 0;
  void imageTab(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 500.h,
              child: PageView.builder(
                itemCount: widget.images.length,
                itemBuilder: (context, index) => Image.asset(
                  index == currentIndex
                      ? widget.images[index]
                      : widget.images[currentIndex],
                  width: double.infinity,
                  height: 500.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 500.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  imageTab(index);
                },
                child: Container(
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: currentIndex == index
                          ? Colors.purpleAccent
                          : Colors.transparent,
                      width: 1.w,
                    ),
                    image: DecorationImage(
                      image: AssetImage(widget.images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
