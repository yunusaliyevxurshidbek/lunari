import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/presentation/screens/account/preferences/widgets/clear_cache_bottomsheet.dart';
import 'package:lunari/presentation/screens/account/preferences/widgets/preference_section.dart';
import 'package:lunari/presentation/screens/account/preferences/widgets/restart_progress.dart';
import 'package:lunari/presentation/screens/account/preferences/widgets/selecting_bottom_sheet.dart';
import '../../../../../data/models/perferences_model.dart';
import '../../../../blocs/preferences/preferences_bloc.dart';
import '../../../../blocs/preferences/preferences_event.dart';
import '../../../../blocs/preferences/preferences_state.dart';
import 'package:intl/intl.dart';


class PreferencesWidget extends StatefulWidget {
  const PreferencesWidget({Key? key}) : super(key: key);

  @override
  State<PreferencesWidget> createState() => _PreferencesWidgetState();
}

class _PreferencesWidgetState extends State<PreferencesWidget> {
  Map<String, BottomSheetConfig> _createBottomSheetConfigs(
      BuildContext context, PreferencesState state) {
    return {
      'weight': BottomSheetConfig(
        title: 'weight_unit'.tr(),
        currentValue: state.weightUnit,
        options: [
          BottomSheetOption(title: 'kilogram'.tr(), value: 'kg'),
          BottomSheetOption(title: 'pound'.tr(), value: 'lb'),
        ],
        onSelected: (value) => context.read<PreferencesBloc>().add(WeightUnitChanged(value)),
      ),

      'height': BottomSheetConfig(
        title: 'height_unit'.tr(),
        currentValue: state.heightUnit,
        options: [
          BottomSheetOption(title: 'centimeter'.tr(), value: 'cm'),
          BottomSheetOption(title: 'feet_inches'.tr(), value: 'ft'),
        ],
        onSelected: (value) => context.read<PreferencesBloc>().add(HeightUnitChanged(value)),
      ),

      'temperature': BottomSheetConfig(
        title: 'temperature_unit'.tr(),
        currentValue: state.temperatureUnit,
        options: [
          BottomSheetOption(title: 'celsius'.tr(), value: '°C'),
          BottomSheetOption(title: 'fahrenheit'.tr(), value: '°F'),
        ],
        onSelected: (value) => context.read<PreferencesBloc>().add(TemperatureUnitChanged(value)),
      ),

      'water_goal': BottomSheetConfig(
        title: 'water_intake_goal'.tr(),
        currentValue: state.waterGoal,
        options: [
          BottomSheetOption(title: '1500_ml'.tr(), value: '1500'),
          BottomSheetOption(title: '2000_ml'.tr(), value: '2000'),
          BottomSheetOption(title: '2400_ml'.tr(), value: '2400'),
          BottomSheetOption(title: '3000_ml'.tr(), value: '3000'),
          BottomSheetOption(title: '3500_ml'.tr(), value: '3500'),
          BottomSheetOption(title: '4000_ml'.tr(), value: '4000'),
        ],
        onSelected: (value) => context.read<PreferencesBloc>().add(WaterGoalChanged(value)),
      ),

      'cup_unit': BottomSheetConfig(
        title: 'cup_unit'.tr(),
        currentValue: state.cupUnit,
        options: [
          BottomSheetOption(title: 'milliliter_ml'.tr(), value: 'mL'),
          BottomSheetOption(title: 'fluid_ounce_fl_oz'.tr(), value: 'fl oz'),
          BottomSheetOption(title: 'cup'.tr(), value: 'cup'),
        ],
        onSelected: (value) => context.read<PreferencesBloc>().add(CupUnitChanged(value)),
      ),

      'first_day': BottomSheetConfig(
        title: 'first_day_of_week'.tr(),
        currentValue: state.firstDay,
        options: [
          BottomSheetOption(title: 'sunday'.tr(), value: 'Sunday'),
          BottomSheetOption(title: 'monday'.tr(), value: 'Monday'),
          BottomSheetOption(title: 'tuesday'.tr(), value: 'Tuesday'),
          BottomSheetOption(title: 'wednesday'.tr(), value: 'Wednesday'),
          BottomSheetOption(title: 'thursday'.tr(), value: 'Thursday'),
          BottomSheetOption(title: 'friday'.tr(), value: 'Friday'),
          BottomSheetOption(title: 'saturday'.tr(), value: 'Saturday'),
        ],
        onSelected: (value) => context.read<PreferencesBloc>().add(FirstDayChanged(value)),
      ),

      'time_format': BottomSheetConfig(
        title: 'time_format'.tr(),
        currentValue: state.timeFormat,
        options: [
          BottomSheetOption(title: 'system_default'.tr(), value: 'System Default'),
          BottomSheetOption(title: '12_hour'.tr(), value: '12 Hour'),
          BottomSheetOption(title: '24_hour'.tr(), value: '24 Hour'),
        ],
        onSelected: (value) => context.read<PreferencesBloc>().add(TimeFormatChanged(value)),
      ),
    };
  }

