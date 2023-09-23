// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$TrainingApi extends TrainingApi {
  _$TrainingApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TrainingApi;

  @override
  Future<Response<WorkoutStepDto>> _workoutsWorkoutIdStepsStepNumberEditPut({
    required int? workoutId,
    required int? stepNumber,
    required ChangeWorkoutStepDto? body,
  }) {
    final Uri $url =
        Uri.parse('/workouts/${workoutId}/steps/${stepNumber}/edit');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WorkoutStepDto, WorkoutStepDto>($request);
  }

  @override
  Future<Response<WorkoutDto>> _workoutsWorkoutIdEditPut({
    required int? workoutId,
    required ChangeWorkoutDto? body,
  }) {
    final Uri $url = Uri.parse('/workouts/${workoutId}/edit');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WorkoutDto, WorkoutDto>($request);
  }

  @override
  Future<Response<WorkoutStepDto>> _workoutsWorkoutIdStepsCreatePost({
    required int? workoutId,
    required ChangeWorkoutStepDto? body,
  }) {
    final Uri $url = Uri.parse('/workouts/${workoutId}/steps/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WorkoutStepDto, WorkoutStepDto>($request);
  }

  @override
  Future<Response<DetailedWorkoutsDto>> _workoutsCreatePost({
    required String? userId,
    required ChangeWorkoutDto? body,
  }) {
    final Uri $url = Uri.parse('/workouts/create');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<DetailedWorkoutsDto, DetailedWorkoutsDto>($request);
  }

  @override
  Future<Response<WorkoutsDto>> _workoutsGet() {
    final Uri $url = Uri.parse('/workouts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WorkoutsDto, WorkoutsDto>($request);
  }

  @override
  Future<Response<WorkoutDto>> _workoutsWorkoutIdGet(
      {required int? workoutId}) {
    final Uri $url = Uri.parse('/workouts/${workoutId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WorkoutDto, WorkoutDto>($request);
  }

  @override
  Future<Response<List<WorkoutStepDto>>> _workoutsWorkoutIdStepsGet(
      {required int? workoutId}) {
    final Uri $url = Uri.parse('/workouts/${workoutId}/steps');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<WorkoutStepDto>, WorkoutStepDto>($request);
  }

  @override
  Future<Response<WorkoutStepDto>> _workoutsWorkoutIdStepsStepNumberGet({
    required int? workoutId,
    required int? stepNumber,
  }) {
    final Uri $url = Uri.parse('/workouts/${workoutId}/steps/${stepNumber}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WorkoutStepDto, WorkoutStepDto>($request);
  }

  @override
  Future<Response<dynamic>> _workoutsWorkoutIdStepsStepNumberDeleteDelete({
    required int? workoutId,
    required int? stepNumber,
  }) {
    final Uri $url =
        Uri.parse('/workouts/${workoutId}/steps/${stepNumber}/delete');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _workoutsWorkoutIdDeleteDelete(
      {required int? workoutId}) {
    final Uri $url = Uri.parse('/workouts/${workoutId}/delete');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
