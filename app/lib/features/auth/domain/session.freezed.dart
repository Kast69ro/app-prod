// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Session {

/// 9 цифр без +992.
 String get phone;@JsonKey(fromJson: _idFromJson) String? get terminalId; String get terminalName; String get storeName; String? get terminalQR;
/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionCopyWith<Session> get copyWith => _$SessionCopyWithImpl<Session>(this as Session, _$identity);

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Session;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Session&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.terminalId, _this.terminalId) || other.terminalId == _this.terminalId)&&(identical(other.terminalName, _this.terminalName) || other.terminalName == _this.terminalName)&&(identical(other.storeName, _this.storeName) || other.storeName == _this.storeName)&&(identical(other.terminalQR, _this.terminalQR) || other.terminalQR == _this.terminalQR));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Session;
  return Object.hash(runtimeType,_this.phone,_this.terminalId,_this.terminalName,_this.storeName,_this.terminalQR);
}

@override
String toString() {
  final _this = this as Session;
  return 'Session(phone: ${_this.phone}, terminalId: ${_this.terminalId}, terminalName: ${_this.terminalName}, storeName: ${_this.storeName}, terminalQR: ${_this.terminalQR})';
}


}

/// @nodoc
abstract mixin class $SessionCopyWith<$Res>  {
  factory $SessionCopyWith(Session value, $Res Function(Session) _then) = _$SessionCopyWithImpl;
@useResult
$Res call({
 String phone,@JsonKey(fromJson: _idFromJson) String? terminalId, String terminalName, String storeName, String? terminalQR
});




}
/// @nodoc
class _$SessionCopyWithImpl<$Res>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._self, this._then);

  final Session _self;
  final $Res Function(Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? terminalId = freezed,Object? terminalName = null,Object? storeName = null,Object? terminalQR = freezed,}) {
  return _then(Session(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,terminalId: freezed == terminalId ? _self.terminalId : terminalId // ignore: cast_nullable_to_non_nullable
as String?,terminalName: null == terminalName ? _self.terminalName : terminalName // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,terminalQR: freezed == terminalQR ? _self.terminalQR : terminalQR // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Session].
extension SessionPatterns on Session {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Session value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Session value)  $default,){
final _that = this;
switch (_that) {
case _Session():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Session value)?  $default,){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone, @JsonKey(fromJson: _idFromJson)  String? terminalId,  String terminalName,  String storeName,  String? terminalQR)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.phone,_that.terminalId,_that.terminalName,_that.storeName,_that.terminalQR);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone, @JsonKey(fromJson: _idFromJson)  String? terminalId,  String terminalName,  String storeName,  String? terminalQR)  $default,) {final _that = this;
switch (_that) {
case _Session():
return $default(_that.phone,_that.terminalId,_that.terminalName,_that.storeName,_that.terminalQR);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone, @JsonKey(fromJson: _idFromJson)  String? terminalId,  String terminalName,  String storeName,  String? terminalQR)?  $default,) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.phone,_that.terminalId,_that.terminalName,_that.storeName,_that.terminalQR);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Session implements Session {
  const _Session({required this.phone, @JsonKey(fromJson: _idFromJson) this.terminalId, this.terminalName = '', this.storeName = '', this.terminalQR});
  factory _Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

/// 9 цифр без +992.
@override final  String phone;
@override@JsonKey(fromJson: _idFromJson) final  String? terminalId;
@override@JsonKey() final  String terminalName;
@override@JsonKey() final  String storeName;
@override final  String? terminalQR;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionCopyWith<_Session> get copyWith => __$SessionCopyWithImpl<_Session>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Session&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.terminalId, terminalId) || other.terminalId == terminalId)&&(identical(other.terminalName, terminalName) || other.terminalName == terminalName)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.terminalQR, terminalQR) || other.terminalQR == terminalQR));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phone,terminalId,terminalName,storeName,terminalQR);
}

