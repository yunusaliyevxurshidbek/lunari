import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/services/log_service.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_cubit.dart';
import 'package:lunari/presentation/screens/add_log/flow/flow_grid.dart';
import 'package:lunari/presentation/screens/add_log/moods/moods_grid.dart';
import 'package:lunari/presentation/screens/add_log/note.dart';
import 'package:lunari/presentation/screens/add_log/symptoms/symtoms_grid.dart';
import 'package:lunari/presentation/screens/add_log/widget/background_box.dart';
import 'package:lunari/presentation/screens/add_log/widget/choice_day.dart';
import '../../../../presentation/widgets/custom_button.dart';
import '../../../core/constants/add_log_icons.dart';
import '../../../core/router/app_router.dart';
import '../../../data/models/calendar_model.dart';
import '../../blocs/add_log/add_log_state.dart';
import 'medicine/medicine_grid.dart';


class AddLog extends StatefulWidget {
  final CalendarEditModel? log;
  final bool isEdit;
  final DateTime startOfWeek;
  final List<String> weekDays;
  const AddLog({super.key, this.log, this.isEdit = false, required this.startOfWeek, required this.weekDays});


  @override
  State<AddLog> createState() => _AddLogState();
}

class _AddLogState extends State<AddLog> {
  dynamic log;
  bool isEdit = false;
  late final ScrollController _scrollController;
  static const double _itemTotalWidth = 56;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final firstOfMonth = DateTime(now.year, now.month, 1);
    final daySinceStart = now.difference(firstOfMonth).inDays;
    final initialOffset = daySinceStart * _itemTotalWidth;

    _scrollController = ScrollController(initialScrollOffset: initialOffset);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (log == null) {
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;

      if (extra != null) {
        log = extra['log'];
        isEdit = extra['isEdit'] ?? false;
        LogService.i("Received log: $log, isEdit: $isEdit");

        if (isEdit && log.id != null) {
          context.read<AddLogCubit>().fetchDataById(log.id);
        } else {
          context.read<AddLogCubit>().resetState();
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onPrimary,
        surfaceTintColor: context.colors.onPrimary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: GestureDetector(
            onTap: (){
              context.read<AddLogCubit>().resetState();
              context.pop(context);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SvgPicture.asset(
                "assets/icons/remove.svg",
                fit: BoxFit.contain,
                width: 22,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Add Log".tr(),
          style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              color: const Color(0xff212121),
              height: 1.4,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              child: SvgPicture.asset("assets/icons/dots.svg"),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            //! dates:
            BlocBuilder<AddLogCubit, AddLogState>(
              builder: (context, state) {
                final now = DateTime.now();
                final todayStr = DateFormat('yyyy-MM-dd').format(now);
                final selectedStr = DateFormat('yyyy-MM-dd').format(state.date);
                final firstOfMonth = DateTime(now.year, now.month, 1);
                final daysInMonth  = DateTime(now.year, now.month + 1, 0).day;

                return SizedBox(
                  height: 90,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: List.generate(daysInMonth, (i) {
                            final date = firstOfMonth.add(Duration(days: i));
                            final dateStr = DateFormat('yyyy-MM-dd').format(date);

                            final weekDayLabel = weekDays[date.weekday % 7];
                            final dayNumber = DateFormat('dd').format(date);
                            final isToday = dateStr == todayStr;
                            final isSelected = dateStr == selectedStr;

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: GestureDetector(
                                onTap: () => context.read<AddLogCubit>().selectDate(date),
                                child: ChoiceDay(
                                  text: weekDayLabel,
                                  second: dayNumber,
                                  isToday: isToday,
                                  isSelected: isSelected,
                                  primaryColor: context.colors.primary,
                                  secondaryColor: context.colors.secondary,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            //! cards:
            BlocBuilder<AddLogCubit, AddLogState>(
              builder: (context,state) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    spacing: 16,
                    children: [

                      //! Flow_card:
                      const FlowGrid(),

                      //! Symptoms_card:
                      const SymptomsGrid(),

                      //! Mood_card:
                      MoodsGrid(),

                      //! Medicine:
                      MedicineGrid(),

                      //! Note:
                      const Note(),

                      //! Weight:
                      BackgroundBox(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MaterialButton(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            disabledColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              context.push(AppRouter.weight);
                            },
                            child: Row(
                              spacing: 10,
                              children: [
                                Text(
                                  "Weight".tr(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),

                                const Spacer(),
                                Text("${state.weight} kg",style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.lightGreen,
                                  fontSize: 15.sp,
                                ),),
                                const Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ),
                        ),
                      ),

                      //! Temperature:
                      BackgroundBox(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MaterialButton(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            disabledColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              context.push(AppRouter.temperature);
                            },
                            child: Row(
                              spacing: 10,
                              children: [
                                Text(
                                  "Temperature".tr(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),

                                const Spacer(),
                                Text("${state.temperature.toStringAsFixed(2)} °C",style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orangeAccent,
                                  fontSize: 15.sp,
                                ),),
                                const Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ),
                        ),
                      ),

                      //! Water:
                      BackgroundBox(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MaterialButton(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            disabledColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              context.push(AppRouter.drinkWater);
                            },
                            child: Row(
                              spacing: 10,
                              children: [
                                Text(
                                  "Drink Water".tr(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),

                                const Spacer(),
                                Text("${state.totalWaterConsumed} mL",style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                  fontSize: 15.sp,
                                ),),
                                const Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),

          ],
        ),

      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 18, bottom: 16, left: 24, right: 24),
        decoration: const BoxDecoration(color: Colors.white),
        child: CustomButton(
          text: "Save".tr(),
          onClick: () async {
            try {
              await context.read<AddLogCubit>().saveData();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Data saved successfully!".tr())),
              );
              context.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Failed to save data: $e".tr())),
              );
            }
          },
          color: Colors.white,
          bgColor: const Color(0xffFF699C),
        ),
      ),
    );

  }
}