  @override
  void initState() {
    super.initState();
    context.read<PreferencesBloc>().add(LoadPreferences());
  }

  void _onClearCacheTap() {
    showModalBottomSheet(context: context, builder: (_) => const ClearCacheBottomsheet());
  }

  void _showBottomSheet(BuildContext context, String key, PreferencesState state) {
    final config = _createBottomSheetConfigs(context, state)[key];
    if (config != null) {
      showModalBottomSheet(context: context, backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) => PreferenceBottomSheet(config: config));
    }
  }

  void _onBmiToggle(BuildContext context, bool value) {
    context.read<PreferencesBloc>().add(BmiToggled(value));
  }

  Future<void> _onDayResetTap(BuildContext context, PreferencesState state) async {
    final initial = TimeOfDay(hour: state.dayResetTimeInMinutes ~/ 60,
        minute: state.dayResetTimeInMinutes % 60);
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      helpText: 'select_time'.tr(),
      builder: (ctx, child) => Theme(
          data: Theme.of(ctx).copyWith(
            timePickerTheme: const TimePickerThemeData(
              dialTextColor: Colors.black,
              dialHandColor: Colors.blue,
            ),
          ), child: child!),
    );
    if (picked != null) {
      final minutes = picked.hour * 60 + picked.minute;
      context.read<PreferencesBloc>().add(DayResetTimeChanged(minutes));
    }
  }

  String _formatWaterGoal(String goal) => NumberFormat.decimalPattern().format(int.tryParse(goal) ?? 0);

  String _formatResetTime(BuildContext context, PreferencesState state) {
    final time = TimeOfDay(hour: state.dayResetTimeInMinutes ~/ 60,
        minute: state.dayResetTimeInMinutes % 60);
    return MaterialLocalizations.of(context).formatTimeOfDay(
      time,
      alwaysUse24HourFormat: state.timeFormat == '24 Hour',
    );
  }

  List<List<PreferenceItem>> _buildSections(BuildContext context, PreferencesState state) {
    return [
      [
        PreferenceItem(
          title: 'weight_unit'.tr(),
          value: state.weightUnit,
          hasBottomSheet: true,
          onTap: () => _showBottomSheet(context, 'weight', state),
        ),
        PreferenceItem(
          title: 'height_unit'.tr(),
          value: state.heightUnit,
          hasBottomSheet: true,
          onTap: () => _showBottomSheet(context, 'height', state),
        ),
        PreferenceItem(
          title: 'body_mass_index'.tr(),
          isSwitch: true,
          switchValue: state.isBmiEnabled,
          onSwitchChanged: (v) => _onBmiToggle(context, v),
        ),
      ],
      [
        PreferenceItem(
          title: 'temperature_unit'.tr(),
          value: state.temperatureUnit,
          hasBottomSheet: true,
          onTap: () => _showBottomSheet(context, 'temperature', state),
        ),
      ],
      [
        PreferenceItem(
          title: 'water_intake_goal'.tr(),
          value: '${_formatWaterGoal(state.waterGoal)} mL',
          hasBottomSheet: true,
          onTap: () => _showBottomSheet(context, 'water_goal', state),
        ),
        PreferenceItem(
          title: 'cup_unit'.tr(),
          value: state.cupUnit,
          hasBottomSheet: true,
          onTap: () => _showBottomSheet(context, 'cup_unit', state),
        ),
      ],
      [
        PreferenceItem(
          title: 'first_day_of_week'.tr(),
          value: state.firstDay.tr(),
          hasBottomSheet: true,
          onTap: () => _showBottomSheet(context, 'first_day', state),
        ),
        PreferenceItem(
          title: 'time_format'.tr(),
          value: state.timeFormat.tr(),
          hasBottomSheet: true,
          onTap: () => _showBottomSheet(context, 'time_format', state),
        ),
        PreferenceItem(
          title: 'day_reset_time'.tr(),
          value: _formatResetTime(context, state),
          hasBottomSheet: true,
          onTap: () => _onDayResetTap(context, state),
        ),
      ],
      [
        PreferenceItem(
          title: 'restart_all_progress'.tr(),
          hasBottomSheet: true,
          onTap: () => showModalBottomSheet(context: context, builder: (_) => const RestartProgressBottomshet()),
        ),
        PreferenceItem(
          title: 'clear_cache'.tr(),
          value: '${state.cacheSizeMB.toStringAsFixed(1)} MB',
          hasBottomSheet: true,
          onTap: _onClearCacheTap,
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            children: _buildSections(context, state)
                .map((sec) => PreferenceSection(items: sec))
                .toList(),
          ),
        );
      },
    );
  }
}

