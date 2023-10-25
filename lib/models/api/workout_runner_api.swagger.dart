// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'workout_runner_api.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
export 'workout_runner_api.models.swagger.dart';

part 'workout_runner_api.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class WorkoutRunnerApi extends ChopperService {
  static WorkoutRunnerApi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    Converter? converter,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$WorkoutRunnerApi(client);
    }

    final newClient = ChopperClient(
        services: [_$WorkoutRunnerApi()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$WorkoutRunnerApi(newClient);
  }

  ///
  ///@param Authorization
  ///@param sessionId
  Future<chopper.Response> workoutRunnerFinishPut({
    String? authorization,
    required String? sessionId,
  }) {
    return _workoutRunnerFinishPut(
        authorization: authorization?.toString(), sessionId: sessionId);
  }

  ///
  ///@param Authorization
  ///@param sessionId
  @Put(
    path: '/workout-runner/finish',
    optionalBody: true,
  )
  Future<chopper.Response> _workoutRunnerFinishPut({
    @Header('Authorization') String? authorization,
    @Query('sessionId') required String? sessionId,
  });

  ///
  ///@param Authorization
  Future<chopper.Response<SessionStartedResponse>> workoutRunnerNewSessionPost({
    String? authorization,
    required PostSessionDetailsDto? body,
  }) {
    generatedMapping.putIfAbsent(
        SessionStartedResponse, () => SessionStartedResponse.fromJsonFactory);

    return _workoutRunnerNewSessionPost(
        authorization: authorization?.toString(), body: body);
  }

  ///
  ///@param Authorization
  @Post(
    path: '/workout-runner/new-session',
    optionalBody: true,
  )
  Future<chopper.Response<SessionStartedResponse>>
      _workoutRunnerNewSessionPost({
    @Header('Authorization') String? authorization,
    @Body() required PostSessionDetailsDto? body,
  });

  ///
  ///@param Authorization
  Future<chopper.Response> workoutRunnerAddPost({
    String? authorization,
    required PostRecordDto? body,
  }) {
    return _workoutRunnerAddPost(
        authorization: authorization?.toString(), body: body);
  }

  ///
  ///@param Authorization
  @Post(
    path: '/workout-runner/add',
    optionalBody: true,
  )
  Future<chopper.Response> _workoutRunnerAddPost({
    @Header('Authorization') String? authorization,
    @Body() required PostRecordDto? body,
  });

  ///
  ///@param Authorization
  ///@param sessionId
  Future<chopper.Response<List<StepRecordResponse>>> workoutRunnerRecordsGet({
    String? authorization,
    required String? sessionId,
  }) {
    generatedMapping.putIfAbsent(
        StepRecordResponse, () => StepRecordResponse.fromJsonFactory);

    return _workoutRunnerRecordsGet(
        authorization: authorization?.toString(), sessionId: sessionId);
  }

  ///
  ///@param Authorization
  ///@param sessionId
  @Get(path: '/workout-runner/records')
  Future<chopper.Response<List<StepRecordResponse>>> _workoutRunnerRecordsGet({
    @Header('Authorization') String? authorization,
    @Query('sessionId') required String? sessionId,
  });

  ///
  ///@param Authorization
  ///@param userId
  Future<chopper.Response<List<SessionActivityResponse>>>
      workoutRunnerActivityGet({
    String? authorization,
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
        SessionActivityResponse, () => SessionActivityResponse.fromJsonFactory);

    return _workoutRunnerActivityGet(
        authorization: authorization?.toString(), userId: userId);
  }

  ///
  ///@param Authorization
  ///@param userId
  @Get(path: '/workout-runner/activity')
  Future<chopper.Response<List<SessionActivityResponse>>>
      _workoutRunnerActivityGet({
    @Header('Authorization') String? authorization,
    @Query('userId') required String? userId,
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
