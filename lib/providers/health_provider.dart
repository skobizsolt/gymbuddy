import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/service/health_service.dart';

var healthProvider = FutureProvider(
  (ref) => HealthService().getHeartRateDataForToday(),
);
