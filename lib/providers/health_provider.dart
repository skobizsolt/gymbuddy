import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/stats/health_chart_data.dart';
import 'package:gymbuddy/service/stats/health_service.dart';

var healthPermissionsProvider =
    FutureProvider((ref) => HealthService().requestPermissions());

var healthProvider = FutureProvider<HealthChartData>(
  (ref) async {
    final _healthService = HealthService();
    return HealthChartData(
      bloodRateData: await _healthService.getHeartRateDataForToday(),
      weightData: await _healthService.getWeightDataForTheYear(),
    );
  },
);
