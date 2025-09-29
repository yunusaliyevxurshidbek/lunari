import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lunari/data/repositories/auth_repository_impl.dart';
import 'package:lunari/presentation/blocs/auth/auth_bloc.dart';
import 'package:lunari/presentation/blocs/forgot_password/forgot_bloc.dart';
import 'package:lunari/presentation/blocs/setup/setup_bloc.dart';
import 'package:lunari/presentation/blocs/sign_up/signup_bloc.dart';
import 'package:lunari/presentation/screens/account/help%20&%20support/pages/privacy_policy.dart';
import 'package:lunari/presentation/screens/account/help%20&%20support/pages/terms_service.dart';
import 'package:lunari/presentation/screens/account/invite_friends/invite_friend.dart';
import 'package:lunari/presentation/screens/account/personal_info/personal_info.dart';
import 'package:lunari/presentation/screens/account/personal_info/widgets/editable_personal_info_widget.dart';
import 'package:lunari/presentation/screens/add_log/symptoms/widget/symptoms_more.dart';
import 'package:lunari/presentation/widgets/calendar_widget.dart';
import '../../presentation/blocs/add_log/add_log_cubit.dart';
import '../../presentation/blocs/calendar/calendar_bloc.dart';
import '../../presentation/blocs/calendar/calendar_event.dart';
import '../../presentation/blocs/calendar/calendar_state.dart';
import '../../presentation/blocs/sign_in/signin_bloc.dart';
import '../../presentation/screens/account/invite_friends/add_friend.dart';
import '../../presentation/screens/add_log/moods/widget/moods_more.dart';
import '../../presentation/screens/auth/auth.dart';
import '../../presentation/screens/auth/sign_up.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/screens/auth/splash/splash.dart';
import '../../presentation/blocs/splash/splash_bloc.dart';
import '../../presentation/screens/account/about_subscription/about_subscription.dart';
import '../../presentation/screens/account/analytics/analytic_page.dart';
import '../../presentation/screens/account/app_appearance/app_appearance.dart';
import '../../presentation/screens/account/help & support/support.dart';
import '../../presentation/screens/account/linked_acounts/linked_acounts.dart';
import '../../presentation/screens/account/payment_methods/payment_methods.dart';
import '../../presentation/screens/account/preferences/preferences.dart';
import '../../presentation/screens/account/reminder/reminder.dart';
import '../../presentation/screens/account/security/security.dart';
import '../../presentation/screens/add_log/add_log.dart';
import '../../presentation/screens/auth/forget_password.dart';
import '../../presentation/screens/auth/otp_verification.dart';
import '../../presentation/screens/auth/secure.dart';
import '../../presentation/screens/auth/sign_in.dart';
import '../../presentation/screens/auth/success_auth.dart';
import '../../presentation/screens/calendar/calendar.dart';
import '../../presentation/screens/calendar/drink_water.dart';
import '../../presentation/screens/calendar/switch_cup.dart';
import '../../presentation/screens/calendar/temperature.dart';
import '../../presentation/screens/calendar/weight.dart';
import '../../presentation/screens/edit_period/edit_period.dart';
import '../../presentation/screens/home/home.dart';
import '../../presentation/screens/loading/loading.dart';
import '../../presentation/screens/main/main_page.dart';
import '../../presentation/screens/phase/phase.dart';
import '../../presentation/screens/setup/setup.dart';
import 'app_router.dart';

