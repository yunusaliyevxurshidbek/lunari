import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/forgot_password/forgot_bloc.dart';
import 'package:lunari/presentation/blocs/forgot_password/forgot_event.dart';
import 'package:lunari/presentation/blocs/forgot_password/forgot_state.dart';
import '../../../../presentation/widgets/custom_button.dart';
import '../../widgets/password_input.dart';

class Secure extends StatefulWidget {
  final String email;
  const Secure({super.key, required this.email});

  @override
  State<Secure> createState() => _SecureState();
}

class _SecureState extends State<Secure> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String newPassword = "";
  String confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "secure_your_account".tr(),
              style: GoogleFonts.urbanist(
                  fontSize: 32.sp, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "enter_new_password".tr(),
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 15),
            PasswordInput(
              text: "create_new_password",
              controller: newPasswordController,
            ),
            const SizedBox(height: 15),
            PasswordInput(
              text: "confirm_new_password".tr(),
              controller: confirmPasswordController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text("password_updated".tr())),
            );
            context.push(AppRouter.successAuth);
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
                final newPassword = newPasswordController.text.trim();
                final confirmPassword = confirmPasswordController.text.trim();

                if (newPassword.isEmpty || confirmPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text("Please fill all fields!".tr())),
                  );
                  return;
                }

                if (newPassword != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text("Passwords do not match!".tr())),
                  );
                  return;
                }

                context.read<ForgotPasswordBloc>().add(
                  ResetPasswordRequested(
                    email: widget.email,
                    newPassword: newPassword,
                  ),
                );
              },
              child: CustomButton(
                text: state is ForgotPasswordLoading ? "saving".tr() : "save_new_password".tr(),
                bgColor: context.colors.primary,
                color: context.colors.onPrimary,

              ),
            ),
          );

        },
      ),
    );

  }
  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

}
