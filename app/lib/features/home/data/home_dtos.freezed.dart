// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TerminalDto {

 String get terminalName; String get terminalPhone; String get storeName; String get terminalQR;
/// Create a copy of TerminalDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TerminalDtoCopyWith<TerminalDto> get copyWith => _$TerminalDtoCopyWithImpl<TerminalDto>(this as TerminalDto, _$identity);

  /// Serializes this TerminalDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TerminalDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalDto&&(identical(other.terminalName, _this.terminalName) || other.terminalName == _this.terminalName)&&(identical(other.terminalPhone, _this.terminalPhone) || other.terminalPhone == _this.terminalPhone)&&(identical(other.storeName, _this.storeName) || other.storeName == _this.storeName)&&(identical(other.terminalQR, _this.terminalQR) || other.terminalQR == _this.terminalQR));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TerminalDto;
  return Object.hash(runtimeType,_this.terminalName,_this.terminalPhone,_this.storeName,_this.terminalQR);
}

@override
String toString() {
  final _this = this as TerminalDto;
  return 'TerminalDto(terminalName: ${_this.terminalName}, terminalPhone: ${_this.terminalPhone}, storeName: ${_this.storeName}, terminalQR: ${_this.terminalQR})';
}


}

/// @nodoc
abstract mixin class $TerminalDtoCopyWith<$Res>  {
  factory $TerminalDtoCopyWith(TerminalDto value, $Res Function(TerminalDto) _then) = _$TerminalDtoCopyWithImpl;
@useResult
$Res call({
 String terminalName, String terminalPhone, String storeName, String terminalQR
});




}
/// @nodoc
class _$TerminalDtoCopyWithImpl<$Res>
    implements $TerminalDtoCopyWith<$Res> {
  _$TerminalDtoCopyWithImpl(this._self, this._then);

  final TerminalDto _self;
  final $Res Function(TerminalDto) _then;

/// Create a copy of TerminalDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? terminalName = null,Object? terminalPhone = null,Object? storeName = null,Object? terminalQR = null,}) {
  return _then(TerminalDto(
terminalName: null == terminalName ? _self.terminalName : terminalName // ignore: cast_nullable_to_non_nullable
as String,terminalPhone: null == terminalPhone ? _self.terminalPhone : terminalPhone // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,terminalQR: null == terminalQR ? _self.terminalQR : terminalQR // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TerminalDto].
extension TerminalDtoPatterns on TerminalDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TerminalDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TerminalDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TerminalDto value)  $default,){
final _that = this;
switch (_that) {
case _TerminalDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TerminalDto value)?  $default,){
final _that = this;
switch (_that) {
case _TerminalDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String terminalName,  String terminalPhone,  String storeName,  String terminalQR)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TerminalDto() when $default != null:
return $default(_that.terminalName,_that.terminalPhone,_that.storeName,_that.terminalQR);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String terminalName,  String terminalPhone,  String storeName,  String terminalQR)  $default,) {final _that = this;
switch (_that) {
case _TerminalDto():
return $default(_that.terminalName,_that.terminalPhone,_that.storeName,_that.terminalQR);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String terminalName,  String terminalPhone,  String storeName,  String terminalQR)?  $default,) {final _that = this;
switch (_that) {
case _TerminalDto() when $default != null:
return $default(_that.terminalName,_that.terminalPhone,_that.storeName,_that.terminalQR);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TerminalDto implements TerminalDto {
  const _TerminalDto({this.terminalName = '', this.terminalPhone = '', this.storeName = '', this.terminalQR = ''});
  factory _TerminalDto.fromJson(Map<String, dynamic> json) => _$TerminalDtoFromJson(json);

@override@JsonKey() final  String terminalName;
@override@JsonKey() final  String terminalPhone;
@override@JsonKey() final  String storeName;
@override@JsonKey() final  String terminalQR;

/// Create a copy of TerminalDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TerminalDtoCopyWith<_TerminalDto> get copyWith => __$TerminalDtoCopyWithImpl<_TerminalDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TerminalDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TerminalDto&&(identical(other.terminalName, terminalName) || other.terminalName == terminalName)&&(identical(other.terminalPhone, terminalPhone) || other.terminalPhone == terminalPhone)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.terminalQR, terminalQR) || other.terminalQR == terminalQR));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,terminalName,terminalPhone,storeName,terminalQR);
}

@override
String toString() {
    return 'TerminalDto(terminalName: $terminalName, terminalPhone: $terminalPhone, storeName: $storeName, terminalQR: $terminalQR)';
}


}

/// @nodoc
abstract mixin class _$TerminalDtoCopyWith<$Res> implements $TerminalDtoCopyWith<$Res> {
  factory _$TerminalDtoCopyWith(_TerminalDto value, $Res Function(_TerminalDto) _then) = __$TerminalDtoCopyWithImpl;
@override @useResult
$Res call({
 String terminalName, String terminalPhone, String storeName, String terminalQR
});




}
/// @nodoc
class __$TerminalDtoCopyWithImpl<$Res>
    implements _$TerminalDtoCopyWith<$Res> {
  __$TerminalDtoCopyWithImpl(this._self, this._then);

  final _TerminalDto _self;
  final $Res Function(_TerminalDto) _then;

/// Create a copy of TerminalDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? terminalName = null,Object? terminalPhone = null,Object? storeName = null,Object? terminalQR = null,}) {
  return _then(_TerminalDto(
terminalName: null == terminalName ? _self.terminalName : terminalName // ignore: cast_nullable_to_non_nullable
as String,terminalPhone: null == terminalPhone ? _self.terminalPhone : terminalPhone // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,terminalQR: null == terminalQR ? _self.terminalQR : terminalQR // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TerminalResponseDto {

 TerminalDto get terminal;@JsonKey(name: 'last_payment') PaymentDto? get lastPayment;
/// Create a copy of TerminalResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TerminalResponseDtoCopyWith<TerminalResponseDto> get copyWith => _$TerminalResponseDtoCopyWithImpl<TerminalResponseDto>(this as TerminalResponseDto, _$identity);

  /// Serializes this TerminalResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TerminalResponseDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalResponseDto&&(identical(other.terminal, _this.terminal) || other.terminal == _this.terminal)&&(identical(other.lastPayment, _this.lastPayment) || other.lastPayment == _this.lastPayment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TerminalResponseDto;
  return Object.hash(runtimeType,_this.terminal,_this.lastPayment);
}

@override
String toString() {
  final _this = this as TerminalResponseDto;
  return 'TerminalResponseDto(terminal: ${_this.terminal}, lastPayment: ${_this.lastPayment})';
}


}

/// @nodoc
abstract mixin class $TerminalResponseDtoCopyWith<$Res>  {
  factory $TerminalResponseDtoCopyWith(TerminalResponseDto value, $Res Function(TerminalResponseDto) _then) = _$TerminalResponseDtoCopyWithImpl;
@useResult
$Res call({
 TerminalDto terminal,@JsonKey(name: 'last_payment') PaymentDto? lastPayment
});


$TerminalDtoCopyWith<$Res> get terminal;$PaymentDtoCopyWith<$Res>? get lastPayment;

}
/// @nodoc
class _$TerminalResponseDtoCopyWithImpl<$Res>
    implements $TerminalResponseDtoCopyWith<$Res> {
  _$TerminalResponseDtoCopyWithImpl(this._self, this._then);

  final TerminalResponseDto _self;
  final $Res Function(TerminalResponseDto) _then;

/// Create a copy of TerminalResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? terminal = null,Object? lastPayment = freezed,}) {
  return _then(TerminalResponseDto(
terminal: null == terminal ? _self.terminal : terminal // ignore: cast_nullable_to_non_nullable
as TerminalDto,lastPayment: freezed == lastPayment ? _self.lastPayment : lastPayment // ignore: cast_nullable_to_non_nullable
as PaymentDto?,
  ));
}
/// Create a copy of TerminalResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TerminalDtoCopyWith<$Res> get terminal {
  
  return $TerminalDtoCopyWith<$Res>(_self.terminal, (value) {
    return _then(_self.copyWith(terminal: value));
  });
}/// Create a copy of TerminalResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentDtoCopyWith<$Res>? get lastPayment {
    if (_self.lastPayment == null) {
    return null;
  }

  return $PaymentDtoCopyWith<$Res>(_self.lastPayment!, (value) {
    return _then(_self.copyWith(lastPayment: value));
  });
}
}


