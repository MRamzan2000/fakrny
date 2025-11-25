import 'package:fakrny/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SwitchButton extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;

  const SwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: SizedBox(
        width: 10.w,
        height: 5.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // BACKGROUND TRACK
            Positioned(
              top: 1.5.h,
              left: 1.w,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 9.w,
                height: 1.5.h,
                decoration: BoxDecoration(
                  color: widget.value
                      ? const Color(0xff63E4AE) // ON
                      : Colors.grey.shade400,   // OFF
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),

            // CIRCLE
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              top: 0.9.h,
              left: widget.value ? 5.w : 0.w,
              child: Container(
                width: 5.5.w,
                height: 5.5.w,
                decoration: BoxDecoration(
                  color: widget.value
                      ? AppColors.primaryColor
                      : Colors.grey.shade700,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
