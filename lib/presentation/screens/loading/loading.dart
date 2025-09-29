import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/router/app_router.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isTapped = true;
      });
    });
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    Future.delayed(const Duration(seconds: 3), () async {
      if (isFirstTime) {
        await prefs.setBool('isFirstTime', false);
        context.go(AppRouter.splash);
      } else {
        final user = FirebaseAuth.instance.currentUser;
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get();

        final userName = userDoc.data()?['name'];

        if (userName == null) {
          context.push(AppRouter.auth);          // auth
        } else if (user != null) {
          context.go(AppRouter.main);           // main
        } else {
          context.go(AppRouter.auth);           // auth
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFF699C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedContainer(
              height: isTapped ? 0.3.sw : 0.2.sw,
              width: isTapped ? 0.3.sw : 0.2.sw,
              duration: const Duration(seconds: 3),
              child: Image.asset(
                "assets/images/logo.png",
                width: 0.3.sw,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                "Lunari",
                style: GoogleFonts.urbanist(
                  color: const Color(0xffffffff),
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 0.3.sh,
        alignment: Alignment.center,
        child: LoadingAnimationWidget.beat(size: 36, color: Colors.white),
      ),
    );
  }
}
