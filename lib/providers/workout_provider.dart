import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/service/workout/workout_service.dart';

var workoutProvider =
    FutureProvider((ref) async => await WorkoutService().getWorkouts());
