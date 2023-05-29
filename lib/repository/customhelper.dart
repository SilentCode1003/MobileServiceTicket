import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:convert';

List<String> getMonths() {
  final months = <String>[];
  final now = DateTime.now();
  final year = now.year;
  // final startDate = DateTime(year, 1);

  // Generate a list of 12 dates, one for each month of the year
  final dates = List.generate(12, (index) => DateTime(year, index + 1));

  // Format each date as a month string
  final formatter = DateFormat.MMMM();
  for (final date in dates) {
    final monthString = formatter.format(date);
    months.add(monthString);
  }

  return months;
}

void createJsonFile(data) {
  // final Map<dynamic> jsonData = {
  //   'fullname': 'John Doe',
  //   'role': 'johndoe@example.com',
  //   'position': 30,
  // };

  final jsonString = json.encode(data);
  final file = File('data/user.json');
  file.writeAsString(jsonString);
}

Future<Map<String, dynamic>> readJsonData(String userId) async {
  String jsonString = await rootBundle.loadString('data/user.json');
  Map<String, dynamic> data = json.decode(jsonString);
  return data;
}
