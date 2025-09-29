import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/presentation/screens/tracker/widgets/log_count_widgets/shimmer_loading_page.dart';
import '../../../../data/datasources/local/log_count_element_data.dart';
import '../../../../data/helper/log_counter.dart';
import '../../../cubit/log_count/log_count_cubit.dart';
import '../../../cubit/log_count/log_count_state.dart';
import '../customize_cards/circle_widget.dart';
import '../customize_cards/custom_card.dart';
import '../customize_cards/form_widget.dart';
import '../customize_cards/view_more.dart';
import 'log_count_widgets/flow_section.dart';
import 'log_count_widgets/my_cycles_card.dart';


class LogCountSection extends StatefulWidget {
  @override
  _LogCountSectionState createState() => _LogCountSectionState();
}

class _LogCountSectionState extends State<LogCountSection> {
  bool _symptomsExpanded = false;
  bool _moodsExpanded = false;
  bool _medicineExpanded = false;

  Map<String, int> flowCounts = {
    'Light': 0, 'Medium': 0, 'Heavy': 0, 'Disaster': 0
  };
  Map<String, int> symptomCounts = {};
  Map<String, int> moodCounts = {};
  Map<String, int> medicineCounts = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<LogCountCubit, LogCountState>(
            builder: (context, state) {
              if (state is LogCountLoading) {
                return const ShimmerLoadingWidget();
              }
              if (state is LogCountLoaded) {
                final aggregated = aggregateCounts(state.entries);
                flowCounts = aggregated['flow'] as Map<String, int>;
                symptomCounts = aggregated['symptoms'] as Map<String, int>;
                moodCounts = aggregated['moods'] as Map<String, int>;
                medicineCounts = aggregated['medicines'] as Map<String, int>;
              }

              return Column(
                spacing: 20,
                children: [
                  //! My_cycles_card:
                  const MyCyclesCard(),

                  //! Flow_card:
                  StatsSection(
                    title: "Flow",
                    icons: [
                      "assets/icons/blood.svg",
                      "assets/images/flow_medium.png",
                      "assets/images/flow_heavy.png",
                      "assets/images/flow_disaster.png",
                    ],
                    labels: ["Light", "Medium", "Heavy", "Disaster"],
                    counts: [
                      flowCounts['Light']!,
                      flowCounts['Medium']!,
                      flowCounts['Heavy']!,
                      flowCounts['Disaster']!,
                    ],
                  ),

                  //! Symptoms_card:
                  _buildSymptomsSection(),

                  //! Mood_card:
                  _buildMoodsSection(),

                  //! Medicine:
                  _buildMedicineSection(),
                ],
              );
            }
        ),
      ),
    );
  }

  Widget _buildSymptomsSection() {
    final filteredSymptoms = allSymptoms
        .where((symptom) => (symptomCounts[symptom['key']] ?? 0) > 0)
        .toList();

    final symptomsToShow = _symptomsExpanded
        ? filteredSymptoms
        : filteredSymptoms.take(8).toList();

    return CustomCard(
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Text(
                "Symptoms".tr(),
                style: GoogleFonts.urbanist(
                  color: const Color(0xff212121),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),

          if (symptomsToShow.isNotEmpty)
            Builder(
              builder: (context) {
                List<Widget> rows = [];
                for (int i = 0; i < symptomsToShow.length; i += 4) {
                  final rowSymptoms = symptomsToShow.skip(i).take(4).toList();

                  rows.add(
                      Row(
                        mainAxisAlignment: rowSymptoms.length == 4
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: rowSymptoms.map((symptom) => FormWidget(
                          image: symptom['image']!,
                          x: "${symptomCounts[symptom['key']]}x",
                          title: symptom['title']!,
                        )).toList(),
                      )
                  );
                }
                return Column(spacing: 10, children: rows);
              },
            ),

          if (filteredSymptoms.length > 8)
            GestureDetector(
              onTap: () => setState(() => _symptomsExpanded = !_symptomsExpanded),
              child: ViewMore(
                expanded: _symptomsExpanded,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMoodsSection() {
    final filteredMoods = allMoods
        .where((mood) => (moodCounts[mood['key']] ?? 0) > 0)
        .toList();

    final moodsToShow = _moodsExpanded
        ? filteredMoods
        : filteredMoods.take(8).toList();

    return CustomCard(
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Text(
                "moods".tr(),
                style: GoogleFonts.urbanist(
                  color: const Color(0xff212121),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),

          if (moodsToShow.isNotEmpty)
            Builder(
              builder: (context) {
                List<Widget> rows = [];
                for (int i = 0; i < moodsToShow.length; i += 4) {
                  final rowMoods = moodsToShow.skip(i).take(4).toList();

                  rows.add(
                      Row(
                        mainAxisAlignment: rowMoods.length == 4
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: rowMoods.map((mood) => CircleWidget(
                          image: mood['image']!,
                          x: "${moodCounts[mood['key']]}x",
                          title: mood['title']!,
                        )).toList(),
                      )
                  );
                }
                return Column(spacing: 10, children: rows);
              },
            ),

          if (filteredMoods.length > 8)
            GestureDetector(
              onTap: () => setState(() => _moodsExpanded = !_moodsExpanded),
              child: ViewMore(
                expanded: _moodsExpanded,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMedicineSection() {
    final filteredMedicines = allMedicines
        .where((medicine) => (medicineCounts[medicine['key']] ?? 0) > 0)
        .toList();

    final medicinesToShow = _medicineExpanded
        ? filteredMedicines
        : filteredMedicines.take(8).toList();

    return CustomCard(
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Text(
                "medicine".tr(),
                style: GoogleFonts.urbanist(
                  color: const Color(0xff212121),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),

          if (medicinesToShow.isNotEmpty)
            Builder(
              builder: (context) {
                List<Widget> rows = [];
                for (int i = 0; i < medicinesToShow.length; i += 4) {
                  final rowMedicines = medicinesToShow.skip(i).take(4).toList();
                  rows.add(
                      Row(
                        mainAxisAlignment: rowMedicines.length == 4
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: rowMedicines.map((medicine) => CircleWidget(
                          image: medicine['image']!,
                          x: "${medicineCounts[medicine['key']]}x",
                          title: medicine['title']!,
                        )).toList(),
                      )
                  );
                }
                return Column(spacing: 10, children: rows);
              },
            ),

          if (filteredMedicines.length > 8)
            GestureDetector(
              onTap: () => setState(() => _medicineExpanded = !_medicineExpanded),
              child: ViewMore(
                expanded: _medicineExpanded,
              ),
            ),
        ],
      ),
    );
  }
}

class ViewMore extends StatelessWidget {
  final bool expanded;
  const ViewMore({super.key, this.expanded = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          expanded ? "show_less".tr() : "view_more".tr(),
          style: GoogleFonts.urbanist(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFF699C),
          ),
        ),
        Icon(
          expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: const Color(0xFFFF699C),
        ),
      ],
    );
  }
}