final router = GoRouter(
  initialLocation: AppRouter.loading,    //! loading
  routes: [
    GoRoute(
        path: AppRouter.loading, builder: (context, state) => const Loading()),
    GoRoute(
      path: AppRouter.splash,
      builder: (context, state) => BlocProvider(
        create: (context) => SplashBloc(),
        child: const Splash(),
      ),
    ),
    GoRoute(
        path: AppRouter.signUp,
        builder: (context, state) => BlocProvider(
            create: (context) => SignUpBloc(
                  authRepository: context.read<AuthRepository>(),
                ),
            child: const SignUp())),
    GoRoute(
        path: AppRouter.signIn,
        builder: (context, state) => BlocProvider(
            create: (context) =>
                SignInBloc(authRepository: AuthRepositoryImpl()),
            child: const SignIn())),
    GoRoute(
        path: AppRouter.auth,
        builder: (context, state) => BlocProvider(
              create: (context) => AuthBloc(AuthRepositoryImpl()),
              child: const Auth(),
            )),
    GoRoute(path: AppRouter.home, builder: (context, state) => const Home()),
    GoRoute(
        path: AppRouter.main, builder: (context, state) => const MainPage()),
    GoRoute(
        path: AppRouter.preferences,
        builder: (context, state) => const PreferencesPage()),
    GoRoute(
        path: AppRouter.reminder,
        builder: (context, state) => const Reminder()),
    GoRoute(
        path: AppRouter.security,
        builder: (context, state) => const Security()),
    GoRoute(
        path: AppRouter.paymentmethods,
        builder: (context, state) => const PaymentMethods()),
    GoRoute(
        path: AppRouter.subscription,
        builder: (context, state) => const AboutSubscription()),
    GoRoute(
        path: AppRouter.linkedacounts,
        builder: (context, state) => const LinkedAcounts()),
    GoRoute(
        path: AppRouter.analytics,
        builder: (context, state) => const AnalyticPage()),
    GoRoute(
        path: AppRouter.appearance,
        builder: (context, state) => const AppAppearance()),
    GoRoute(
        path: AppRouter.support, builder: (context, state) => const Support()),
    GoRoute(
        path: AppRouter.calendar,
        builder: (context, state) => const Calendar()),
    GoRoute(
      path: AppRouter.addLog,
      builder: (context, state) {
        final selectedDate = context.read<AddLogCubit>().state.date;
        final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

        return AddLog(
          startOfWeek: startOfWeek,
          weekDays: weekDays,
        );
      },
    ),
    GoRoute(
        path: AppRouter.phaseDetail,
        builder: (context, state) => const Phase()),
    GoRoute(
        path: AppRouter.editPeriod,
        builder: (context, state) => const EditPeriod()),
    GoRoute(
        path: AppRouter.setUP,
        builder: (context, state) => BlocProvider(
            create: (context) => SetupBloc(), child: const Setup())),
    GoRoute(
        path: AppRouter.drinkWater,
        builder: (context, state) => const DrinkWater()),
    GoRoute(
        path: AppRouter.switchCup,
        builder: (context, state) => const SwitchCup()),
    GoRoute(
        path: AppRouter.symptoms,
        builder: (context, state) => const SymptomsMore()),
    GoRoute(path: AppRouter.moods, builder: (context, state) => const Moods()),
    GoRoute(
        path: AppRouter.temperature,
        builder: (context, state) => const Temperature()),
    GoRoute(
        path: AppRouter.weight, builder: (context, state) => const Weight()),
    GoRoute(
      path: AppRouter.forgotPassword,
      builder: (context, state) => BlocProvider(
        create: (context) => ForgotPasswordBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: ForgetPassword(),
      ),
    ),
    GoRoute(
      path: AppRouter.otpVerification,
      builder: (context, state) {
        final email = state.extra as String? ?? '';

        return BlocProvider(
          create: (context) =>
              ForgotPasswordBloc(authRepository: AuthRepositoryImpl()),
          child: OtpVerification(email: email),
        );
      },
    ),
    GoRoute(
      path: AppRouter.secure,
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return BlocProvider(
          create: (context) =>
              ForgotPasswordBloc(authRepository: AuthRepositoryImpl()),
          child: Secure(email: email),
        );
      },
    ),
    GoRoute(
        path: AppRouter.successAuth,
        builder: (context, state) => const SuccessAuth()),
    GoRoute(
        path: AppRouter.personal,
        builder: (context, state) => const PersonalInfo()),
    GoRoute(
        path: AppRouter.inviteFriend,
        builder: (context, state) => const InviteFriend()),
    GoRoute(
        path: AppRouter.addFriend,
        builder: (context, state) => const AddFriend()),
    GoRoute(
        path: AppRouter.privacy_policy,
        builder: (context, state) => const PrivacyPolicy()),
    GoRoute(
        path: AppRouter.terms_service,
        builder: (context, state) => const TermsService()),
    GoRoute(
      path: AppRouter.calendar_widget,
      builder: (context, state) {
        return BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, calState) {
            return CalendarWidget(
              currentMonth: calState.currentMonth,
              selectedDate: calState.selectedDate,
              lastDate: calState.last,
              period: calState.period,
              onDayTapped: (date) {
                context.read<CalendarBloc>().add(DateSelected(date));
              },
            );
          },
        );
      },
    ),

    GoRoute(
        path: AppRouter.edit_personal_info,
        builder: (context, state) => const EditablePersonalInfoWidget()),


  ],
);
