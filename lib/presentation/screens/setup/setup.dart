import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/setup/setup_event.dart';
import 'package:lunari/presentation/blocs/setup/setup_state.dart';
import '../../../../presentation/widgets/custom_button.dart';
import '../../../data/repositories/save_to_firebase.dart';
import '../../blocs/setup/setup_bloc.dart';
import 'components/birthday_step.dart';
import 'components/cycle_step.dart';
import 'components/height_step.dart';
import 'components/indicator.dart';
import 'components/last_step.dart';
import 'components/name_step.dart';
import 'components/period_step.dart';
import 'components/personalizing.dart';
import 'components/weight_step.dart';

class Setup extends StatelessWidget {
  const Setup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<SetupBloc>().state.currentStep == 6
          ? const Color(0xfff5f5f5)
          : Colors.white,
      appBar: context.watch<SetupBloc>().state.currentStep == 7
      ? null
      : AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: BlocBuilder<SetupBloc, SetupState>(
          builder: (context, state) {
            return Indicator(page: state.currentStep);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: BlocBuilder<SetupBloc, SetupState>(
              builder: (context, state) {
                return Text(
                  "${state.currentStep + 1} / 7".tr(),
                  style: GoogleFonts.urbanist(fontSize: 20.sp, fontWeight: FontWeight.w600),
                );
              },
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final bloc = context.read<SetupBloc>();
              if (bloc.state.currentStep == 0) {
                context.pop();
              } else {
                bloc.add(PreviousStep());
              }
            },
          ),
        ),
      ),
      body: BlocBuilder<SetupBloc, SetupState>(
        builder: (context, state) {
          final bloc = context.read<SetupBloc>();
          return SingleChildScrollView(
            controller: bloc.pageController,
            padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
            child: [
              NameStep(),
              BirthdayStep(),
              WeightStep(),
              HeightStep(),
              PeriodStep(),
              CycleStep(),
              LastStep(),
              Personalizing()
            ][state.currentStep],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<SetupBloc, SetupState>(
        builder: (context, state) {
          return state.currentStep < 7
              ? Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
            child: BlocListener<SetupBloc, SetupState>(
              listener: (context, state) {
                if (state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage!)),
                  );
                }
              },
              child: CustomButton(
                text: state.currentStep == 6 ? "finish".tr() : "continue".tr(),
                bgColor: context.colors.primary,
                color: context.colors.onPrimary,
                onClick: () {
                  if (state.currentStep == 6) {
                    saveToFirebase(context);
                    context.read<SetupBloc>().add(NavigateToPersonalizingPage());
                  } else {
                    if (state.name.isNotEmpty && state.errorMessage == null) {
                      context.read<SetupBloc>().add(ValidateStep());
                    } else {
                      return null;
                    }
                  }
                },
              ),
            ),
          )
              : const SizedBox();
        },
      ),
    );
  }
}
