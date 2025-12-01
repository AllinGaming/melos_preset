// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExampleResponse _$ExampleResponseFromJson(Map<String, dynamic> json) {
  return _ExampleResponse.fromJson(json);
}

/// @nodoc
mixin _$ExampleResponse {
  int get userId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExampleResponseCopyWith<ExampleResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleResponseCopyWith<$Res> {
  factory $ExampleResponseCopyWith(
          ExampleResponse value, $Res Function(ExampleResponse) then) =
      _$ExampleResponseCopyWithImpl<$Res, ExampleResponse>;
  @useResult
  $Res call({int userId, int id, String title, bool completed});
}

/// @nodoc
class _$ExampleResponseCopyWithImpl<$Res, $Val extends ExampleResponse>
    implements $ExampleResponseCopyWith<$Res> {
  _$ExampleResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? title = null,
    Object? completed = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExampleResponseImplCopyWith<$Res>
    implements $ExampleResponseCopyWith<$Res> {
  factory _$$ExampleResponseImplCopyWith(_$ExampleResponseImpl value,
          $Res Function(_$ExampleResponseImpl) then) =
      __$$ExampleResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, int id, String title, bool completed});
}

/// @nodoc
class __$$ExampleResponseImplCopyWithImpl<$Res>
    extends _$ExampleResponseCopyWithImpl<$Res, _$ExampleResponseImpl>
    implements _$$ExampleResponseImplCopyWith<$Res> {
  __$$ExampleResponseImplCopyWithImpl(
      _$ExampleResponseImpl _value, $Res Function(_$ExampleResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? title = null,
    Object? completed = null,
  }) {
    return _then(_$ExampleResponseImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExampleResponseImpl implements _ExampleResponse {
  const _$ExampleResponseImpl(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory _$ExampleResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExampleResponseImplFromJson(json);

  @override
  final int userId;
  @override
  final int id;
  @override
  final String title;
  @override
  final bool completed;

  @override
  String toString() {
    return 'ExampleResponse(userId: $userId, id: $id, title: $title, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExampleResponseImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, id, title, completed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExampleResponseImplCopyWith<_$ExampleResponseImpl> get copyWith =>
      __$$ExampleResponseImplCopyWithImpl<_$ExampleResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExampleResponseImplToJson(
      this,
    );
  }
}

abstract class _ExampleResponse implements ExampleResponse {
  const factory _ExampleResponse(
      {required final int userId,
      required final int id,
      required final String title,
      required final bool completed}) = _$ExampleResponseImpl;

  factory _ExampleResponse.fromJson(Map<String, dynamic> json) =
      _$ExampleResponseImpl.fromJson;

  @override
  int get userId;
  @override
  int get id;
  @override
  String get title;
  @override
  bool get completed;
  @override
  @JsonKey(ignore: true)
  _$$ExampleResponseImplCopyWith<_$ExampleResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
