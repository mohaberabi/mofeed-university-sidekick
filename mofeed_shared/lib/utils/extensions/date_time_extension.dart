import 'package:mofeed_shared/utils/extensions/num_extension.dart';

extension DateFromator on DateTime {
  String get mdyHm {
    int formatedHour = hour % 12;
    return "${month.clock}/${day.clock}/$year ${(formatedHour == 0 ? 12 : formatedHour).clock}:${minute.clock}: ${hour < 12 ? "AM" : "PM"}";
  }

  String get mDy {
    return "${month.clock}/${day.clock}/$year";
  }

  String get amPM {
    final hourMod = hour % 12;
    final formattedHour =
        hourMod == 0 ? '12' : hourMod.toString().padLeft(2, '0');
    final formattedMinute = minute.toString().padLeft(2, '0');
    final amPmIndicator = hour < 12 ? 'AM' : 'PM';

    final formattedTime = '$formattedHour:$formattedMinute $amPmIndicator';

    return formattedTime;
  }

  String get birthDate => '$year - ${month.clock} - ${day.clock}';

  String get egyFormatedDay => generalWeekDays[(weekday + 6) % 7];
}

const generalWeekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const monthsSmall = <int, String>{
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr",
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sep",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};
const monthsLong = <int, String>{
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};
