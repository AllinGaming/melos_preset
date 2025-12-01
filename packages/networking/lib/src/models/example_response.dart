import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_response.freezed.dart';
part 'example_response.g.dart';

@freezed
class ExampleResponse with _$ExampleResponse {
  const factory ExampleResponse({
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _ExampleResponse;

  factory ExampleResponse.fromJson(Map<String, Object?> json) => _$ExampleResponseFromJson(json);
}
