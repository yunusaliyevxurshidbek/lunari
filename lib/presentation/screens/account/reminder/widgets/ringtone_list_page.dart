import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/services/log_service.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/models/ringtone_model.dart';

class RingtoneListPage extends StatefulWidget {
  @override
  _RingtoneListPageState createState() => _RingtoneListPageState();
}

class _RingtoneListPageState extends State<RingtoneListPage> {

  final List<Ringtone> ringtones = [
    Ringtone(name: "Classic", path: "ringtones/ringtone-1.wav"),
    Ringtone(name: "Rock", path: "ringtones/ringtone-2.wav"),
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _playingRingtone;

  void _playRingtone(Ringtone ringtone) async {
    if (_playingRingtone == ringtone.name) {
      await _audioPlayer.stop();
      setState(() {
        _playingRingtone = null;
      });
    } else {
      await _audioPlayer.play(AssetSource(ringtone.path));
      setState(() {
        _playingRingtone = ringtone.name;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "select_ringtone".tr(),
          style: GoogleFonts.urbanist(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.onPrimaryContainer,
          ),
        ),
        backgroundColor: context.colors.onSecondary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: ListView.separated(
          itemCount: ringtones.length,
          separatorBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Divider(color: context.ccolors.dividerLight, thickness: 1),
          ),
          itemBuilder: (context, index) {
            final ringtone = ringtones[index];
            return InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('selected_ringtone', ringtone.name);
                LogService.i("Selected RINGTONE saved!");
                Navigator.pop(context, ringtone);
              },
              child: Container(
                padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  spacing: 15,
                  children: [
                    GestureDetector(
                      onTap: () => _playRingtone(ringtone),
                      child: Icon(
                        _playingRingtone == ringtone.name
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        color: context.colors.scrim,
                        size: 24.sp,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ringtone.name.tr(),
                        style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: context.colors.scrim,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