@override
String toString() {
    return 'Session(phone: $phone, terminalId: $terminalId, terminalName: $terminalName, storeName: $storeName, terminalQR: $terminalQR)';
}


}

/// @nodoc
abstract mixin class _$SessionCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$SessionCopyWith(_Session value, $Res Function(_Session) _then) = __$SessionCopyWithImpl;
@override @useResult
$Res call({
 String phone,@JsonKey(fromJson: _idFromJson) String? terminalId, String terminalName, String storeName, String? terminalQR
});




}
/// @nodoc
class __$SessionCopyWithImpl<$Res>
    implements _$SessionCopyWith<$Res> {
  __$SessionCopyWithImpl(this._self, this._then);

  final _Session _self;
  final $Res Function(_Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? terminalId = freezed,Object? terminalName = null,Object? storeName = null,Object? terminalQR = freezed,}) {
  return _then(_Session(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,terminalId: freezed == terminalId ? _self.terminalId : terminalId // ignore: cast_nullable_to_non_nullable
as String?,terminalName: null == terminalName ? _self.terminalName : terminalName // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,terminalQR: freezed == terminalQR ? _self.terminalQR : terminalQR // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SessionState {

 AuthStatus get status; Session? get session; SignOutReason? get reason;
/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStateCopyWith<SessionState> get copyWith => _$SessionStateCopyWithImpl<SessionState>(this as SessionState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.session, _this.session) || other.session == _this.session)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}


@override
int get hashCode {
  final _this = this as SessionState;
  return Object.hash(runtimeType,_this.status,_this.session,_this.reason);
}

@override
String toString() {
  final _this = this as SessionState;
  return 'SessionState(status: ${_this.status}, session: ${_this.session}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $SessionStateCopyWith<$Res>  {
  factory $SessionStateCopyWith(SessionState value, $Res Function(SessionState) _then) = _$SessionStateCopyWithImpl;
@useResult
$Res call({
 AuthStatus status, Session? session, SignOutReason? reason
});


$SessionCopyWith<$Res>? get session;

}
/// @nodoc
class _$SessionStateCopyWithImpl<$Res>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._self, this._then);

  final SessionState _self;
  final $Res Function(SessionState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? session = freezed,Object? reason = freezed,}) {
  return _then(SessionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as SignOutReason?,
  ));
}
/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionState].
extension SessionStatePatterns on SessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionState value)  $default,){
final _that = this;
switch (_that) {
case _SessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionState value)?  $default,){
final _that = this;
switch (_that) {
case _SessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthStatus status,  Session? session,  SignOutReason? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionState() when $default != null:
return $default(_that.status,_that.session,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthStatus status,  Session? session,  SignOutReason? reason)  $default,) {final _that = this;
switch (_that) {
case _SessionState():
return $default(_that.status,_that.session,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthStatus status,  Session? session,  SignOutReason? reason)?  $default,) {final _that = this;
switch (_that) {
case _SessionState() when $default != null:
return $default(_that.status,_that.session,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _SessionState implements SessionState {
  const _SessionState({required this.status, this.session, this.reason});
  

@override final  AuthStatus status;
@override final  Session? session;
@override final  SignOutReason? reason;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionStateCopyWith<_SessionState> get copyWith => __$SessionStateCopyWithImpl<_SessionState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionState&&(identical(other.status, status) || other.status == status)&&(identical(other.session, session) || other.session == session)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,session,reason);
}

@override
String toString() {
    return 'SessionState(status: $status, session: $session, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$SessionStateCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory _$SessionStateCopyWith(_SessionState value, $Res Function(_SessionState) _then) = __$SessionStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStatus status, Session? session, SignOutReason? reason
});


@override $SessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$SessionStateCopyWithImpl<$Res>
    implements _$SessionStateCopyWith<$Res> {
  __$SessionStateCopyWithImpl(this._self, this._then);

  final _SessionState _self;
  final $Res Function(_SessionState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? session = freezed,Object? reason = freezed,}) {
  return _then(_SessionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as SignOutReason?,
  ));
}

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
