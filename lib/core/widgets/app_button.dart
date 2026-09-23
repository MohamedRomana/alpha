import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class AppButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget? iconComponent;
  final Widget? textComponent;
  final Color? color;
  final double? height;
  final double? top;
  final double? bottom;
  final double? start;
  final double? end;
  final double? radius;
  final double? width;
  final List<Color>? colors;
  final Widget child;
  final Color? borderColor;
  final double? borderWidth;
  final WidgetStateProperty<double?>? elevation;
  final WidgetStateProperty<Color?>? shadowColor;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.height,
    this.radius,
    this.width,
    this.top,
    this.bottom,
    this.start,
    this.end,
    this.iconComponent,
    this.textComponent,
    this.colors,
    this.borderColor,
    this.borderWidth,
    this.elevation,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: top ?? 0,
        start: start ?? 0,
        bottom: bottom ?? 0,
        end: end ?? 0,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          elevation: elevation ?? WidgetStateProperty.all(0),
          shadowColor:
              shadowColor ?? WidgetStateProperty.all(Colors.transparent),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
          // الحد الأدنى الافتراضي لـ ElevatedButton (64×40) بيكسر الزراير اللي
          // ارتفاعها أقل من كده — المقاس الحقيقي جاي من الـ Ink تحت.
          minimumSize: const WidgetStatePropertyAll(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          maximumSize: WidgetStateProperty.all(
            Size(
              width == null
                  ? 327.w
                  : (width!.isFinite ? width! : double.infinity),
              height ?? 50.h,
            ),
          ),
          backgroundColor: WidgetStateColor.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: color ?? AppColors.secondray,
            // gradient: LinearGradient(
            //   colors: colors ??
            //       [
            //         const Color(0xff0F2B50),
            //         const Color(0xff0C69E5),
            //       ],
            // ),
            borderRadius: BorderRadius.circular(radius ?? 100.r),
            border: Border.all(
              color: borderColor ?? color ?? AppColors.secondray,
              width: borderWidth ?? 1,
            ),
          ),
          child: Container(
            constraints: BoxConstraints(
              // width لانهائي (جوه Expanded) → minWidth 0 والأب هو اللي بيحدد
              // العرض؛ غير كده الديفولت 311 زي ما هو.
              minWidth: width == null ? 311.w : (width!.isFinite ? width! : 0),
              minHeight: height ?? 48.h,
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
