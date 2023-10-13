class FormatUtils {
  static const String HOUR_TAG = 'hours';
  static const String MINUTE_TAG = 'mins';
  static const String SECOND_TAG = 'secs';

  static String toCapitalized(final String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

  static String toTimeString(Duration duration) {
    var timeBlocks =
        duration.toString().split('.').first.padLeft(8, "0").split(":");
    if (duration.inHours > 0) {
      return '${timeBlocks[0]} $HOUR_TAG, ${timeBlocks[1]} $MINUTE_TAG, ${timeBlocks[2]} $SECOND_TAG';
    }
    if (duration.inMinutes > 0) {
      return '${timeBlocks[1]} $MINUTE_TAG, ${timeBlocks[2]} $SECOND_TAG';
    }
    if (duration.inSeconds > 9) {
      return '${timeBlocks[2]} $SECOND_TAG';
    }
    return '${duration.inSeconds} $SECOND_TAG';
  }
}
