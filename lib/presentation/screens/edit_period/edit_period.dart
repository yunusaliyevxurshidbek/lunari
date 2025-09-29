import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/presentation/blocs/edit_period/edit_period_bloc.dart';
import '../../../../presentation/widgets/custom_button.dart';
import '../../blocs/calendar/calendar_bloc.dart';
import '../../blocs/calendar/calendar_event.dart';
import '../setup/components/day_name.dart';
import '../setup/components/select_data.dart';
import 'components/shimmer_loading.dart';

class EditPeriod extends StatelessWidget {
  const EditPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateTime> currentMonthDates = _generateDatesForMonth(DateTime.now());

    List<DateTime> previousMonthDates = _generateDatesForMonth(DateTime.now().subtract(const Duration(days: 30)));


    return BlocProvider(
      create: (context) => EditPeriodBloc()..add(LoadSelectedDates()),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.clear, color: Colors.black),
          ),
          centerTitle: true,
          title: Text(
            "Edit Period".tr(),
            style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              color: Colors.black,
              height: 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: InkWell(
                child: SvgPicture.asset(
                  "assets/icons/calendar.svg",
                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
              ),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(24),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DayNames(),
            ),
          ),
        ),

        bottomNavigationBar: BlocBuilder<EditPeriodBloc, EditPeriodState>(
          builder: (context, state) {
            List<DateTime> selectedDates = [];
            if (state is EditPeriodLoaded) {
              selectedDates = state.selectedDates;
            }
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              decoration: const BoxDecoration(color: Colors.white),
              child: CustomButton(
                text: "Save",
                onClick: () {
                  if (selectedDates.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select at least one date!".tr()),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else {
                    context.read<EditPeriodBloc>().add(SaveSelectedDates());
                    context.pop(context);
                  }
                },
                color: Colors.white,
                bgColor: const Color(0xffFF699C),
              ),
            );
          },
        ),
        body: BlocListener<EditPeriodBloc, EditPeriodState>(
          listener: (context, state) {
            if (state is EditPeriodError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is EditPeriodSaved) {
              context.read<EditPeriodBloc>().add(LoadSelectedDates());
            }
          },
          child: BlocBuilder<EditPeriodBloc, EditPeriodState>(
            builder: (context, state) {
              if (state is EditPeriodLoading) {
                return  const Center(
                  child:  ShimmerCalendarPlaceholder(),
                );
              } else if (state is EditPeriodError) {
                return Center(child: Text(state.message));
              } else if (state is EditPeriodLoaded) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      color: Colors.white,
                      child: SelectData(
                        dates:currentMonthDates,
                        selectedDates: state.selectedDates,
                        onDateSelected: (date) {
                          context.read<EditPeriodBloc>().add(ToggleDateSelection(date));
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      color: Colors.white,
                      child: SelectData(
                        dates: previousMonthDates,
                        selectedDates: state.selectedDates,
                        onDateSelected: (date) {
                          context.read<EditPeriodBloc>().add(ToggleDateSelection(date));
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
  List<DateTime> _generateDatesForMonth(DateTime month) {
    List<DateTime> dates = [];
    DateTime firstDay = DateTime(month.year, month.month, 1);
    DateTime lastDay = DateTime(month.year, month.month + 1, 0);

    for (int i = 0; i <= lastDay.difference(firstDay).inDays; i++) {
      dates.add(firstDay.add(Duration(days: i)));
    }
    debugPrint("Generated Dates: $dates");
    return dates;
  }
}
