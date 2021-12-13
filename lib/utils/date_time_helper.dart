import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime formatWaktu() {
    // Date and Time Format
    var now = DateTime.now();
    final dateFormat = DateFormat('EEE d MMM, hh:mm a');
    final dateFormatPinjam = dateFormat.format(now);
    var resultNow = dateFormat.parseStrict(dateFormatPinjam);

    // Tomorrow Format
    var kembali = now.add(Duration(hours: 2));
    final dateFormatKembali = dateFormat.format(kembali);
    var resultEnd = dateFormat.parseStrict(dateFormatKembali);

    return now.isAfter(resultNow) ? resultEnd : resultNow;
  }
}
