// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PinState {

 PinStage get stage; String get pin;/// Код с первого ввода — до подтверждения, только в памяти.
 String get first; bool get busy; PinError? get error;
/// Create a copy of PinState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinStateCopyWith<PinState> get copyWith => _$PinStateCopyWithImpl<PinState>(this as PinState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PinState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinState&&(identical(other.stage, _this.stage) || other.stage == _this.stage)&&(identical(other.pin, _this.pin) || other.pin == _this.pin)&&(identical(other.first, _this.first) || other.first == _this.first)&&(identical(other.busy, _this.busy) || other.busy == _this.busy)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as PinState;
  return Object.hash(runtimeType,_this.stage,_this.pin,_this.first,_this.busy,_this.error);
}

@override
String toString() {
  final _this = this as PinState;
  return 'PinState(stage: ${_this.stage}, pin: ${_this.pin}, first: ${_this.first}, busy: ${_this.busy}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $PinStateCopyWith<$Res>  {
  factory $PinStateCopyWith(PinState value, $Res Function(PinState) _then) = _$PinStateCopyWithImpl;
@useResult
$Res call({
 PinStage stage, String pin, String first, bool busy, PinError? error
});




}
/// @nodoc
class _$PinStateCopyWithImpl<$Res>
    implements $PinStateCopyWith<$Res> {
  _$PinStateCopyWithImpl(this._self, this._then);

  final PinState _self;
  final $Res Function(PinState) _then;

/// Create a copy of PinState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? pin = null,Object? first = null,Object? busy = null,Object? error = freezed,}) {
  return _then(PinState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PinStage,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as String,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as PinError?,
  ));
}

}


/// Adds pattern-matching-related methods to [PinState].
extension PinStatePatterns on PinState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinState value)  $default,){
final _that = this;
switch (_that) {
case _PinState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinState value)?  $default,){
final _that = this;
switch (_that) {
case _PinState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PinStage stage,  String pin,  String first,  bool busy,  PinError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PinStage stage,  String pin,  String first,  bool busy,  PinError? error)  $default,) {final _that = this;
switch (_that) {
case _PinState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PinStage stage,  String pin,  String first,  bool busy,  PinError? error)?  $default,) {final _that = this;
switch (_that) {
case _PinState() when $default != null:
return $default(_that.stage,_that.pin,_that.first,_that.busy,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PinState implements PinState {
  const _PinState({required this.stage, this.pin = '', this.first = '', this.busy = false, this.error});
  

@override final  PinStage stage;
@override@JsonKey() final  String pin;
/// Код с первого ввода — до подтверждения, только в памяти.
@override@JsonKey() final  String first;
@override@JsonKey() final  bool busy;
@override final  PinError? error;

/// Create a copy of PinState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinStateCopyWith<_PinState> get copyWith => __$PinStateCopyWithImpl<_PinState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.first, first) || other.first == first)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,stage,pin,first,busy,error);
}

@override
String toString() {
    return 'PinState(stage: $stage, pin: $pin, first: $first, busy: $busy, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PinStateCopyWith<$Res> implements $PinStateCopyWith<$Res> {
  factory _$PinStateCopyWith(_PinState value, $Res Function(_PinState) _then) = __$PinStateCopyWithImpl;
@override @useResult
$Res call({
 PinStage stage, String pin, String first, bool busy, PinError? error
});




}
/// @nodoc
class __$PinStateCopyWithImpl<$Res>
    implements _$PinStateCopyWith<$Res> {
  __$PinStateCopyWithImpl(this._self, this._then);

  final _PinState _self;
  final $Res Function(_PinState) _then;

/// Create a copy of PinState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? pin = null,Object? first = null,Object? busy = null,Object? error = freezed,}) {
  return _then(_PinState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PinStage,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as String,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as PinError?,
  ));
}


}

// dart format on
