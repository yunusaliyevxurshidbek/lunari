import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/splash/splash_bloc.dart';
import 'package:lunari/presentation/blocs/splash/splash_event.dart';
import 'package:lunari/presentation/blocs/splash/splash_state.dart';
import 'package:lunari/presentation/screens/auth/splash/widgets/clip_shadow.dart';
import 'package:lunari/presentation/screens/auth/splash/widgets/custom_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/splash.dart';
import '../../../widgets/custom_button.dart';


class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        final bloc = context.read<SplashBloc>();

        return Scaffold(
            backgroundColor: context.colors.primary,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 0.6.sw,
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/iphone14.png")
                            )
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            splash[state.currentPage]["image"],
                            width: 0.6.sw,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Positioned(
                    bottom: 0.5.sh,
                    child: ClipShadowPath(
                      shadow: Shadow(
                          blurRadius: 24.0,
                          color: const Color(0xff181A20).withOpacity(0.12)
                      ),
                      clipper: CustomContainer(),
                      child: Container(
                        width: 1.sw,
                        height: 60,
                        color: context.colors.onPrimary,
                      ),
                    )
                ),

                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 0.5.sh,
                    width: 1.sw,
                    padding: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: context.colors.onPrimary,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                            height: 0.28.sh,
                            child: PageView.builder(
                              controller: bloc.pageController,
                              onPageChanged: (index) {
                                context.read<SplashBloc>().add(PageChanged(index));
                              },
                              itemCount: splash.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        splash[index]["title"],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                          fontSize: 32.sp,
                                          color: context.colors.scrim,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          splash[index]["description"],     // error in lozalization:
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.urbanist(
                                            fontWeight: FontWeight.w400,
                                            height: 1.6,
                                            fontSize: 18.sp,
                                            color: context.ccolors.greyScale700,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                        ),

                        // Page indicator
                        Flexible(
                            fit: FlexFit.loose,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SmoothPageIndicator(
                                  controller: bloc.pageController,
                                  count: splash.length,
                                  effect: WormEffect(
                                      dotWidth: 10,
                                      dotHeight: 10,
                                      activeDotColor: context.colors.primary
                                  ),
                                  onDotClicked: (index) {
                                    context.read<SplashBloc>().add(PageChanged(index));
                                    bloc.pageController.animateToPage(
                                      index,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            extendBody: true,
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
              child: state.currentPage == 2
                  ? CustomButton(
                text: "lets_start".tr(),
                onClick: () {
                  context.read<SplashBloc>().add(StartPressed(context));
                },
                width: 0.5.sw - 30,
                bgColor: context.colors.primary,
                color: context.colors.onPrimary,
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomButton(
                    text: "skip".tr(),
                    onClick: () {
                      context.read<SplashBloc>().add(SkipPressed(context));
                    },
                    width: 0.5.sw - 30,
                    bgColor: context.colors.secondary,
                    color: context.colors.primary,
                  ),
                  CustomButton(
                    text: "continue".tr(),
                    onClick: () {
                      context.read<SplashBloc>().add(ContinuePressed());
                    },
                    width: 0.5.sw - 30,
                    bgColor: context.colors.primary,
                    color: context.colors.onPrimary,
                  )
                ],
              ),
            )
        );
      },
    );
  }
}