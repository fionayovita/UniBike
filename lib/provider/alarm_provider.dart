import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:unibike/utils/background_service.dart';
import 'package:unibike/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling News Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(minutes: 1),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.formatWaktu(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
