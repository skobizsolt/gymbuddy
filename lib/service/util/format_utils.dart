class FormatUtils {
  static String toCapitalized(final String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

  static String toTimeString(Duration duration) {
    var timeBlocks =
        duration.toString().split('.').first.padLeft(8, "0").split(":");
    if (duration.inHours > 0) {
      return '${timeBlocks[0]} hours, ${timeBlocks[1]} mins, ${timeBlocks[2]} secs';
    }
    return '${timeBlocks[1]} mins, ${timeBlocks[2]} secs';
  }
}
