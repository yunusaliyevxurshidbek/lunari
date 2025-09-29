import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/router/app_router.dart';
import '../../../blocs/user_panel/user_bloc.dart';
import '../../../blocs/user_panel/user_state.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state.isLoading) return CircularProgressIndicator();
        if (state.error != null) return Text('Error: ${state.error}');

          return InkWell(
            onTap: () {
              context.push(AppRouter.personal);
            },
            child: Container(
              width: 1.sw,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // user_photo:
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/female_avatar.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              state.name,
                              style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                color: const Color(0xff212121),
                                height: 1.4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            state.email,
                            style: GoogleFonts.urbanist(
                              fontSize: 14.sp,
                              color: const Color(0xff616161),
                              height: 1.6,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 32.sp,
                  ),
                ],
              ),
            ),
          );
        }


    );
  }
}
