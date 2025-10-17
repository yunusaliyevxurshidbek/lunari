import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/data/repositories/preferences_repository.dart';
import 'package:lunari/data/repositories/tracker_repository.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_cubit.dart';
import 'package:lunari/presentation/blocs/auth/auth_bloc.dart';
import 'package:lunari/domain/repositories/auth_repository.dart';
import 'package:lunari/data/repositories/auth_repository_impl.dart';
import 'package:lunari/presentation/blocs/calendar/calendar_bloc.dart';
import 'package:lunari/presentation/blocs/home_tracker/tracker_bloc.dart';
import 'package:lunari/presentation/blocs/home_tracker/tracker_event.dart';
import 'package:lunari/presentation/blocs/preferences/preferences_bloc.dart';
import 'package:lunari/presentation/blocs/preferences/preferences_event.dart';
import 'package:lunari/presentation/blocs/ringtone/ringtone_cubit.dart';
import 'package:lunari/presentation/blocs/user_panel/user_bloc.dart';
import 'package:lunari/presentation/blocs/user_panel/user_event.dart';
import 'package:lunari/presentation/blocs/water/water_bloc.dart';
import 'package:lunari/presentation/cubit/log_count/log_count_cubit.dart';
import 'package:lunari/presentation/cubit/week_cubit/week_cubit.dart';
import 'package:lunari/presentation/screens/account/components/user_panel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/style/app_theme.dart';
import 'core/router/go_router.dart';
import 'data/repositories/log_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'presentation/cubit/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final PreferencesRepository? preferencesRepository;
  final bool isFirstLaunch;
  final User? currentUser;

  const MyApp({
    super.key,
    required this.isFirstLaunch,
    required this.prefs,
    this.preferencesRepository,
    this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(AuthRepositoryImpl()),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(prefs),
        ),
        RepositoryProvider(create: (context) => UserRepository()),
        BlocProvider(create: (context) => RingtoneCubit()),
        BlocProvider(create: (context) => AddLogCubit()),
        BlocProvider(create: (context) => WaterBloc()),
        BlocProvider(create: (context) => CalendarBloc()),
        BlocProvider(
          create: (_) => UserProfileBloc()..add(LoadUserProfile()),
        ),
        BlocProvider(
            create: (context) => LogCountCubit(FirebaseFirestore.instance)
        ),
        if (preferencesRepository != null)
          BlocProvider(
            create: (_) => PreferencesBloc(preferencesRepository!)
              ..add(LoadPreferences()),
          ),
        if (currentUser != null)
          BlocProvider(
            create: (context) => WeekCubit(repo: LogRepository(), uid: currentUser!.uid)
              ..loadLogsForCurrentWeek(),
          ),

        BlocProvider(
            create: (context) => TrackerBloc(repository: TrackerRepository())
              ..add(LoadTrackerData())
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return Builder(
            builder: (context) {
              return BlocBuilder<ThemeCubit, ThemeMode>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, _) {
                  return MaterialApp.router(
                    restorationScopeId: 'app',
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    onGenerateTitle: (BuildContext context) => 'appTitle'.tr(),
                    routerConfig: router,
                    theme: AppTheme.light,
                    // Force light mode across the entire app regardless of system/user preference.
                    // Removing darkTheme and overriding themeMode prevents dark colors from being applied.
                    themeMode: ThemeMode.light,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
