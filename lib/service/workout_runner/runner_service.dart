import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/workout_runner_api.swagger.dart';
import 'package:gymbuddy/models/workout/create_session.dart';
import 'package:gymbuddy/models/workout/create_step_record.dart';
import 'package:gymbuddy/models/workout/step_record.dart';
import 'package:gymbuddy/service/auth/user_service.dart';
import 'package:gymbuddy/service/mapper/workout_record_mapper.dart';
import 'package:gymbuddy/service/util/response_validator.dart';

class WorkoutRunnerService extends StateNotifier<List<StepRecord>> {
  WorkoutRunnerService() : super([]);

  final _api = WorkoutRunnerApi.create(
    baseUrl: Uri.http(GlobalValues.SERVER_URL),
  );

  Future<List<StepRecord>> getRecordsBySessionId(final String sessionId) async {
    var token = await UserService.firebaseUserJwtToken;

    var response = await _api.workoutRunnerRecordsGet(
      authorization: token,
      sessionId: sessionId,
    );
    ResponseValidator.validateResponse(response);

    final records = WorkoutRecordMapper.toStepRecordList(response.body!);
    state = (response.body == null || records.isEmpty) ? [] : records;

    return records;
  }

  Future<void> addNewRecord(CreateStepRecord record) async {
    var token = await UserService.firebaseUserJwtToken;

    var response = await _api.workoutRunnerAddPost(
      authorization: token,
      body: PostRecordDto.fromJson(record.toMap()),
    );

    ResponseValidator.validateResponse(response);
  }

  Future<String> getSessionId(CreateWorkoutSessionRequest request) async {
    var token = await UserService.firebaseUserJwtToken;

    var response = await _api.workoutRunnerNewSessionPost(
      authorization: token,
      body: PostSessionDetailsDto.fromJson(request.toMap()),
    );

    ResponseValidator.validateResponse(response);

    return response.body!.sessionId!;
  }
}
