import 'package:fakrny/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  /// Optional / dynamic properties
  final double? height;
  final double? width;
  final bool? isGradient;
  final Color? color;
  final Gradient? gradient;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.isGradient,
    this.color,
    this.gradient,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final bool useGradient = isGradient ?? true;

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius ?? BorderRadius.circular(20.sp),
      child: Container(
        height: height ?? 6.5.h,
        width: width ?? double.infinity,
        padding: padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(

          color: useGradient
              ? null
              : color ?? const Color(0xffF4F8FB),
          gradient: useGradient
              ? gradient ??
              const LinearGradient(
                colors: [
                  Color(0xff1FB774),
                  Color(0xff63E4AE),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
              : null,
          borderRadius: borderRadius ?? BorderRadius.circular(20.sp),
          border: useGradient
              ? null
              : border ??
              Border.all(
                color: const Color(0xff1FB774),
                width: 2,
              ),
          boxShadow: boxShadow??  [
        BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 22,
        spreadRadius: 1,
        offset: const Offset(0, 6),
      ),
      ],
        ),
        child: Center(
          child: Text(
            title,
            style:AppTextStyles.buttonTextStyle
          ),
        ),
      ),
    );
  }
}
