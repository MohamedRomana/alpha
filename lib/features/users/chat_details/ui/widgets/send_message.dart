import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_input.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16.w),
        Expanded(
          child: AppInput(
            hint: 'Type a message',
            color: Colors.white.withAlpha(100),
            filled: true,
            end: 0,
            start: 10.w,
            borderColorr: Colors.white,
            enabledBorderColor: Colors.white,
            hintColor: Colors.white.withAlpha(150),
          ),
        ),
        SizedBox(width: 16.w),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.secondray,
          shape: CircleBorder(),
          child: Icon(Icons.send, color: Colors.white, size: 30.sp),
        ),
        SizedBox(width: 16.w),
      ],
    );
  }
}

