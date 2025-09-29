import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/forgot_password/forgot_bloc.dart';
import 'package:lunari/presentation/blocs/forgot_password/forgot_event.dart';
import 'package:lunari/presentation/blocs/forgot_password/forgot_state.dart';

import '../../../../presentation/widgets/custom_button.dart';

class OtpVerification extends StatefulWidget {
  final String email;

  const OtpVerification({super.key, required this.email});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text("Vertification Confirmed!".tr())),
            );
            context.push(AppRouter.secure,extra: widget.email);

          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "enter_otp_code".tr(),
                  style: GoogleFonts.urbanist(
                      fontSize: 32.sp, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "we_sent_otp".tr(),
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 1.sw,
                  child: OtpTextField(
                    numberOfFields: 4,
                    borderColor: context.colors.primary,
                    focusedBorderColor: context.colors.primary,
                    fieldWidth: 0.25.sw - 25,
                    showFieldAsBox: true,
                    fieldHeight: 66,
                    borderRadius: BorderRadius.circular(12),
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      otpCode = verificationCode;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                              text: "you_can_resend ".tr(),
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  color: Colors.black.withOpacity(0.5)),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "56",
                                  style: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp,
                                      color: context.colors.primary),
                                ),
                                TextSpan(
                                  text: " second".tr(),
                                  style: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp,
                                      color: Colors.black.withOpacity(0.5)),
                                )
                              ])),
                      const SizedBox(height: 10),
                      InkWell(

                        child: Text(
                          "resend_code".tr(),
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        onTap: () {
                          context.push(AppRouter.forgotPassword);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
        child: GestureDetector(
          onTap: () {
            if (otpCode.length == 4) {
              context.read<ForgotPasswordBloc>().add(
                VerifyOtpRequested(widget.email, otpCode),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text("enter_otp_code".tr())),
              );
            }
          },
          child: CustomButton(
            text: "confirm_otp".tr(),
            bgColor: context.colors.primary,
            color: Colors.white,

          ),
        ),
      ),
    );
  }
}
