import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FormatUtils {
  static const String HOUR_TAG = 'hours';
  static const String MINUTE_TAG = 'mins';
  static const String SECOND_TAG = 'secs';

  // Uppercases the first letter in a string
  static String toCapitalized(final String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

  // Converts duration to a more readable time format
  static String toTimeString(Duration duration) {
    var timeBlocks =
        duration.toString().split('.').first.padLeft(8, "0").split(":");
    // Display hours if time exceeds 1 hour
    if (duration.inHours > 0) {
      return '${timeBlocks[0]} $HOUR_TAG, ${timeBlocks[1]} $MINUTE_TAG, ${timeBlocks[2]} $SECOND_TAG';
    }

    // Display minutes if time exceeds 1 minute
    if (duration.inMinutes > 0) {
      return '${timeBlocks[1]} $MINUTE_TAG, ${timeBlocks[2]} $SECOND_TAG';
    }

    // Display seconds only
    if (duration.inSeconds > 9) {
      return '${timeBlocks[2]} $SECOND_TAG';
    }

    // Remove zeros before seconds if time is less than 10 seconds.
    return '${duration.inSeconds} $SECOND_TAG';
  }

  // Format date time to a standard date time
  static formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  // Format date time with more specified conditions
  static String toDayAndWeekSpecifiedDateTime(final DateTime dateTime) {
    var dayDifference = DateTime.now().difference(dateTime).inDays;
    if (dayDifference < 1) {
      return '${DateFormat.Hm().format(dateTime)}';
    }
    if (dayDifference < 7) {
      return '${DateFormat.E().format(dateTime)}';
    }
    if (DateTime.now().year == dateTime.year) {
      return '${DateFormat.MMMd().format(dateTime)}';
    }
    return toHungarianDate(dateTime);
  }

  // format date time to a hungarian date
  static toHungarianDate(DateTime dateTime) {
    // Allows to set different date locales
    initializeDateFormatting();
    return DateFormat.yMMMd('en_CA').format(dateTime);
  }
}
