import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/sign_in/signin_bloc.dart';
import 'package:lunari/presentation/blocs/sign_in/signin_event.dart';
import 'package:lunari/presentation/blocs/sign_in/signin_state.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/email_input.dart';
import '../../widgets/password_input.dart';
import '../../widgets/social_button.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isChecked = false;
  String email = "";
  String password = "";

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
            onPressed: () => context.pop(true),
          ),
        ),
      ),
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) async {
          if (state is SignInLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );
          } else if (state is SignInSuccess) {
            final user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              final doc = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get();

              final data = doc.data();

              if (data == null || data['name'] == null) {
                context.push(AppRouter.setUP);
              } else {
                context.push(AppRouter.main);
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("error".tr())),
              );
            }
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "welcome_back".tr(),
                style: GoogleFonts.urbanist(
                    fontSize: 32.sp, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "acces_lunari_account".tr(),
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
                onChanged: (text) {
                  setState(() {
                    email = text;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              PasswordInput(
                controller: passwordController,
                onChanged: (text) {
                  setState(() {
                    password = text;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        onChanged: (checked) {
                          setState(() {
                            isChecked = checked ?? false;
                          });
                        },
                        value: isChecked,
                        checkColor: Colors.white,
                        activeColor: context.colors.primary,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                            child: Text(
                              "remember_me".tr(),
                              style: GoogleFonts.urbanist(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    ],
                  ),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.go(AppRouter.forgotPassword);
                        },
                        child: Text(
                          "forgot_password".tr(),
                          style: GoogleFonts.urbanist(
                              color: context.colors.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "have_not_account".tr(),
                    style: GoogleFonts.urbanist(
                        fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.push(AppRouter.signUp);
                        },
                        child: Text(
                          "sign_up".tr(),
                          style: GoogleFonts.urbanist(
                              color: context.colors.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "continue_with".tr(),
                      style: GoogleFonts.urbanist(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialButton(
                    height: 50,
                    width: 60,
                    bgColor: Colors.transparent,
                    onClick: () {},
                    icon: "assets/images/google.png",
                  ),
                  const SizedBox(width: 10),
                  SocialButton(
                    height: 50,
                    width: 60,
                    bgColor: Colors.transparent,
                    onClick: () {},
                    icon: "assets/images/apple.png",
                  ),
                  const SizedBox(width: 10),
                  SocialButton(
                    height: 50,
                    width: 60,
                    bgColor: Colors.transparent,
                    onClick: () {},
                    icon: "assets/images/facebook.png",
                  ),
                  const SizedBox(width: 10),
                  SocialButton(
                    height: 50,
                    width: 60,
                    bgColor: Colors.transparent,
                    onClick: () {},
                    icon: "assets/images/twiter.png",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
        child: CustomButton(
          onClick: () {
            context.read<SignInBloc>().add(SignInRequested(
                email: emailController.text,
                password: passwordController.text));
          },
          text: "sign_in".tr(),
          bgColor: context.colors.primary,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

