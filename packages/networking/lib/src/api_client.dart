import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'models/example_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/todos/1')
  Future<ExampleResponse> fetchExample();
}
