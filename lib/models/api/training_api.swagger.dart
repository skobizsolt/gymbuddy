// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'training_api.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'training_api.enums.swagger.dart' as enums;
export 'training_api.enums.swagger.dart';
export 'training_api.models.swagger.dart';

part 'training_api.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class TrainingApi extends ChopperService {
  static TrainingApi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    Converter? converter,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$TrainingApi(client);
    }

    final newClient = ChopperClient(
        services: [_$TrainingApi()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$TrainingApi(newClient);
  }

  ///
  ///@param workoutId
  Future<chopper.Response<WorkoutResponse>> workoutsWorkoutIdGet(
      {required int? workoutId}) {
    generatedMapping.putIfAbsent(
        WorkoutResponse, () => WorkoutResponse.fromJsonFactory);

    return _workoutsWorkoutIdGet(workoutId: workoutId);
  }

  ///
  ///@param workoutId
  @Get(path: '/workouts/{workoutId}')
  Future<chopper.Response<WorkoutResponse>> _workoutsWorkoutIdGet(
      {@Path('workoutId') required int? workoutId});

  ///
  ///@param workoutId
  Future<chopper.Response<WorkoutResponse>> workoutsWorkoutIdPut({
    required int? workoutId,
    required ChangeWorkoutRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutResponse, () => WorkoutResponse.fromJsonFactory);

    return _workoutsWorkoutIdPut(workoutId: workoutId, body: body);
  }

  ///
  ///@param workoutId
  @Put(
    path: '/workouts/{workoutId}',
    optionalBody: true,
  )
  Future<chopper.Response<WorkoutResponse>> _workoutsWorkoutIdPut({
    @Path('workoutId') required int? workoutId,
    @Body() required ChangeWorkoutRequest? body,
  });

  ///
  ///@param workoutId
  Future<chopper.Response> workoutsWorkoutIdDelete({required int? workoutId}) {
    return _workoutsWorkoutIdDelete(workoutId: workoutId);
  }

  ///
  ///@param workoutId
  @Delete(path: '/workouts/{workoutId}')
  Future<chopper.Response> _workoutsWorkoutIdDelete(
      {@Path('workoutId') required int? workoutId});

  ///
  ///@param workoutId
  ///@param stepNumber
  Future<chopper.Response<WorkoutStepResponse>>
      workoutsWorkoutIdStepsStepNumberGet({
    required int? workoutId,
    required int? stepNumber,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutStepResponse, () => WorkoutStepResponse.fromJsonFactory);

    return _workoutsWorkoutIdStepsStepNumberGet(
        workoutId: workoutId, stepNumber: stepNumber);
  }

  ///
  ///@param workoutId
  ///@param stepNumber
  @Get(path: '/workouts/{workoutId}/steps/{stepNumber}')
  Future<chopper.Response<WorkoutStepResponse>>
      _workoutsWorkoutIdStepsStepNumberGet({
    @Path('workoutId') required int? workoutId,
    @Path('stepNumber') required int? stepNumber,
  });

  ///
  ///@param workoutId
  ///@param stepNumber
  Future<chopper.Response<WorkoutStepResponse>>
      workoutsWorkoutIdStepsStepNumberPut({
    required int? workoutId,
    required int? stepNumber,
    required ChangeWorkoutStepRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutStepResponse, () => WorkoutStepResponse.fromJsonFactory);

    return _workoutsWorkoutIdStepsStepNumberPut(
        workoutId: workoutId, stepNumber: stepNumber, body: body);
  }

  ///
  ///@param workoutId
  ///@param stepNumber
  @Put(
    path: '/workouts/{workoutId}/steps/{stepNumber}',
    optionalBody: true,
  )
  Future<chopper.Response<WorkoutStepResponse>>
      _workoutsWorkoutIdStepsStepNumberPut({
    @Path('workoutId') required int? workoutId,
    @Path('stepNumber') required int? stepNumber,
    @Body() required ChangeWorkoutStepRequest? body,
  });

  ///
  ///@param workoutId
  ///@param stepNumber
  Future<chopper.Response> workoutsWorkoutIdStepsStepNumberDelete({
    required int? workoutId,
    required int? stepNumber,
  }) {
    return _workoutsWorkoutIdStepsStepNumberDelete(
        workoutId: workoutId, stepNumber: stepNumber);
  }

  ///
  ///@param workoutId
  ///@param stepNumber
  @Delete(path: '/workouts/{workoutId}/steps/{stepNumber}')
  Future<chopper.Response> _workoutsWorkoutIdStepsStepNumberDelete({
    @Path('workoutId') required int? workoutId,
    @Path('stepNumber') required int? stepNumber,
  });

  ///
  Future<chopper.Response<WorkoutListResponse>> workoutsGet() {
    generatedMapping.putIfAbsent(
        WorkoutListResponse, () => WorkoutListResponse.fromJsonFactory);

    return _workoutsGet();
  }

  ///
  @Get(path: '/workouts')
  Future<chopper.Response<WorkoutListResponse>> _workoutsGet();

  ///
  ///@param userId
  Future<chopper.Response<WorkoutResponse>> workoutsPost({
    required String? userId,
    required ChangeWorkoutRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutResponse, () => WorkoutResponse.fromJsonFactory);

    return _workoutsPost(userId: userId, body: body);
  }

  ///
  ///@param userId
  @Post(
    path: '/workouts',
    optionalBody: true,
  )
  Future<chopper.Response<WorkoutResponse>> _workoutsPost({
    @Query('userId') required String? userId,
    @Body() required ChangeWorkoutRequest? body,
  });

  ///
  ///@param workoutId
  Future<chopper.Response<List<WorkoutStepResponse>>> workoutsWorkoutIdStepsGet(
      {required int? workoutId}) {
    generatedMapping.putIfAbsent(
        WorkoutStepResponse, () => WorkoutStepResponse.fromJsonFactory);

    return _workoutsWorkoutIdStepsGet(workoutId: workoutId);
  }

  ///
  ///@param workoutId
  @Get(path: '/workouts/{workoutId}/steps')
  Future<chopper.Response<List<WorkoutStepResponse>>>
      _workoutsWorkoutIdStepsGet({@Path('workoutId') required int? workoutId});

  ///
  ///@param workoutId
  Future<chopper.Response<WorkoutStepResponse>> workoutsWorkoutIdStepsPost({
    required int? workoutId,
    required ChangeWorkoutStepRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutStepResponse, () => WorkoutStepResponse.fromJsonFactory);

    return _workoutsWorkoutIdStepsPost(workoutId: workoutId, body: body);
  }

  ///
  ///@param workoutId
  @Post(
    path: '/workouts/{workoutId}/steps',
    optionalBody: true,
  )
  Future<chopper.Response<WorkoutStepResponse>> _workoutsWorkoutIdStepsPost({
    @Path('workoutId') required int? workoutId,
    @Body() required ChangeWorkoutStepRequest? body,
  });

  ///
  ///@param workoutId
  Future<chopper.Response<WorkoutDetailsResponse>> workoutsWorkoutIdDetailsGet(
      {required int? workoutId}) {
    generatedMapping.putIfAbsent(
        WorkoutDetailsResponse, () => WorkoutDetailsResponse.fromJsonFactory);

    return _workoutsWorkoutIdDetailsGet(workoutId: workoutId);
  }

  ///
  ///@param workoutId
  @Get(path: '/workouts/{workoutId}/details')
  Future<chopper.Response<WorkoutDetailsResponse>> _workoutsWorkoutIdDetailsGet(
      {@Path('workoutId') required int? workoutId});
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
