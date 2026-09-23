import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(50),
                spreadRadius: 2.r,
                blurRadius: 5.r,
                offset: Offset(0, 3.r), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150.h,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemCount: 10,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                height: 100.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.w,
                    color: ColorTween(
                      begin: Colors.red,
                      end: Colors.blue,
                    ).lerp(index / 10)!,
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
