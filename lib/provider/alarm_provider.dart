import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:unibike/utils/background_service.dart';
import 'package:unibike/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledReminder(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Reminder Alarm Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 2),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.formatWaktu(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Reminder Alarm Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
