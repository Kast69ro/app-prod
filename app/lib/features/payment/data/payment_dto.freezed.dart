// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentDto {

 String? get type; String? get sender;@JsonKey(name: 'sender_bank_id') int? get senderBankId; num get amount; String? get status;@JsonKey(name: 'creation_datetime') String? get creationDatetime;
/// Create a copy of PaymentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentDtoCopyWith<PaymentDto> get copyWith => _$PaymentDtoCopyWithImpl<PaymentDto>(this as PaymentDto, _$identity);

  /// Serializes this PaymentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PaymentDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentDto&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.sender, _this.sender) || other.sender == _this.sender)&&(identical(other.senderBankId, _this.senderBankId) || other.senderBankId == _this.senderBankId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.creationDatetime, _this.creationDatetime) || other.creationDatetime == _this.creationDatetime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PaymentDto;
  return Object.hash(runtimeType,_this.type,_this.sender,_this.senderBankId,_this.amount,_this.status,_this.creationDatetime);
}

@override
String toString() {
  final _this = this as PaymentDto;
  return 'PaymentDto(type: ${_this.type}, sender: ${_this.sender}, senderBankId: ${_this.senderBankId}, amount: ${_this.amount}, status: ${_this.status}, creationDatetime: ${_this.creationDatetime})';
}


}

/// @nodoc
abstract mixin class $PaymentDtoCopyWith<$Res>  {
  factory $PaymentDtoCopyWith(PaymentDto value, $Res Function(PaymentDto) _then) = _$PaymentDtoCopyWithImpl;
@useResult
$Res call({
 String? type, String? sender,@JsonKey(name: 'sender_bank_id') int? senderBankId, num amount, String? status,@JsonKey(name: 'creation_datetime') String? creationDatetime
});




}
/// @nodoc
class _$PaymentDtoCopyWithImpl<$Res>
    implements $PaymentDtoCopyWith<$Res> {
  _$PaymentDtoCopyWithImpl(this._self, this._then);

  final PaymentDto _self;
  final $Res Function(PaymentDto) _then;

/// Create a copy of PaymentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? sender = freezed,Object? senderBankId = freezed,Object? amount = null,Object? status = freezed,Object? creationDatetime = freezed,}) {
  return _then(PaymentDto(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String?,senderBankId: freezed == senderBankId ? _self.senderBankId : senderBankId // ignore: cast_nullable_to_non_nullable
as int?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,creationDatetime: freezed == creationDatetime ? _self.creationDatetime : creationDatetime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentDto].
extension PaymentDtoPatterns on PaymentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentDto value)  $default,){
final _that = this;
switch (_that) {
case _PaymentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentDto value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type,  String? sender, @JsonKey(name: 'sender_bank_id')  int? senderBankId,  num amount,  String? status, @JsonKey(name: 'creation_datetime')  String? creationDatetime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentDto() when $default != null:
return $default(_that.type,_that.sender,_that.senderBankId,_that.amount,_that.status,_that.creationDatetime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type,  String? sender, @JsonKey(name: 'sender_bank_id')  int? senderBankId,  num amount,  String? status, @JsonKey(name: 'creation_datetime')  String? creationDatetime)  $default,) {final _that = this;
switch (_that) {
case _PaymentDto():
return $default(_that.type,_that.sender,_that.senderBankId,_that.amount,_that.status,_that.creationDatetime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type,  String? sender, @JsonKey(name: 'sender_bank_id')  int? senderBankId,  num amount,  String? status, @JsonKey(name: 'creation_datetime')  String? creationDatetime)?  $default,) {final _that = this;
switch (_that) {
case _PaymentDto() when $default != null:
return $default(_that.type,_that.sender,_that.senderBankId,_that.amount,_that.status,_that.creationDatetime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentDto extends PaymentDto {
  const _PaymentDto({this.type, this.sender, @JsonKey(name: 'sender_bank_id') this.senderBankId, this.amount = 0, this.status, @JsonKey(name: 'creation_datetime') this.creationDatetime}): super._();
  factory _PaymentDto.fromJson(Map<String, dynamic> json) => _$PaymentDtoFromJson(json);

@override final  String? type;
@override final  String? sender;
@override@JsonKey(name: 'sender_bank_id') final  int? senderBankId;
@override@JsonKey() final  num amount;
@override final  String? status;
@override@JsonKey(name: 'creation_datetime') final  String? creationDatetime;

/// Create a copy of PaymentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentDtoCopyWith<_PaymentDto> get copyWith => __$PaymentDtoCopyWithImpl<_PaymentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentDto&&(identical(other.type, type) || other.type == type)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.senderBankId, senderBankId) || other.senderBankId == senderBankId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.creationDatetime, creationDatetime) || other.creationDatetime == creationDatetime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,sender,senderBankId,amount,status,creationDatetime);
}

@override
String toString() {
    return 'PaymentDto(type: $type, sender: $sender, senderBankId: $senderBankId, amount: $amount, status: $status, creationDatetime: $creationDatetime)';
}


}

/// @nodoc
abstract mixin class _$PaymentDtoCopyWith<$Res> implements $PaymentDtoCopyWith<$Res> {
  factory _$PaymentDtoCopyWith(_PaymentDto value, $Res Function(_PaymentDto) _then) = __$PaymentDtoCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? sender,@JsonKey(name: 'sender_bank_id') int? senderBankId, num amount, String? status,@JsonKey(name: 'creation_datetime') String? creationDatetime
});




}
/// @nodoc
class __$PaymentDtoCopyWithImpl<$Res>
    implements _$PaymentDtoCopyWith<$Res> {
  __$PaymentDtoCopyWithImpl(this._self, this._then);

  final _PaymentDto _self;
  final $Res Function(_PaymentDto) _then;

/// Create a copy of PaymentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? sender = freezed,Object? senderBankId = freezed,Object? amount = null,Object? status = freezed,Object? creationDatetime = freezed,}) {
  return _then(_PaymentDto(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String?,senderBankId: freezed == senderBankId ? _self.senderBankId : senderBankId // ignore: cast_nullable_to_non_nullable
as int?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,creationDatetime: freezed == creationDatetime ? _self.creationDatetime : creationDatetime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
