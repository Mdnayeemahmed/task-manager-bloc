// date_utils.dart

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// Converts an ISO 8601 date string to a formatted date string.
///
// ignore: lines_longer_than_80_chars
/// [isoDateString] should be in ISO 8601 format, e.g., "2024-07-28T07:28:13.627Z".
///
/// Returns a formatted date string, e.g., "28 July 2024".
String formatIsoDateString(String isoDateString) {
  try {
    // Parse the ISO 8601 date string into a DateTime object
    final dateTime = DateTime.parse(isoDateString);

    // Define the desired format
    final formatter = DateFormat('dd MMMM yyyy');

    // Format the DateTime object into a string
    return formatter.format(dateTime);
  } catch (e) {
    // Handle invalid date format or parsing errors
    if (kDebugMode) {
      print('Error parsing date: $e');
    }
    return 'Invalid date';
  }
}

DateTime? formatStringToDateTime(String? date) {
  if (date == null) {
    return null;
  }
  return DateTime.tryParse(date);
}