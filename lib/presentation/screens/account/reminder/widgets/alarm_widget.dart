import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lunari/core/services/noti_service.dart';

class NotificationTimerPage extends StatefulWidget {
  @override
  _NotificationTimerPageState createState() => _NotificationTimerPageState();
}

class _NotificationTimerPageState extends State<NotificationTimerPage> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectTime(context);
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('reminder_hour', pickedTime.hour);
      await prefs.setInt('reminder_minute', pickedTime.minute);

      NotiService().scheduleNotification(
        id: 1,
        title: "Reminder!",
        body: "It is time to gooo!",
        hour: pickedTime.hour,
        minute: pickedTime.minute,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Notification scheduled for ${pickedTime.format(context)}!".tr())),
      );

      Navigator.pop(context, pickedTime);
    } else {
      Navigator.pop(context, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Timer".tr())),
      body: Center(
        child: Text(
          _selectedTime != null ? "Selected time: ${_selectedTime!.format(context)}" : "Select a time!".tr(),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
