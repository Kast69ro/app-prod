// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_pin_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangePinState {

 ChangePinStage get stage; String get pin; String get first; bool get busy; PinError? get error;
/// Create a copy of ChangePinState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePinStateCopyWith<ChangePinState> get copyWith => _$ChangePinStateCopyWithImpl<ChangePinState>(this as ChangePinState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChangePinState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePinState&&(identical(other.stage, _this.stage) || other.stage == _this.stage)&&(identical(other.pin, _this.pin) || other.pin == _this.pin)&&(identical(other.first, _this.first) || other.first == _this.first)&&(identical(other.busy, _this.busy) || other.busy == _this.busy)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as ChangePinState;
  return Object.hash(runtimeType,_this.stage,_this.pin,_this.first,_this.busy,_this.error);
}

@override
String toString() {
  final _this = this as ChangePinState;
  return 'ChangePinState(stage: ${_this.stage}, pin: ${_this.pin}, first: ${_this.first}, busy: ${_this.busy}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ChangePinStateCopyWith<$Res>  {
  factory $ChangePinStateCopyWith(ChangePinState value, $Res Function(ChangePinState) _then) = _$ChangePinStateCopyWithImpl;
@useResult
$Res call({
 ChangePinStage stage, String pin, String first, bool busy, PinError? error
});




}
/// @nodoc
class _$ChangePinStateCopyWithImpl<$Res>
    implements $ChangePinStateCopyWith<$Res> {
  _$ChangePinStateCopyWithImpl(this._self, this._then);

  final ChangePinState _self;
  final $Res Function(ChangePinState) _then;

/// Create a copy of ChangePinState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? pin = null,Object? first = null,Object? busy = null,Object? error = freezed,}) {
  return _then(ChangePinState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ChangePinStage,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as String,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as PinError?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePinState].
extension ChangePinStatePatterns on ChangePinState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePinState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePinState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePinState value)  $default,){
final _that = this;
switch (_that) {
case _ChangePinState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePinState value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePinState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChangePinStage stage,  String pin,  String first,  bool busy,  PinError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePinState() when $default != null:
return $default(_that.stage,_that.pin,_that.first,_that.busy,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChangePinStage stage,  String pin,  String first,  bool busy,  PinError? error)  $default,) {final _that = this;
switch (_that) {
case _ChangePinState():
return $default(_that.stage,_that.pin,_that.first,_that.busy,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChangePinStage stage,  String pin,  String first,  bool busy,  PinError? error)?  $default,) {final _that = this;
switch (_that) {
case _ChangePinState() when $default != null:
return $default(_that.stage,_that.pin,_that.first,_that.busy,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ChangePinState implements ChangePinState {
  const _ChangePinState({this.stage = ChangePinStage.current, this.pin = '', this.first = '', this.busy = false, this.error});
  

@override@JsonKey() final  ChangePinStage stage;
@override@JsonKey() final  String pin;
@override@JsonKey() final  String first;
@override@JsonKey() final  bool busy;
@override final  PinError? error;

/// Create a copy of ChangePinState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePinStateCopyWith<_ChangePinState> get copyWith => __$ChangePinStateCopyWithImpl<_ChangePinState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePinState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.first, first) || other.first == first)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,stage,pin,first,busy,error);
}

@override
String toString() {
    return 'ChangePinState(stage: $stage, pin: $pin, first: $first, busy: $busy, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ChangePinStateCopyWith<$Res> implements $ChangePinStateCopyWith<$Res> {
  factory _$ChangePinStateCopyWith(_ChangePinState value, $Res Function(_ChangePinState) _then) = __$ChangePinStateCopyWithImpl;
@override @useResult
$Res call({
 ChangePinStage stage, String pin, String first, bool busy, PinError? error
});




}
/// @nodoc
class __$ChangePinStateCopyWithImpl<$Res>
    implements _$ChangePinStateCopyWith<$Res> {
  __$ChangePinStateCopyWithImpl(this._self, this._then);

  final _ChangePinState _self;
  final $Res Function(_ChangePinState) _then;

/// Create a copy of ChangePinState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? pin = null,Object? first = null,Object? busy = null,Object? error = freezed,}) {
  return _then(_ChangePinState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ChangePinStage,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as String,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as PinError?,
  ));
}


}

// dart format on
