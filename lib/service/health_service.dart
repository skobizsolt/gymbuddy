import 'package:gymbuddy/models/stats/heart_rate_point.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthService {
  static Future<void> requestPermissions() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();
  }

  Future<List<HearthRatePoint>> getHeartRateDataForToday() async {
    // create a HealthFactory for use in the app, choose if HealthConnect should be used or not
    final HealthFactory health = HealthFactory();

    // define the types to get
    var types = [
      HealthDataType.HEART_RATE,
    ];

    // requesting access to the data types before reading them
    try {
      await health.requestAuthorization(types);
    } on Exception {
      throw Exception("Accessing health data failed");
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
    return heartRateDataPoints
        .map((point) => HearthRatePoint(
              value: double.parse(point.value.toString()),
              createdAt: point.dateTo,
            ))
        .toList();
  }
}
