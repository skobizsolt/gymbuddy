import 'package:gymbuddy/models/stats/health_data_entry.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthService {
  // create a HealthFactory for use in the app, choose if HealthConnect should be used or not
  final HealthFactory _health = HealthFactory();

  Future<bool> requestPermissions() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();
    // define the types to get
    var types = [
      HealthDataType.HEART_RATE,
      HealthDataType.WEIGHT,
    ];

    var result = await _health.requestAuthorization(types);
    return result;
  }

  Future<List<HealthDataEntry>> getHeartRateDataForToday() async {
    var types = [
      HealthDataType.HEART_RATE,
    ];

    final now = DateTime.now();
    final midnight = now.subtract(Duration(
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second,
    ));

    List<HealthDataPoint> heartRateDataPoints =
        await _health.getHealthDataFromTypes(midnight, now, types);

    // fetch _health data from the last 24 hours
    return _mapToHealthDataEntry(heartRateDataPoints);
  }

  Future<List<HealthDataEntry>> getWeightDataForTheYear() async {
    // define the types to get
    var types = [
      HealthDataType.WEIGHT,
    ];

    final now = DateTime.now();
    final firstDayOfTheYear = DateTime(now.year);

    List<HealthDataPoint> heartRateDataPoints =
        await _health.getHealthDataFromTypes(firstDayOfTheYear, now, types);

    // fetch _health data from the last 24 hours
    return _mapToHealthDataEntry(heartRateDataPoints);
  }

  Future<void> changeAccount() async {
    await _health.revokePermissions();
  }

  _mapToHealthDataEntry(List<HealthDataPoint> datapoints) {
    var mappedPoints = datapoints
        .map((point) => HealthDataEntry(
              value: double.parse(point.value.toString()),
              createdAt: point.dateTo,
            ))
        .toList();
    mappedPoints.sort(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );
    return mappedPoints;
  }
}
