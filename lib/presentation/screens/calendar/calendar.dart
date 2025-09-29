import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/services/log_service.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/calendar/calendar_bloc.dart';
import 'package:lunari/presentation/blocs/calendar/calendar_state.dart';
import 'package:lunari/presentation/screens/calendar/widget/shimmer_loading_effect.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/router/app_router.dart';
import '../../blocs/calendar/calendar_event.dart';
import '../../widgets/calendar_widget.dart';


class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late CalendarBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<CalendarBloc>();
    _bloc.add(LoadLogs());
    _bloc.add(SubscribeToLogs());
    _bloc.add(LoadUserData());
  }

  Future<void> _pickViaMonthPicker() async {
    final state = _bloc.state;
    final picked = await showMonthPicker(
      context: context,
      initialDate: state.currentMonth,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime(2100, 12),
        monthPickerDialogSettings: MonthPickerDialogSettings(
          headerSettings: const PickerHeaderSettings(
            headerCurrentPageTextStyle: TextStyle(fontSize: 14),
            headerSelectedIntervalTextStyle: TextStyle(fontSize: 16),
          ),
          dialogSettings: PickerDialogSettings(
            locale: const Locale('en'),
            dialogRoundedCornersRadius: 20,
            dialogBackgroundColor: Colors.blueGrey[50],

          ),
        ),);
    if (picked != null) {
      final monthOnly = DateTime(picked.year, picked.month);
      _bloc.add(DateSelected(monthOnly));
    }
  }
  String _getMonthName(int month) {
    const names = [
      'january',
      'february',
      'march',
      'april',
      'may',
      'june',
      'july',
      'august',
      'september',
      'october',
      'november',
      'december',
    ];
    return names[month - 1].tr();
  }

  String calculatePregnancyChance({
    required DateTime date,
    required List<DateTime> editedDates,
    required DateTime? ovulationDate,
  }) {
    final isPeriod = editedDates.any((d) =>
    d.year == date.year &&
        d.month == date.month &&
        d.day == date.day
    );
    if (isPeriod) return 'low';

    if (ovulationDate != null) {
      final diff = date.difference(ovulationDate).inDays;
      if (diff >= 0 && diff <= 4) {
        return 'high';
      }
    }

    return 'medium';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      appBar: AppBar(
        backgroundColor: context.colors.onPrimary,
        surfaceTintColor: context.colors.onPrimary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/images/logo_filled.png",
              fit: BoxFit.contain,
              width: 22,
            ),
          ),
        ),
        centerTitle: true,
        title: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            final m = _getMonthName(state.currentMonth.month);
            final y = state.currentMonth.year;
            return Text('$m $y',
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: _pickViaMonthPicker,
              icon: SvgPicture.asset(AppIcons.calendar)),
        ],
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          final today = DateTime.now();
          final chanceKey = calculatePregnancyChance(
            date: today,
            editedDates: state.editedDates,
            ovulationDate: state.ovulationDate,
          );

          Color chanceColor;
          switch (chanceKey) {
            case 'high':
              chanceColor = const Color(0xFFFF699C);
              break;
            case 'medium':
              chanceColor = const Color(0xFF1A96F0);
              break;
            default:
              chanceColor = const Color(0xFF607D8A);
          }

          final chanceText = chanceKey.tr();

          return SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [

                // calendar:
                CalendarWidget(
                  currentMonth: state.currentMonth,
                  selectedDate: state.selectedDate,
                  lastDate: state.last,
                  period: state.period,
                  ovulationDate: state.ovulationDate,
                  editedDates: state.editedDates,
                  onDayTapped: (date) {
                    _bloc.add(DateSelected(date));
                  },
                ),

                // logs:
                BlocBuilder<CalendarBloc, CalendarState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const ShimmerLoadingEffect();
                    }
                    if (state.logs.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Text("No Record"),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.logs.length,
                      itemBuilder: (context, index) {
                        final log = state.logs[index];

                        DateTime logDate;
                        try {
                          logDate = DateTime.parse(log.date).toLocal();
                        } catch (_) {
                          logDate = DateFormat('dd.MM.yyyy').parseStrict(log.date);
                        }

                        String dayText = '-';

                        final periodIndex = state.editedDates.indexWhere((d) =>
                        d.year == logDate.year &&
                            d.month == logDate.month &&
                            d.day == logDate.day
                        );

                        if (periodIndex >= 0) {
                          dayText = 'Period Day ${periodIndex + 1}';
                        } else if (state.editedDates.isNotEmpty) {
                          final lastPeriod = state.editedDates.reduce(
                                  (a, b) => a.isAfter(b) ? a : b
                          );
                          final diff = logDate.difference(lastPeriod).inDays;
                          if (diff > 0) {
                            dayText = 'Cycle Day $diff';
                          }
                        }

                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              color: context.colors.onPrimary,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(log.date,style: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.w700,
                                        color: context.colors.scrim,
                                        fontSize: 20.sp,
                                      ),),
                                      Text(dayText,style: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.w500,
                                        color: context.ccolors.greyScale700,
                                        fontSize: 15.sp,
                                      ),),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      LogService.e("Sending log: $log");
                                      context.push(AppRouter.addLog, extra: {'log': log, 'isEdit': true});
                                    },
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(width: 0.5, color: context.ccolors.border),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            AppIcons.blood,
                                            height: 15,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "edit".tr(),
                                            style: context.textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Divider(thickness: 1,color: context.ccolors.dividerLight,),
                          ],
                        );
                      },
                    );

                  },
                ),


                // chance_of_text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Container(
                        padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: chanceColor,
                        ),
                        child: Text(
                          chanceText,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "chance_getting_pregnant".tr(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),



                // add_log_button:
                MaterialButton(
                  height: 45,
                  minWidth: 100,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  color: context.colors.primary,
                  elevation: 0,
                  onPressed: () {
                    context.push(AppRouter.addLog);
                  },
                  child: Text(
                    "add_log".tr(),
                    style:  GoogleFonts.urbanist(
                      fontWeight: FontWeight.w700,
                      color: context.colors.onPrimary,
                      fontSize: 20.sp
                    ),
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}


