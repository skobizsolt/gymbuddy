import 'package:flutter/foundation.dart';

import 'package:gymbuddy/models/stats/health_data_entry.dart';

class HealthChartData {
  List<HealthDataEntry> bloodRateData;
  List<HealthDataEntry> weightData;
  HealthChartData({
    required this.bloodRateData,
    required this.weightData,
  });

  HealthChartData copyWith({
    List<HealthDataEntry>? bloodRateData,
    List<HealthDataEntry>? weightData,
  }) {
    return HealthChartData(
      bloodRateData: bloodRateData ?? this.bloodRateData,
      weightData: weightData ?? this.weightData,
    );
  }

  @override
  String toString() =>
      'HealthChartData(bloodRateData: $bloodRateData, weightData: $weightData)';

  @override
  bool operator ==(covariant HealthChartData other) {
    if (identical(this, other)) return true;

    return listEquals(other.bloodRateData, bloodRateData) &&
        listEquals(other.weightData, weightData);
  }

  @override
  int get hashCode => bloodRateData.hashCode ^ weightData.hashCode;
}
