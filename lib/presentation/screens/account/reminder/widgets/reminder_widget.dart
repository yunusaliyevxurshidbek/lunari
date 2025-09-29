import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/ringtone/ringtone_cubit.dart';
import 'package:lunari/presentation/blocs/ringtone/ringtone_state.dart';
import 'package:lunari/presentation/screens/account/reminder/widgets/alarm_widget.dart';
import 'package:lunari/presentation/screens/account/reminder/widgets/ringtone_list_page.dart';
import 'package:lunari/presentation/screens/account/reminder/widgets/volume_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/models/ringtone_model.dart';


class ReminderWidget extends StatefulWidget {
  const ReminderWidget({super.key});

  @override
  State<ReminderWidget> createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  bool isSwitched = true;
  bool isTurned = false;

  TimeOfDay? _selectedTime;
  String selectedRingtone = "Default";



  @override
  void initState() {
    super.initState();
    _loadSavedTime();
    _loadSelectedRingtone();
  }

  Future<void> _loadSavedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? hour = prefs.getInt('reminder_hour');
    int? minute = prefs.getInt('reminder_minute');

    if (hour != null && minute != null) {
      setState(() {
        _selectedTime = TimeOfDay(hour: hour, minute: minute);
      });
    }
  }

  Future<void> _loadSelectedRingtone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedRingtone = prefs.getString('selected_ringtone') ?? "Default";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        // 1:
        Column(
          children: [
            Row(
              spacing: 10,
              children: [
                Text("daily_log_reminder".tr(),style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: context.colors.scrim,
                ),),
                const Spacer(),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeColor: context.colors.onPrimary,
                    activeTrackColor: context.colors.primary,
                  ),
                ),
              ],
            ),

            Divider(
              thickness: 1,
              color: context.ccolors.dividerLight,
            ),
          ],
        ),


        // 2:
        InkWell(
          onTap: () async {
            TimeOfDay? pickedTime = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationTimerPage()),
            );

            if (pickedTime != null) {
              setState(() {
                _selectedTime = pickedTime;
              });
            }
          },
          child: Row(
            children: [
              Text(
                "reminder_time".tr(),
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: context.colors.scrim,
                ),
              ),
              const Spacer(),
              Text(
                _selectedTime != null ? _selectedTime!.format(context) : "09:00 AM",
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: context.colors.scrim,
                ),
              ),
              SvgPicture.asset(
                "assets/icons/arrow_right.svg",
                height: 20,
                width: 20,
                color: context.colors.scrim,
              )
            ],
          ),
        ),


        // 3:
        InkWell(
          onTap: () async {
            final selected = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RingtoneListPage()),
            );

            if (selected != null && selected is Ringtone) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('selected_ringtone', selected.name);

              setState(() {
                selectedRingtone = selected.name;
              });
            }
          },

          child: BlocBuilder<RingtoneCubit,RingtoneState>(
            builder: (context,state) {
              return Row(
                spacing: 10,
                children: [
                  Text("rintone".tr(),style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: context.colors.scrim,
                  ),),
                  const Spacer(),
                  Text(selectedRingtone.tr(),style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: context.colors.scrim,
                  ),),
                  SvgPicture.asset(
                    "assets/icons/arrow_right.svg",
                    height: 20,
                    width: 20,
                    color: context.colors.scrim,
                  )
                ],
              );
            },
          ),
        ),


        // 4:
        Row(
          spacing: 10,
          children: [
            SvgPicture.asset(
              "assets/icons/mute.svg",
              height: 20,
              width: 20,
              color: context.colors.scrim,
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.center,
                child: VolumeSlider(),
              ),
            ),
            SvgPicture.asset(
              "assets/icons/sound.svg",
              height: 20,
              width: 20,
              color: context.colors.scrim,
            )
          ],
        ),

        // 5:
        Row(
          spacing: 10,
          children: [
            Text("vibration".tr(),style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: context.colors.scrim,
            ),),
            const Spacer(),
            Transform.scale(
              scale: 0.7,
              child: Switch(
                value: isTurned,
                onChanged: (value) {
                  setState(() {
                    isTurned = value;
                  });
                },
                activeColor: context.colors.onPrimary,
                activeTrackColor: context.colors.primary,
              ),
            ),
          ],
        ),

      ],
    );
  }
}
