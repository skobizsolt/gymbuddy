import 'package:gymbuddy/models/stats/health_data_entry.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthService {
  // create a HealthFactory for use in the app, choose if HealthConnect should be used or not
  final HealthFactory health = HealthFactory();

  static Future<void> requestPermissions() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();
  }

  Future<List<HealthDataEntry>> getHeartRateDataForToday() async {
    // define the types to get
    var types = [
      HealthDataType.HEART_RATE,
    ];

    // requesting access to the data types before reading them
    try {
      await health.requestAuthorization(types);
    } on Exception {
      throw Exception("Accessing heart rate data failed");
    }

    final now = DateTime.now();
    final midnight = now.subtract(Duration(
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second,
    ));

    List<HealthDataPoint> heartRateDataPoints =
        await health.getHealthDataFromTypes(midnight, now, types);

    // fetch health data from the last 24 hours
    return _mapToHealthDataEntry(heartRateDataPoints);
  }

  Future<List<HealthDataEntry>> getWeightDataForTheYear() async {
    // define the types to get
    var types = [
      HealthDataType.WEIGHT,
    ];

    // requesting access to the data types before reading them
    try {
      await health.requestAuthorization(types);
    } on Exception {
      throw Exception("Accessing weight data failed");
    }

    final now = DateTime.now();
    final firstDayOfTheYear = DateTime(now.year);

    List<HealthDataPoint> heartRateDataPoints =
        await health.getHealthDataFromTypes(firstDayOfTheYear, now, types);

    // fetch health data from the last 24 hours
    return _mapToHealthDataEntry(heartRateDataPoints);
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
