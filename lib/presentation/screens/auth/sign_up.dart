import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../core/router/app_router.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/email_input.dart';
import '../../widgets/password_input.dart';
import '../../widgets/social_button.dart';
import '../../blocs/sign_up/signup_bloc.dart';
import '../../blocs/sign_up/signup_event.dart';
import '../../blocs/sign_up/signup_state.dart';


class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) async {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!.tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                color: context.colors.error,
                fontSize: 20.sp
              ),),
              backgroundColor: context.colors.errorContainer,
            ),
          );
        }
        if (state.isSuccess) {
          final user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            final doc = await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

            final data = doc.data();

            if (data == null || data['name'] == null) {
              context.go(AppRouter.setUP);
            }
          }
        }
        },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              surfaceTintColor: context.colors.onPrimary ,
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.push(AppRouter.auth),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "join_lunari".tr(),
                    style: GoogleFonts.urbanist(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "signup_to_start".tr(),
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  EmailInput(
                    onChanged: (email) =>
                        context.read<SignUpBloc>().add(EmailChanged(email)),
                  ),
                  const SizedBox(height: 15),

                  PasswordInput(
                    onChanged: (password) {
                      context.read<SignUpBloc>().add(PasswordChanged(password));
                    }
                        ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: state.termsAccepted,
                              onChanged: (checked) => context
                                  .read<SignUpBloc>()
                                  .add(TermsAccepted(checked ?? false)),
                              checkColor: Colors.white,
                              activeColor: context.colors.primary,
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () => context
                                    .read<SignUpBloc>()
                                    .add(TermsAccepted(!state.termsAccepted)),
                                child: Text(
                                  "i_agree".tr(),
                                  style: GoogleFonts.urbanist(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: () => context.push("/terms_service"),
                          child: Text(
                            "terms_service".tr(),
                            style: GoogleFonts.urbanist(
                              color: context.colors.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "have_account".tr(),
                        style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => context.push(AppRouter.signIn),
                          child: Text(
                            "sign_in".tr(),
                            style: GoogleFonts.urbanist(
                              color: context.colors.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "continue_with".tr(),
                          style: GoogleFonts.urbanist(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        height: 50,
                        width: 60,
                        bgColor: Colors.transparent,
                        onClick: () =>
                            context.read<SignUpBloc>().add(GoogleSignUpRequested()),
                        icon: "assets/images/google.png",
                      ),
                      const SizedBox(width: 10),
                      SocialButton(
                        height: 50,
                        width: 60,
                        bgColor: Colors.transparent,
                        onClick: () =>
                            context.read<SignUpBloc>().add(AppleSignUpRequested()),
                        icon: "assets/images/apple.png",
                      ),
                      const SizedBox(width: 10),
                      SocialButton(
                        height: 50,
                        width: 60,
                        bgColor: Colors.transparent,
                        onClick: () =>
                            context.read<SignUpBloc>().add(FacebookSignUpRequested()),
                        icon: "assets/images/facebook.png",
                      ),
                      const SizedBox(width: 10),
                      SocialButton(
                        height: 50,
                        width: 60,
                        bgColor: Colors.transparent,
                        onClick: () =>
                            context.read<SignUpBloc>().add(TwitterSignUpRequested()),
                        icon: "assets/images/twiter.png",
                      ),
                    ],
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
              child: CustomButton(
                onClick: state.isLoading
                    ? null
                    : () => context.read<SignUpBloc>().add(SignUpSubmitted()),
                text: "sign_up".tr(),
                bgColor: context.colors.primary,
                color: Colors.white,
              ),
            ),
          ),
            if (state.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        ]
        );
      },
    );
  }
}
