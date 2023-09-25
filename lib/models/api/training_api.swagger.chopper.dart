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
  Future<Response<WorkoutStepResponse>>
      _workoutsWorkoutIdStepsStepNumberEditPut({
    required int? workoutId,
    required int? stepNumber,
    required ChangeWorkoutStepRequest? body,
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
    return client.send<WorkoutStepResponse, WorkoutStepResponse>($request);
  }

  @override
  Future<Response<WorkoutResponse>> _workoutsWorkoutIdEditPut({
    required int? workoutId,
    required EditWorkoutRequest? body,
  }) {
    final Uri $url = Uri.parse('/workouts/${workoutId}/edit');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WorkoutResponse, WorkoutResponse>($request);
  }

  @override
  Future<Response<WorkoutStepResponse>> _workoutsWorkoutIdStepsCreatePost({
    required int? workoutId,
    required ChangeWorkoutStepRequest? body,
  }) {
    final Uri $url = Uri.parse('/workouts/${workoutId}/steps/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WorkoutStepResponse, WorkoutStepResponse>($request);
  }

  @override
  Future<Response<DetailedWorkoutsResponse>> _workoutsCreatePost({
    required String? userId,
    required CreateWorkoutRequest? body,
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
    return client
        .send<DetailedWorkoutsResponse, DetailedWorkoutsResponse>($request);
  }

  @override
  Future<Response<WorkoutListResponse>> _workoutsGet() {
    final Uri $url = Uri.parse('/workouts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WorkoutListResponse, WorkoutListResponse>($request);
  }

  @override
  Future<Response<WorkoutResponse>> _workoutsWorkoutIdGet(
      {required int? workoutId}) {
    final Uri $url = Uri.parse('/workouts/${workoutId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WorkoutResponse, WorkoutResponse>($request);
  }

  @override
  Future<Response<List<WorkoutStepResponse>>> _workoutsWorkoutIdStepsGet(
      {required int? workoutId}) {
    final Uri $url = Uri.parse('/workouts/${workoutId}/steps');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<WorkoutStepResponse>, WorkoutStepResponse>($request);
  }

  @override
  Future<Response<WorkoutStepResponse>> _workoutsWorkoutIdStepsStepNumberGet({
    required int? workoutId,
    required int? stepNumber,
  }) {
    final Uri $url = Uri.parse('/workouts/${workoutId}/steps/${stepNumber}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WorkoutStepResponse, WorkoutStepResponse>($request);
  }

  @override
  Future<Response<WorkoutDetailsResponse>> _workoutsDataWorkoutIdDetailsGet(
      {required int? workoutId}) {
    final Uri $url = Uri.parse('/workouts/data/${workoutId}/details');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<WorkoutDetailsResponse, WorkoutDetailsResponse>($request);
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
