import 'package:dio/dio.dart';

import 'api_client.dart';
import 'models/example_response.dart';

abstract class ExampleFetcher {
  Future<ExampleResponse> fetchExample();
}

class NetworkingRepository implements ExampleFetcher {
  const NetworkingRepository(this._client);

  factory NetworkingRepository.create({Dio? dio}) {
    final client = ApiClient(dio ?? Dio(BaseOptions(connectTimeout: 5000)));
    return NetworkingRepository(client);
  }

  final ApiClient _client;

  @override
  Future<ExampleResponse> fetchExample() => _client.fetchExample();
}
