import 'package:fl_chart/fl_chart.dart';
import 'package:gymbuddy/models/stats/health_data_entry.dart';
import 'package:intl/intl.dart';

class WeightChartHelper {
  List<HealthDataEntry> getWeightsSortedByValue(List<HealthDataEntry> values) {
    final data = List<HealthDataEntry>.from(values);
    if (data.isEmpty) {
      return [];
    }
    data.sort(
      (a, b) => a.value.compareTo(b.value),
    );
    return data;
  }

  double getCoordinatesInterval(final double difference) {
    return difference / 2;
  }

  getTouchSpotData(LineBarSpot touchedSpot, List<HealthDataEntry> data) {
    final spotShortDate =
        DateFormat.MMMd().format(data[touchedSpot.spotIndex].createdAt);
    return '${spotShortDate}\n${touchedSpot.y} kg';
  }
}