/// Adds pattern-matching-related methods to [TerminalResponseDto].
extension TerminalResponseDtoPatterns on TerminalResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TerminalResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TerminalResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TerminalResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _TerminalResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TerminalResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _TerminalResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TerminalDto terminal, @JsonKey(name: 'last_payment')  PaymentDto? lastPayment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TerminalResponseDto() when $default != null:
return $default(_that.terminal,_that.lastPayment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TerminalDto terminal, @JsonKey(name: 'last_payment')  PaymentDto? lastPayment)  $default,) {final _that = this;
switch (_that) {
case _TerminalResponseDto():
return $default(_that.terminal,_that.lastPayment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TerminalDto terminal, @JsonKey(name: 'last_payment')  PaymentDto? lastPayment)?  $default,) {final _that = this;
switch (_that) {
case _TerminalResponseDto() when $default != null:
return $default(_that.terminal,_that.lastPayment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TerminalResponseDto extends TerminalResponseDto {
  const _TerminalResponseDto({required this.terminal, @JsonKey(name: 'last_payment') this.lastPayment}): super._();
  factory _TerminalResponseDto.fromJson(Map<String, dynamic> json) => _$TerminalResponseDtoFromJson(json);

@override final  TerminalDto terminal;
@override@JsonKey(name: 'last_payment') final  PaymentDto? lastPayment;

/// Create a copy of TerminalResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TerminalResponseDtoCopyWith<_TerminalResponseDto> get copyWith => __$TerminalResponseDtoCopyWithImpl<_TerminalResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TerminalResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TerminalResponseDto&&(identical(other.terminal, terminal) || other.terminal == terminal)&&(identical(other.lastPayment, lastPayment) || other.lastPayment == lastPayment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,terminal,lastPayment);
}

@override
String toString() {
    return 'TerminalResponseDto(terminal: $terminal, lastPayment: $lastPayment)';
}


}

/// @nodoc
abstract mixin class _$TerminalResponseDtoCopyWith<$Res> implements $TerminalResponseDtoCopyWith<$Res> {
  factory _$TerminalResponseDtoCopyWith(_TerminalResponseDto value, $Res Function(_TerminalResponseDto) _then) = __$TerminalResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 TerminalDto terminal,@JsonKey(name: 'last_payment') PaymentDto? lastPayment
});


@override $TerminalDtoCopyWith<$Res> get terminal;@override $PaymentDtoCopyWith<$Res>? get lastPayment;

}
/// @nodoc
class __$TerminalResponseDtoCopyWithImpl<$Res>
    implements _$TerminalResponseDtoCopyWith<$Res> {
  __$TerminalResponseDtoCopyWithImpl(this._self, this._then);

  final _TerminalResponseDto _self;
  final $Res Function(_TerminalResponseDto) _then;

/// Create a copy of TerminalResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? terminal = null,Object? lastPayment = freezed,}) {
  return _then(_TerminalResponseDto(
terminal: null == terminal ? _self.terminal : terminal // ignore: cast_nullable_to_non_nullable
as TerminalDto,lastPayment: freezed == lastPayment ? _self.lastPayment : lastPayment // ignore: cast_nullable_to_non_nullable
as PaymentDto?,
  ));
}

/// Create a copy of TerminalResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TerminalDtoCopyWith<$Res> get terminal {
  
  return $TerminalDtoCopyWith<$Res>(_self.terminal, (value) {
    return _then(_self.copyWith(terminal: value));
  });
}/// Create a copy of TerminalResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentDtoCopyWith<$Res>? get lastPayment {
    if (_self.lastPayment == null) {
    return null;
  }

  return $PaymentDtoCopyWith<$Res>(_self.lastPayment!, (value) {
    return _then(_self.copyWith(lastPayment: value));
  });
}
}


