// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtpRequestDto {

 bool get ok; String? get message;@JsonKey(name: 'expires_in') int get expiresIn;
/// Create a copy of OtpRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpRequestDtoCopyWith<OtpRequestDto> get copyWith => _$OtpRequestDtoCopyWithImpl<OtpRequestDto>(this as OtpRequestDto, _$identity);

  /// Serializes this OtpRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OtpRequestDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpRequestDto&&(identical(other.ok, _this.ok) || other.ok == _this.ok)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.expiresIn, _this.expiresIn) || other.expiresIn == _this.expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OtpRequestDto;
  return Object.hash(runtimeType,_this.ok,_this.message,_this.expiresIn);
}

@override
String toString() {
  final _this = this as OtpRequestDto;
  return 'OtpRequestDto(ok: ${_this.ok}, message: ${_this.message}, expiresIn: ${_this.expiresIn})';
}


}

/// @nodoc
abstract mixin class $OtpRequestDtoCopyWith<$Res>  {
  factory $OtpRequestDtoCopyWith(OtpRequestDto value, $Res Function(OtpRequestDto) _then) = _$OtpRequestDtoCopyWithImpl;
@useResult
$Res call({
 bool ok, String? message,@JsonKey(name: 'expires_in') int expiresIn
});




}
/// @nodoc
class _$OtpRequestDtoCopyWithImpl<$Res>
    implements $OtpRequestDtoCopyWith<$Res> {
  _$OtpRequestDtoCopyWithImpl(this._self, this._then);

  final OtpRequestDto _self;
  final $Res Function(OtpRequestDto) _then;

/// Create a copy of OtpRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ok = null,Object? message = freezed,Object? expiresIn = null,}) {
  return _then(OtpRequestDto(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpRequestDto].
extension OtpRequestDtoPatterns on OtpRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _OtpRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _OtpRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool ok,  String? message, @JsonKey(name: 'expires_in')  int expiresIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpRequestDto() when $default != null:
return $default(_that.ok,_that.message,_that.expiresIn);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool ok,  String? message, @JsonKey(name: 'expires_in')  int expiresIn)  $default,) {final _that = this;
switch (_that) {
case _OtpRequestDto():
return $default(_that.ok,_that.message,_that.expiresIn);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool ok,  String? message, @JsonKey(name: 'expires_in')  int expiresIn)?  $default,) {final _that = this;
switch (_that) {
case _OtpRequestDto() when $default != null:
return $default(_that.ok,_that.message,_that.expiresIn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtpRequestDto implements OtpRequestDto {
  const _OtpRequestDto({this.ok = true, this.message, @JsonKey(name: 'expires_in') this.expiresIn = 300});
  factory _OtpRequestDto.fromJson(Map<String, dynamic> json) => _$OtpRequestDtoFromJson(json);

@override@JsonKey() final  bool ok;
@override final  String? message;
@override@JsonKey(name: 'expires_in') final  int expiresIn;

/// Create a copy of OtpRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpRequestDtoCopyWith<_OtpRequestDto> get copyWith => __$OtpRequestDtoCopyWithImpl<_OtpRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpRequestDto&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.message, message) || other.message == message)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,ok,message,expiresIn);
}

@override
String toString() {
    return 'OtpRequestDto(ok: $ok, message: $message, expiresIn: $expiresIn)';
}


}

/// @nodoc
abstract mixin class _$OtpRequestDtoCopyWith<$Res> implements $OtpRequestDtoCopyWith<$Res> {
  factory _$OtpRequestDtoCopyWith(_OtpRequestDto value, $Res Function(_OtpRequestDto) _then) = __$OtpRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 bool ok, String? message,@JsonKey(name: 'expires_in') int expiresIn
});




}
/// @nodoc
class __$OtpRequestDtoCopyWithImpl<$Res>
    implements _$OtpRequestDtoCopyWith<$Res> {
  __$OtpRequestDtoCopyWithImpl(this._self, this._then);

  final _OtpRequestDto _self;
  final $Res Function(_OtpRequestDto) _then;

/// Create a copy of OtpRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ok = null,Object? message = freezed,Object? expiresIn = null,}) {
  return _then(_OtpRequestDto(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$OtpVerifyDto {

 bool get ok;@JsonKey(fromJson: _idFromJson) String? get terminalId; String get terminalName; String get storeName;
/// Create a copy of OtpVerifyDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpVerifyDtoCopyWith<OtpVerifyDto> get copyWith => _$OtpVerifyDtoCopyWithImpl<OtpVerifyDto>(this as OtpVerifyDto, _$identity);

  /// Serializes this OtpVerifyDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OtpVerifyDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpVerifyDto&&(identical(other.ok, _this.ok) || other.ok == _this.ok)&&(identical(other.terminalId, _this.terminalId) || other.terminalId == _this.terminalId)&&(identical(other.terminalName, _this.terminalName) || other.terminalName == _this.terminalName)&&(identical(other.storeName, _this.storeName) || other.storeName == _this.storeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OtpVerifyDto;
  return Object.hash(runtimeType,_this.ok,_this.terminalId,_this.terminalName,_this.storeName);
}

@override
String toString() {
  final _this = this as OtpVerifyDto;
  return 'OtpVerifyDto(ok: ${_this.ok}, terminalId: ${_this.terminalId}, terminalName: ${_this.terminalName}, storeName: ${_this.storeName})';
}


}

/// @nodoc
abstract mixin class $OtpVerifyDtoCopyWith<$Res>  {
  factory $OtpVerifyDtoCopyWith(OtpVerifyDto value, $Res Function(OtpVerifyDto) _then) = _$OtpVerifyDtoCopyWithImpl;
@useResult
$Res call({
 bool ok,@JsonKey(fromJson: _idFromJson) String? terminalId, String terminalName, String storeName
});




}
/// @nodoc
class _$OtpVerifyDtoCopyWithImpl<$Res>
    implements $OtpVerifyDtoCopyWith<$Res> {
  _$OtpVerifyDtoCopyWithImpl(this._self, this._then);

  final OtpVerifyDto _self;
  final $Res Function(OtpVerifyDto) _then;

/// Create a copy of OtpVerifyDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ok = null,Object? terminalId = freezed,Object? terminalName = null,Object? storeName = null,}) {
  return _then(OtpVerifyDto(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,terminalId: freezed == terminalId ? _self.terminalId : terminalId // ignore: cast_nullable_to_non_nullable
as String?,terminalName: null == terminalName ? _self.terminalName : terminalName // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpVerifyDto].
extension OtpVerifyDtoPatterns on OtpVerifyDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpVerifyDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpVerifyDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpVerifyDto value)  $default,){
final _that = this;
switch (_that) {
case _OtpVerifyDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpVerifyDto value)?  $default,){
final _that = this;
switch (_that) {
case _OtpVerifyDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool ok, @JsonKey(fromJson: _idFromJson)  String? terminalId,  String terminalName,  String storeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpVerifyDto() when $default != null:
return $default(_that.ok,_that.terminalId,_that.terminalName,_that.storeName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool ok, @JsonKey(fromJson: _idFromJson)  String? terminalId,  String terminalName,  String storeName)  $default,) {final _that = this;
switch (_that) {
case _OtpVerifyDto():
return $default(_that.ok,_that.terminalId,_that.terminalName,_that.storeName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool ok, @JsonKey(fromJson: _idFromJson)  String? terminalId,  String terminalName,  String storeName)?  $default,) {final _that = this;
switch (_that) {
case _OtpVerifyDto() when $default != null:
return $default(_that.ok,_that.terminalId,_that.terminalName,_that.storeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtpVerifyDto implements OtpVerifyDto {
  const _OtpVerifyDto({this.ok = true, @JsonKey(fromJson: _idFromJson) this.terminalId, this.terminalName = '', this.storeName = ''});
  factory _OtpVerifyDto.fromJson(Map<String, dynamic> json) => _$OtpVerifyDtoFromJson(json);

@override@JsonKey() final  bool ok;
@override@JsonKey(fromJson: _idFromJson) final  String? terminalId;
@override@JsonKey() final  String terminalName;
@override@JsonKey() final  String storeName;

/// Create a copy of OtpVerifyDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpVerifyDtoCopyWith<_OtpVerifyDto> get copyWith => __$OtpVerifyDtoCopyWithImpl<_OtpVerifyDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpVerifyDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpVerifyDto&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.terminalId, terminalId) || other.terminalId == terminalId)&&(identical(other.terminalName, terminalName) || other.terminalName == terminalName)&&(identical(other.storeName, storeName) || other.storeName == storeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,ok,terminalId,terminalName,storeName);
}

@override
String toString() {
    return 'OtpVerifyDto(ok: $ok, terminalId: $terminalId, terminalName: $terminalName, storeName: $storeName)';
}


}

/// @nodoc
abstract mixin class _$OtpVerifyDtoCopyWith<$Res> implements $OtpVerifyDtoCopyWith<$Res> {
  factory _$OtpVerifyDtoCopyWith(_OtpVerifyDto value, $Res Function(_OtpVerifyDto) _then) = __$OtpVerifyDtoCopyWithImpl;
@override @useResult
$Res call({
 bool ok,@JsonKey(fromJson: _idFromJson) String? terminalId, String terminalName, String storeName
});




}
/// @nodoc
class __$OtpVerifyDtoCopyWithImpl<$Res>
    implements _$OtpVerifyDtoCopyWith<$Res> {
  __$OtpVerifyDtoCopyWithImpl(this._self, this._then);

  final _OtpVerifyDto _self;
  final $Res Function(_OtpVerifyDto) _then;

/// Create a copy of OtpVerifyDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ok = null,Object? terminalId = freezed,Object? terminalName = null,Object? storeName = null,}) {
  return _then(_OtpVerifyDto(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,terminalId: freezed == terminalId ? _self.terminalId : terminalId // ignore: cast_nullable_to_non_nullable
as String?,terminalName: null == terminalName ? _self.terminalName : terminalName // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
