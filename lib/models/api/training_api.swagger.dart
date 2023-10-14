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

  ///Gets a workout by it's id
  ///@param Authorization
  ///@param workoutId
  Future<chopper.Response<WorkoutResponse>> workoutsWorkoutIdGet({
    String? authorization,
    required int? workoutId,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutResponse, () => WorkoutResponse.fromJsonFactory);

    return _workoutsWorkoutIdGet(
        authorization: authorization?.toString(), workoutId: workoutId);
  }

  ///Gets a workout by it's id
  ///@param Authorization
  ///@param workoutId
  @Get(path: '/workouts/{workoutId}')
  Future<chopper.Response<WorkoutResponse>> _workoutsWorkoutIdGet({
    @Header('Authorization') String? authorization,
    @Path('workoutId') required int? workoutId,
  });

  ///Edits an existing workout
  ///@param Authorization
  ///@param workoutId
  Future<chopper.Response<WorkoutResponse>> workoutsWorkoutIdPut({
    String? authorization,
    required int? workoutId,
    required ChangeWorkoutRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutResponse, () => WorkoutResponse.fromJsonFactory);

    return _workoutsWorkoutIdPut(
        authorization: authorization?.toString(),
        workoutId: workoutId,
        body: body);
  }

  ///Edits an existing workout
  ///@param Authorization
  ///@param workoutId
  @Put(
    path: '/workouts/{workoutId}',
    optionalBody: true,
  )
  Future<chopper.Response<WorkoutResponse>> _workoutsWorkoutIdPut({
    @Header('Authorization') String? authorization,
    @Path('workoutId') required int? workoutId,
    @Body() required ChangeWorkoutRequest? body,
  });

  ///Deletes the selected workout
  ///@param Authorization
  ///@param workoutId
  Future<chopper.Response> workoutsWorkoutIdDelete({
    String? authorization,
    required int? workoutId,
  }) {
    return _workoutsWorkoutIdDelete(
        authorization: authorization?.toString(), workoutId: workoutId);
  }

  ///Deletes the selected workout
  ///@param Authorization
  ///@param workoutId
  @Delete(path: '/workouts/{workoutId}')
  Future<chopper.Response> _workoutsWorkoutIdDelete({
    @Header('Authorization') String? authorization,
    @Path('workoutId') required int? workoutId,
  });

  ///Gets a step associated with the selected workout
  ///@param Authorization
  ///@param workoutId
  ///@param stepNumber
  Future<chopper.Response<WorkoutStepResponse>>
      workoutsWorkoutIdStepsStepNumberGet({
    String? authorization,
    required int? workoutId,
    required int? stepNumber,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutStepResponse, () => WorkoutStepResponse.fromJsonFactory);

    return _workoutsWorkoutIdStepsStepNumberGet(
        authorization: authorization?.toString(),
        workoutId: workoutId,
        stepNumber: stepNumber);
  }

  ///Gets a step associated with the selected workout
  ///@param Authorization
  ///@param workoutId
  ///@param stepNumber
  @Get(path: '/workouts/{workoutId}/steps/{stepNumber}')
  Future<chopper.Response<WorkoutStepResponse>>
      _workoutsWorkoutIdStepsStepNumberGet({
    @Header('Authorization') String? authorization,
    @Path('workoutId') required int? workoutId,
    @Path('stepNumber') required int? stepNumber,
  });

  ///Edits an existing step
  ///@param Authorization
  ///@param workoutId
  ///@param stepNumber
  Future<chopper.Response<WorkoutStepResponse>>
      workoutsWorkoutIdStepsStepNumberPut({
    String? authorization,
    required int? workoutId,
    required int? stepNumber,
    required ChangeWorkoutStepRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutStepResponse, () => WorkoutStepResponse.fromJsonFactory);

    return _workoutsWorkoutIdStepsStepNumberPut(
        authorization: authorization?.toString(),
        workoutId: workoutId,
        stepNumber: stepNumber,
        body: body);
  }

  ///Edits an existing step
  ///@param Authorization
  ///@param workoutId
  ///@param stepNumber
  @Put(
    path: '/workouts/{workoutId}/steps/{stepNumber}',
    optionalBody: true,
  )
  Future<chopper.Response<WorkoutStepResponse>>
      _workoutsWorkoutIdStepsStepNumberPut({
    @Header('Authorization') String? authorization,
    @Path('workoutId') required int? workoutId,
    @Path('stepNumber') required int? stepNumber,
    @Body() required ChangeWorkoutStepRequest? body,
  });

  ///Deletes a step from a workout
  ///@param Authorization
  ///@param workoutId
  ///@param stepNumber
  Future<chopper.Response> workoutsWorkoutIdStepsStepNumberDelete({
    String? authorization,
    required int? workoutId,
    required int? stepNumber,
  }) {
    return _workoutsWorkoutIdStepsStepNumberDelete(
        authorization: authorization?.toString(),
        workoutId: workoutId,
        stepNumber: stepNumber);
  }

  ///Deletes a step from a workout
  ///@param Authorization
  ///@param workoutId
  ///@param stepNumber
  @Delete(path: '/workouts/{workoutId}/steps/{stepNumber}')
  Future<chopper.Response> _workoutsWorkoutIdStepsStepNumberDelete({
    @Header('Authorization') String? authorization,
    @Path('workoutId') required int? workoutId,
    @Path('stepNumber') required int? stepNumber,
  });

  ///List all existing workouts
  ///@param Authorization
  Future<chopper.Response<WorkoutListResponse>> workoutsGet(
      {String? authorization}) {
    generatedMapping.putIfAbsent(
        WorkoutListResponse, () => WorkoutListResponse.fromJsonFactory);

    return _workoutsGet(authorization: authorization?.toString());
  }

  ///List all existing workouts
  ///@param Authorization
  @Get(path: '/workouts')
  Future<chopper.Response<WorkoutListResponse>> _workoutsGet(
      {@Header('Authorization') String? authorization});

  ///Creates a new workout
  ///@param Authorization
  ///@param userId
  Future<chopper.Response<WorkoutResponse>> workoutsPost({
    String? authorization,
    required String? userId,
    required ChangeWorkoutRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutResponse, () => WorkoutResponse.fromJsonFactory);

    return _workoutsPost(
        authorization: authorization?.toString(), userId: userId, body: body);
  }

  ///Creates a new workout
  ///@param Authorization
  ///@param userId
  @Post(
    path: '/workouts',
    optionalBody: true,
  )
  Future<chopper.Response<WorkoutResponse>> _workoutsPost({
    @Header('Authorization') String? authorization,
    @Query('userId') required String? userId,
    @Body() required ChangeWorkoutRequest? body,
  });

  ///List all steps for a workout
  ///@param Authorization
  ///@param workoutId
  Future<chopper.Response<List<WorkoutStepResponse>>>
      workoutsWorkoutIdStepsGet({
    String? authorization,
    required int? workoutId,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutStepResponse, () => WorkoutStepResponse.fromJsonFactory);

    return _workoutsWorkoutIdStepsGet(
        authorization: authorization?.toString(), workoutId: workoutId);
  }

  ///List all steps for a workout
  ///@param Authorization
  ///@param workoutId
  @Get(path: '/workouts/{workoutId}/steps')
  Future<chopper.Response<List<WorkoutStepResponse>>>
      _workoutsWorkoutIdStepsGet({
    @Header('Authorization') String? authorization,
    @Path('workoutId') required int? workoutId,
  });

  ///Creates a new step under the workout
  ///@param Authorization
  ///@param workoutId
  Future<chopper.Response<WorkoutStepResponse>> workoutsWorkoutIdStepsPost({
    String? authorization,
    required int? workoutId,
    required ChangeWorkoutStepRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutStepResponse, () => WorkoutStepResponse.fromJsonFactory);

    return _workoutsWorkoutIdStepsPost(
        authorization: authorization?.toString(),
        workoutId: workoutId,
        body: body);
  }

  ///Creates a new step under the workout
  ///@param Authorization
  ///@param workoutId
  @Post(
    path: '/workouts/{workoutId}/steps',
    optionalBody: true,
  )
  Future<chopper.Response<WorkoutStepResponse>> _workoutsWorkoutIdStepsPost({
    @Header('Authorization') String? authorization,
    @Path('workoutId') required int? workoutId,
    @Body() required ChangeWorkoutStepRequest? body,
  });

  ///Get total steps and estimated time for a workout
  ///@param Authorization
  ///@param workoutId
  Future<chopper.Response<WorkoutDetailsResponse>> workoutsWorkoutIdDetailsGet({
    String? authorization,
    required int? workoutId,
  }) {
    generatedMapping.putIfAbsent(
        WorkoutDetailsResponse, () => WorkoutDetailsResponse.fromJsonFactory);

    return _workoutsWorkoutIdDetailsGet(
        authorization: authorization?.toString(), workoutId: workoutId);
  }

  ///Get total steps and estimated time for a workout
  ///@param Authorization
  ///@param workoutId
  @Get(path: '/workouts/{workoutId}/details')
  Future<chopper.Response<WorkoutDetailsResponse>>
      _workoutsWorkoutIdDetailsGet({
    @Header('Authorization') String? authorization,
    @Path('workoutId') required int? workoutId,
  });
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
