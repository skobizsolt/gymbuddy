// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_runner_api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$WorkoutRunnerApi extends WorkoutRunnerApi {
  _$WorkoutRunnerApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = WorkoutRunnerApi;

  @override
  Future<Response<SessionStartedResponse>> _workoutRunnerNewSessionPost({
    String? authorization,
    required PostSessionDetailsDto? body,
  }) {
    final Uri $url = Uri.parse('/workout-runner/new-session');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<SessionStartedResponse, SessionStartedResponse>($request);
  }

  @override
  Future<Response<dynamic>> _workoutRunnerAddPost({
    String? authorization,
    required PostRecordDto? body,
  }) {
    final Uri $url = Uri.parse('/workout-runner/add');
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<StepRecordResponse>>> _workoutRunnerRecordsGet({
    String? authorization,
    required String? sessionId,
  }) {
    final Uri $url = Uri.parse('/workout-runner/records');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sessionId': sessionId
    };
    final Map<String, String> $headers = {
      if (authorization != null) 'Authorization': authorization,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<StepRecordResponse>, StepRecordResponse>($request);
  }
}
