import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/forgot_password/forgot_bloc.dart';
import 'package:lunari/presentation/blocs/forgot_password/forgot_state.dart';
import '../../../../presentation/widgets/custom_button.dart';
import '../../blocs/forgot_password/forgot_event.dart';
import '../../widgets/email_input.dart';

class ForgetPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();


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
            onPressed: () => {},
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "forgot_password".tr(),
              style: GoogleFonts.urbanist(
                  fontSize: 32.sp, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "enter_the_email".tr(),
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black.withOpacity(0.5)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            EmailInput(
              controller: emailController,
                title: "registered_email".tr(),
                onChanged: (text) {}
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordOtpSent) {
            context.push(
              AppRouter.otpVerification,
              extra: emailController.text,
            );
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
            child: GestureDetector(
              onTap: () {
                context.read<ForgotPasswordBloc>().add(
                  ForgotPasswordRequested(emailController.text),
                );
              },
              child: CustomButton(
                text: state is ForgotPasswordLoading ? "sending".tr() : "send_otp_code".tr(),
                bgColor: context.colors.primary,
                color: Colors.white,
              ),
            ),
          );
        },
      ),

    );
  }
}
