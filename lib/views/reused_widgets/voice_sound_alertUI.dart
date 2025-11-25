import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VoiceSoundAlertUI extends StatefulWidget {
  const VoiceSoundAlertUI({super.key});

  @override
  State<VoiceSoundAlertUI> createState() => _VoiceSoundAlertUIState();
}

class _VoiceSoundAlertUIState extends State<VoiceSoundAlertUI> {
  RxBool voiceAlert = true.obs;
  RxString alertType = "voice".obs;

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

              GestureDetector(
                onTap: () => voiceAlert.value = !voiceAlert.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 30,
                  width: 55,
                  decoration: BoxDecoration(
                    color: voiceAlert.value
                        ? const Color(0xff63E4AE)
                        : const Color(0xffD1D1D1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: voiceAlert.value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// MAIN CONTENT
          if (voiceAlert.value) ...[
            /// RADIO — Voice Alert (LEFT 0 SPACING)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                      () => Radio(
                    value: "voice",
                    groupValue: alertType.value,
                    activeColor: const Color(0xff63E4AE),
                    onChanged: (v) => alertType.value = v!,
                  ),
                ),
                const Text("Voice Alert", style: TextStyle(fontSize: 14)),
              ],
            ),

            /// DROPDOWN
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

            const SizedBox(height: 12),

            /// RADIO — Custom
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                      () => Radio(
                    value: "custom",
                    groupValue: alertType.value,
                    activeColor: const Color(0xff63E4AE),
                    onChanged: (v) => alertType.value = v!,
                  ),
                ),
                const Text(
                  "Custom Text-to-Speech Alert",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),

            /// TEXT FIELD
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
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
