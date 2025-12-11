import 'package:fakrny/controllers/auth_controller.dart';
import 'package:fakrny/models/gender_model.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController controller = Get.find<AuthController>();

  // Controllers
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController passCtrl;
  late TextEditingController confirmPassCtrl;

  // Rx variables
  late Rx<GenderModel?> selectedGender;
  late Rx<DateTime?> dob;
  late RxBool obscure;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
    confirmPassCtrl = TextEditingController();

    selectedGender = Rx<GenderModel?>(null);
    dob = Rx<DateTime?>(null);
    obscure = true.obs;
  }
  // Gender list
  List<GenderModel> genderList = [
    GenderModel(name: "Male"),
    GenderModel(name: "Female"),
    GenderModel(name: "Custom"),
  ];
  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
    super.dispose();
  }

  void toggleObscure() => obscure.value = !obscure.value;

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blur_bg.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 2.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.sp),
                    topRight: Radius.circular(25.sp),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 25,
                      offset: const Offset(0, -6),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "sign_up_title".tr,
                        style: AppTextStyles.greenBoldTextStyle,
                      ),
                      verticalSpace(0.4.h),
                      Text(
                        "sign_up_with_email".tr,
                        style: AppTextStyles.smallTextStyle,
                      ),
                      verticalSpace(2.h),

                      // Name Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("name".tr, style: AppTextStyles.smallTextStyle),
                        ],
                      ),
                      verticalSpace(.4.h),
                      customTextField(
                        hintText: "hint_name".tr,
                        controller: nameCtrl,
                        iconPath: "assets/icons/name.svg",
                      ),
                      verticalSpace(1.h),

                      // DOB and Gender
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "date_of_birth".tr,
                                      style: AppTextStyles.smallTextStyle,
                                    ),
                                  ],
                                ),
                                verticalSpace(.4.h),
                                dobPicker(
                                  selectedDate: dob,
                                  hintText: "dob_hint".tr,
                                  prefixSvgPath: "assets/icons/dob.svg",
                                ),
                              ],
                            ),
                          ),
                          horizontalSpace(3.w),
                          Obx(
                                () => Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "gender".tr,
                                        style: AppTextStyles.smallTextStyle,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(.4.h),
                                  customDropdownField<GenderModel>(
                                    hint: "gender_male".tr,
                                    items: genderList,
                                    selectedValue: selectedGender,
                                    label: (gender) => gender.name,
                                    prefixPath: "assets/icons/gender.svg",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(1.h),

                      // Email Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("email".tr, style: AppTextStyles.smallTextStyle),
                        ],
                      ),
                      verticalSpace(.4.h),
                      customTextField(
                        hintText: "hint_email".tr,
                        controller: emailCtrl,
                        iconPath: "assets/icons/email.svg",
                      ),
                      verticalSpace(1.h),

                      // Password Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("password".tr, style: AppTextStyles.smallTextStyle),
                        ],
                      ),
                      verticalSpace(.4.h),
                      Obx(
                            () => customTextField(
                          hintText: "hint_password".tr,
                          controller: passCtrl,
                          iconPath: "assets/icons/password.svg",
                          isPassword: true,
                          obscureText: obscure.value,
                          suffixIcon: obscure.value
                              ? SvgPicture.asset("assets/icons/eye_off.svg")
                              : SvgPicture.asset("assets/icons/eye_on.svg"),
                          onSuffixTap: toggleObscure,
                        ),
                      ),
                      verticalSpace(1.h),

                      // Confirm Password Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("confirm_password".tr, style: AppTextStyles.smallTextStyle),
                        ],
                      ),
                      verticalSpace(.4.h),
                      Obx(
                            () => customTextField(
                          hintText: "hint_confirm_password".tr,
                          controller: confirmPassCtrl,
                          iconPath: "assets/icons/password.svg",
                          isPassword: true,
                          obscureText: obscure.value,
                          suffixIcon: obscure.value
                              ? SvgPicture.asset("assets/icons/eye_off.svg")
                              : SvgPicture.asset("assets/icons/eye_on.svg"),
                          onSuffixTap: toggleObscure,
                        ),
                      ),
                      verticalSpace(3.h),

                      // Sign Up Button
                      CustomButton(
                        height: 5.5.h,
                        title: "sign_up_button".tr,
                        border: Border.all(color: Colors.transparent),
                        onTap: () {
                          controller.signUpUser(
                            name: nameCtrl.text,
                            email: emailCtrl.text,
                            password: passCtrl.text,
                            confirmPassword: confirmPassCtrl.text,
                            gender: selectedGender.value?.name??"",
                            dob: dob,
                          );
                        },
                      ),
                      verticalSpace(2.h),

                      // Navigate to Login
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "already_have_account".tr,
                              style: AppTextStyles.smallTextStyle.copyWith(
                                color: AppColors.borderGrey,
                              ),
                            ),
                            Text(
                              "sign_in".tr,
                              style: AppTextStyles.greenBoldTextStyle.copyWith(
                                fontSize: 16.5.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
