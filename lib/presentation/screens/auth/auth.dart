import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/auth/auth_event.dart';
import 'package:lunari/presentation/blocs/auth/auth_state.dart';
import '../../../core/router/app_router.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/social_button.dart';
import '../../blocs/auth/auth_bloc.dart';


class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is AuthFailure) {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colors.error,
            ),
          );
        }

        if (state is AuthSuccess) {
          final user = FirebaseAuth.instance.currentUser;
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .get();

          final userName = userDoc.data()?['name'];
          if (userName == null) {
            context.push(AppRouter.setUP);
          } else {
            Navigator.of(context).pop();
            context.push(AppRouter.main);
          }
        }

        if (state is AuthNavigateToSignUp) {
          context.push(AppRouter.signUp);
        }
        if (state is AuthNavigateToSignIn) {
          context.push(AppRouter.signIn);
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.onPrimary,
        appBar: AppBar(
          surfaceTintColor: context.colors.onPrimary,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        extendBodyBehindAppBar: true,
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: 1.sw,
            height: constraints.maxHeight,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // top_texts:
                Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/logo_filled.png",
                      width: 0.4.sw,
                      height: 0.4.sw,
                    ),
                    Text(
                      "lets_start".tr(),
                      style: GoogleFonts.urbanist(
                          color: context.colors.scrim,
                          fontSize: 32.sp,
                          height: 1.4,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "lets_dive".tr(),
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        height: 1.4,
                        color: context.ccolors.greyScale700,
                      ),
                    ),
                  ],
                ),

                // social_buttons:
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Column(
                    spacing: 10,
                    children: <Widget>[
                      SocialButton(
                        height: 50,
                        text: "with_google".tr(),
                        bgColor: Colors.transparent,
                        onClick: () {
                          context.read<AuthBloc>().add(GoogleSignInRequested());
                        },
                        icon: "assets/images/google.png",
                      ),
                      if (Platform.isIOS)
                        SocialButton(
                          height: 50,
                          text: "with_apple".tr(),
                          bgColor: Colors.transparent,
                          onClick: () {
                            context.read<AuthBloc>().add(AplleSignInPressed());
                          },
                          icon: "assets/images/apple.png",
                        ),
                      SocialButton(
                        height: 50,
                        text: "with_facebook".tr(),
                        bgColor: Colors.transparent,
                        onClick: () {
                          context
                              .read<AuthBloc>()
                              .add(FacebookSignInRequested());
                        },
                        icon: "assets/images/facebook.png",
                      ),
                      SocialButton(
                        height: 50,
                        text: "with_x".tr(),
                        bgColor: Colors.transparent,
                        onClick: () {
                          context
                              .read<AuthBloc>()
                              .add(XSignInRequested()); //! XSignInPressed
                        },
                        icon: "assets/images/twiter.png",
                      )
                    ],
                  );
                }),

                // sign up & in:
                Column(
                  children: <Widget>[
                    CustomButton(
                      height: 50,
                      onClick: () {
                        context.read<AuthBloc>().add(SignUpPressed());
                      },
                      text: "sign_up".tr(),
                      bgColor: context.colors.primary,
                      color: context.colors.onPrimary,
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      height: 50,
                      onClick: () {
                        context.read<AuthBloc>().add(SignInPressed());
                      },
                      text: "sign_in".tr(),
                      bgColor: context.colors.secondary,
                      color: context.colors.primary,
                    )
                  ],
                ),

                // Privacy and Terms
                Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        context.push("/privacy_policy");
                      },
                      child: Text(
                        "privacy_policy".tr(),
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w400,
                            color: context.ccolors.greyScale700,
                            height: 1.6,
                            fontSize: 14.sp),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push("/terms_service");
                      },
                      child: Text(
                        "terms_service".tr(),
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w400,
                            color: context.ccolors.greyScale700,
                            height: 1.6,
                            fontSize: 14.sp),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