/// @nodoc
mixin _$TotalsDto {

 int get count; num get amount;
/// Create a copy of TotalsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TotalsDtoCopyWith<TotalsDto> get copyWith => _$TotalsDtoCopyWithImpl<TotalsDto>(this as TotalsDto, _$identity);

  /// Serializes this TotalsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TotalsDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TotalsDto&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.amount, _this.amount) || other.amount == _this.amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TotalsDto;
  return Object.hash(runtimeType,_this.count,_this.amount);
}

@override
String toString() {
  final _this = this as TotalsDto;
  return 'TotalsDto(count: ${_this.count}, amount: ${_this.amount})';
}


}

/// @nodoc
abstract mixin class $TotalsDtoCopyWith<$Res>  {
  factory $TotalsDtoCopyWith(TotalsDto value, $Res Function(TotalsDto) _then) = _$TotalsDtoCopyWithImpl;
@useResult
$Res call({
 int count, num amount
});




}
/// @nodoc
class _$TotalsDtoCopyWithImpl<$Res>
    implements $TotalsDtoCopyWith<$Res> {
  _$TotalsDtoCopyWithImpl(this._self, this._then);

  final TotalsDto _self;
  final $Res Function(TotalsDto) _then;

/// Create a copy of TotalsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? amount = null,}) {
  return _then(TotalsDto(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [TotalsDto].
extension TotalsDtoPatterns on TotalsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TotalsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TotalsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TotalsDto value)  $default,){
final _that = this;
switch (_that) {
case _TotalsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TotalsDto value)?  $default,){
final _that = this;
switch (_that) {
case _TotalsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  num amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TotalsDto() when $default != null:
return $default(_that.count,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  num amount)  $default,) {final _that = this;
switch (_that) {
case _TotalsDto():
return $default(_that.count,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  num amount)?  $default,) {final _that = this;
switch (_that) {
case _TotalsDto() when $default != null:
return $default(_that.count,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TotalsDto extends TotalsDto {
  const _TotalsDto({this.count = 0, this.amount = 0}): super._();
  factory _TotalsDto.fromJson(Map<String, dynamic> json) => _$TotalsDtoFromJson(json);

@override@JsonKey() final  int count;
@override@JsonKey() final  num amount;

/// Create a copy of TotalsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TotalsDtoCopyWith<_TotalsDto> get copyWith => __$TotalsDtoCopyWithImpl<_TotalsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TotalsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TotalsDto&&(identical(other.count, count) || other.count == count)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,count,amount);
}

@override
String toString() {
    return 'TotalsDto(count: $count, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$TotalsDtoCopyWith<$Res> implements $TotalsDtoCopyWith<$Res> {
  factory _$TotalsDtoCopyWith(_TotalsDto value, $Res Function(_TotalsDto) _then) = __$TotalsDtoCopyWithImpl;
@override @useResult
$Res call({
 int count, num amount
});




}
/// @nodoc
class __$TotalsDtoCopyWithImpl<$Res>
    implements _$TotalsDtoCopyWith<$Res> {
  __$TotalsDtoCopyWithImpl(this._self, this._then);

  final _TotalsDto _self;
  final $Res Function(_TotalsDto) _then;

/// Create a copy of TotalsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? amount = null,}) {
  return _then(_TotalsDto(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$SummaryDto {

 String? get date; TotalsDto get success; TotalsDto get cancel; TotalsDto? get refunded;
/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryDtoCopyWith<SummaryDto> get copyWith => _$SummaryDtoCopyWithImpl<SummaryDto>(this as SummaryDto, _$identity);

  /// Serializes this SummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SummaryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryDto&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.cancel, _this.cancel) || other.cancel == _this.cancel)&&(identical(other.refunded, _this.refunded) || other.refunded == _this.refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SummaryDto;
  return Object.hash(runtimeType,_this.date,_this.success,_this.cancel,_this.refunded);
}

@override
String toString() {
  final _this = this as SummaryDto;
  return 'SummaryDto(date: ${_this.date}, success: ${_this.success}, cancel: ${_this.cancel}, refunded: ${_this.refunded})';
}


}

/// @nodoc
abstract mixin class $SummaryDtoCopyWith<$Res>  {
  factory $SummaryDtoCopyWith(SummaryDto value, $Res Function(SummaryDto) _then) = _$SummaryDtoCopyWithImpl;
@useResult
$Res call({
 String? date, TotalsDto success, TotalsDto cancel, TotalsDto? refunded
});


$TotalsDtoCopyWith<$Res> get success;$TotalsDtoCopyWith<$Res> get cancel;$TotalsDtoCopyWith<$Res>? get refunded;

}
/// @nodoc
class _$SummaryDtoCopyWithImpl<$Res>
    implements $SummaryDtoCopyWith<$Res> {
  _$SummaryDtoCopyWithImpl(this._self, this._then);

  final SummaryDto _self;
  final $Res Function(SummaryDto) _then;

/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? success = null,Object? cancel = null,Object? refunded = freezed,}) {
  return _then(SummaryDto(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as TotalsDto,cancel: null == cancel ? _self.cancel : cancel // ignore: cast_nullable_to_non_nullable
as TotalsDto,refunded: freezed == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as TotalsDto?,
  ));
}
/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TotalsDtoCopyWith<$Res> get success {
  
  return $TotalsDtoCopyWith<$Res>(_self.success, (value) {
    return _then(_self.copyWith(success: value));
  });
}/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TotalsDtoCopyWith<$Res> get cancel {
  
  return $TotalsDtoCopyWith<$Res>(_self.cancel, (value) {
    return _then(_self.copyWith(cancel: value));
  });
}/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TotalsDtoCopyWith<$Res>? get refunded {
    if (_self.refunded == null) {
    return null;
  }

  return $TotalsDtoCopyWith<$Res>(_self.refunded!, (value) {
    return _then(_self.copyWith(refunded: value));
  });
}
}


/// Adds pattern-matching-related methods to [SummaryDto].
extension SummaryDtoPatterns on SummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _SummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? date,  TotalsDto success,  TotalsDto cancel,  TotalsDto? refunded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryDto() when $default != null:
return $default(_that.date,_that.success,_that.cancel,_that.refunded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? date,  TotalsDto success,  TotalsDto cancel,  TotalsDto? refunded)  $default,) {final _that = this;
switch (_that) {
case _SummaryDto():
return $default(_that.date,_that.success,_that.cancel,_that.refunded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? date,  TotalsDto success,  TotalsDto cancel,  TotalsDto? refunded)?  $default,) {final _that = this;
switch (_that) {
case _SummaryDto() when $default != null:
return $default(_that.date,_that.success,_that.cancel,_that.refunded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SummaryDto extends SummaryDto {
  const _SummaryDto({this.date, this.success = const TotalsDto(), this.cancel = const TotalsDto(), this.refunded}): super._();
  factory _SummaryDto.fromJson(Map<String, dynamic> json) => _$SummaryDtoFromJson(json);

@override final  String? date;
@override@JsonKey() final  TotalsDto success;
@override@JsonKey() final  TotalsDto cancel;
@override final  TotalsDto? refunded;

/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryDtoCopyWith<_SummaryDto> get copyWith => __$SummaryDtoCopyWithImpl<_SummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryDto&&(identical(other.date, date) || other.date == date)&&(identical(other.success, success) || other.success == success)&&(identical(other.cancel, cancel) || other.cancel == cancel)&&(identical(other.refunded, refunded) || other.refunded == refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,success,cancel,refunded);
}

@override
String toString() {
    return 'SummaryDto(date: $date, success: $success, cancel: $cancel, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class _$SummaryDtoCopyWith<$Res> implements $SummaryDtoCopyWith<$Res> {
  factory _$SummaryDtoCopyWith(_SummaryDto value, $Res Function(_SummaryDto) _then) = __$SummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String? date, TotalsDto success, TotalsDto cancel, TotalsDto? refunded
});


@override $TotalsDtoCopyWith<$Res> get success;@override $TotalsDtoCopyWith<$Res> get cancel;@override $TotalsDtoCopyWith<$Res>? get refunded;

}
/// @nodoc
class __$SummaryDtoCopyWithImpl<$Res>
    implements _$SummaryDtoCopyWith<$Res> {
  __$SummaryDtoCopyWithImpl(this._self, this._then);

  final _SummaryDto _self;
  final $Res Function(_SummaryDto) _then;

/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? success = null,Object? cancel = null,Object? refunded = freezed,}) {
  return _then(_SummaryDto(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as TotalsDto,cancel: null == cancel ? _self.cancel : cancel // ignore: cast_nullable_to_non_nullable
as TotalsDto,refunded: freezed == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as TotalsDto?,
  ));
}

/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TotalsDtoCopyWith<$Res> get success {
  
  return $TotalsDtoCopyWith<$Res>(_self.success, (value) {
    return _then(_self.copyWith(success: value));
  });
}/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TotalsDtoCopyWith<$Res> get cancel {
  
  return $TotalsDtoCopyWith<$Res>(_self.cancel, (value) {
    return _then(_self.copyWith(cancel: value));
  });
}/// Create a copy of SummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TotalsDtoCopyWith<$Res>? get refunded {
    if (_self.refunded == null) {
    return null;
  }

  return $TotalsDtoCopyWith<$Res>(_self.refunded!, (value) {
    return _then(_self.copyWith(refunded: value));
  });
}
}

// dart format on
