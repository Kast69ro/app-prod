// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {

 LoginStep get step; String get phone; String get code; bool get loading; LoginFailure? get failure;/// Сколько секунд до «Отправить код снова».
 int get resendIn;/// Срок действия кода из ответа бэка, сек.
 int get codeExpiresIn;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LoginState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.loading, _this.loading) || other.loading == _this.loading)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.resendIn, _this.resendIn) || other.resendIn == _this.resendIn)&&(identical(other.codeExpiresIn, _this.codeExpiresIn) || other.codeExpiresIn == _this.codeExpiresIn));
}


@override
int get hashCode {
  final _this = this as LoginState;
  return Object.hash(runtimeType,_this.step,_this.phone,_this.code,_this.loading,_this.failure,_this.resendIn,_this.codeExpiresIn);
}

@override
String toString() {
  final _this = this as LoginState;
  return 'LoginState(step: ${_this.step}, phone: ${_this.phone}, code: ${_this.code}, loading: ${_this.loading}, failure: ${_this.failure}, resendIn: ${_this.resendIn}, codeExpiresIn: ${_this.codeExpiresIn})';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 LoginStep step, String phone, String code, bool loading, LoginFailure? failure, int resendIn, int codeExpiresIn
});




}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? phone = null,Object? code = null,Object? loading = null,Object? failure = freezed,Object? resendIn = null,Object? codeExpiresIn = null,}) {
  return _then(LoginState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as LoginStep,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as LoginFailure?,resendIn: null == resendIn ? _self.resendIn : resendIn // ignore: cast_nullable_to_non_nullable
as int,codeExpiresIn: null == codeExpiresIn ? _self.codeExpiresIn : codeExpiresIn // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginState value)  $default,){
final _that = this;
switch (_that) {
case _LoginState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoginStep step,  String phone,  String code,  bool loading,  LoginFailure? failure,  int resendIn,  int codeExpiresIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.step,_that.phone,_that.code,_that.loading,_that.failure,_that.resendIn,_that.codeExpiresIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoginStep step,  String phone,  String code,  bool loading,  LoginFailure? failure,  int resendIn,  int codeExpiresIn)  $default,) {final _that = this;
switch (_that) {
case _LoginState():
return $default(_that.step,_that.phone,_that.code,_that.loading,_that.failure,_that.resendIn,_that.codeExpiresIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoginStep step,  String phone,  String code,  bool loading,  LoginFailure? failure,  int resendIn,  int codeExpiresIn)?  $default,) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.step,_that.phone,_that.code,_that.loading,_that.failure,_that.resendIn,_that.codeExpiresIn);case _:
  return null;

}
}

}

/// @nodoc


class _LoginState extends LoginState {
  const _LoginState({this.step = LoginStep.phone, this.phone = '', this.code = '', this.loading = false, this.failure, this.resendIn = 0, this.codeExpiresIn = 300}): super._();
  

@override@JsonKey() final  LoginStep step;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String code;
@override@JsonKey() final  bool loading;
@override final  LoginFailure? failure;
/// Сколько секунд до «Отправить код снова».
@override@JsonKey() final  int resendIn;
/// Срок действия кода из ответа бэка, сек.
@override@JsonKey() final  int codeExpiresIn;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.step, step) || other.step == step)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.code, code) || other.code == code)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.resendIn, resendIn) || other.resendIn == resendIn)&&(identical(other.codeExpiresIn, codeExpiresIn) || other.codeExpiresIn == codeExpiresIn));
}


@override
int get hashCode {
    return Object.hash(runtimeType,step,phone,code,loading,failure,resendIn,codeExpiresIn);
}

@override
String toString() {
    return 'LoginState(step: $step, phone: $phone, code: $code, loading: $loading, failure: $failure, resendIn: $resendIn, codeExpiresIn: $codeExpiresIn)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 LoginStep step, String phone, String code, bool loading, LoginFailure? failure, int resendIn, int codeExpiresIn
});




}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? phone = null,Object? code = null,Object? loading = null,Object? failure = freezed,Object? resendIn = null,Object? codeExpiresIn = null,}) {
  return _then(_LoginState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as LoginStep,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as LoginFailure?,resendIn: null == resendIn ? _self.resendIn : resendIn // ignore: cast_nullable_to_non_nullable
as int,codeExpiresIn: null == codeExpiresIn ? _self.codeExpiresIn : codeExpiresIn // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
