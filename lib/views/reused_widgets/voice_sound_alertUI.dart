import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/custom_switch.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'custom_radio_button.dart';

class VoiceSoundAlertUI extends StatefulWidget {
  const VoiceSoundAlertUI({super.key});

  @override
  State<VoiceSoundAlertUI> createState() => _VoiceSoundAlertUIState();
}

class _VoiceSoundAlertUIState extends State<VoiceSoundAlertUI> {
  RxBool voiceAlert = true.obs;
  RxString alertType = "voice".obs;
  RxBool isOn = true.obs;

  TextEditingController customController = TextEditingController();

  RxString selectedMessage = "It’s time to take your white pill after you...".obs;

  List<String> alertMessages = [
    "It’s time to take your white pill after you...",
    "Reminder: please take your medication.",
    "Alert: scheduled dose time.",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE + SWITCH
          Row(
            children: [
              const Text(
                "Voice & Sound Alert",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const Spacer(),

              SwitchButton(
                value: isOn.value,
                onChanged: (v) {
                  isOn.value = v;
                },
              )
            ],
          ),

          if (voiceAlert.value) ...[
            Row(
              children: [
                CustomRadio(
                  isSelected: alertType.value == "voice",
                  onTap: () => alertType.value = "voice",
                ),
                horizontalSpace(2.w),
                Text("Voice Alert", style: TextStyle(fontSize: 15.sp)),
              ],
            ),
            verticalSpace(1.h),

            Obx(() {
              if (alertType.value == "voice") {
                return _buildDropdown(
                  selectedMessage,
                  alertMessages,
                  "Voice Alert",
                );
              }
              return const SizedBox();
            }),

            verticalSpace(1.4.h),

            /// RADIO — Custom
            Row(
              children: [
                CustomRadio(
                  isSelected: alertType.value == "custom",
                  onTap: () => alertType.value = "custom",
                ),
                horizontalSpace( 2.w),
                Text("Custom Text-to-Speech Alert", style: TextStyle(fontSize: 15.sp)),
              ],
            ),
            verticalSpace(1.h),

            Obx(() {
              if (alertType.value == "custom") {
                return _buildTextField(
                  customController,
                  "Type your custom voice message",
                  "",
                );
              }
              return const SizedBox();
            }),
          ]
        ],
      ),
    );
  }

  /// DROPDOWN BUILDER (unchanged)
  Widget _buildDropdown(
      RxString selectedValue,
      List<String> items,
      String hint,
      ) =>
      Obx(
            () => DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              hint,
              style: AppTextStyles.smallTextStyle.copyWith(color: Colors.grey),
            ),
            value: selectedValue.value,
            items: items
                .map(
                  (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: AppTextStyles.smallTextStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
            )
                .toList(),
            onChanged: (value) => selectedValue.value = value!,
            buttonStyleData: ButtonStyleData(
              height: 6.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.sp),
                border: Border.all(color: const Color(0xff999999), width: 1),
                color: Colors.transparent,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 25.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.sp),
                color: Colors.white,
              ),
              elevation: 4,
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 5.5.h,
              padding: EdgeInsets.symmetric(horizontal: 3.w),
            ),
          ),
        ),
      );

  /// TEXT FIELD
  Widget _buildTextField(
      TextEditingController controller,
      String hint,
      String label,
      ) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.sp),
        border: Border.all(color: AppColors.borderGrey,),
      ),
      child: Row(
        children: [
          Expanded(
            child:
            TextField(
              style: AppTextStyles.hintTextStyle,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: "Type here",
                hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
