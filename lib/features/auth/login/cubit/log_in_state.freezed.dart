// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_in_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogInState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogInState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogInState()';
}


}

/// @nodoc
class $LogInStateCopyWith<$Res>  {
$LogInStateCopyWith(LogInState _, $Res Function(LogInState) __);
}


/// Adds pattern-matching-related methods to [LogInState].
extension LogInStatePatterns on LogInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( LogInLoading value)?  logInLoading,TResult Function( LogInSuccess value)?  logInSuccess,TResult Function( LogInFailure value)?  logInFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case LogInLoading() when logInLoading != null:
return logInLoading(_that);case LogInSuccess() when logInSuccess != null:
return logInSuccess(_that);case LogInFailure() when logInFailure != null:
return logInFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( LogInLoading value)  logInLoading,required TResult Function( LogInSuccess value)  logInSuccess,required TResult Function( LogInFailure value)  logInFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case LogInLoading():
return logInLoading(_that);case LogInSuccess():
return logInSuccess(_that);case LogInFailure():
return logInFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( LogInLoading value)?  logInLoading,TResult? Function( LogInSuccess value)?  logInSuccess,TResult? Function( LogInFailure value)?  logInFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case LogInLoading() when logInLoading != null:
return logInLoading(_that);case LogInSuccess() when logInSuccess != null:
return logInSuccess(_that);case LogInFailure() when logInFailure != null:
return logInFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  logInLoading,TResult Function()?  logInSuccess,TResult Function( String error)?  logInFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case LogInLoading() when logInLoading != null:
return logInLoading();case LogInSuccess() when logInSuccess != null:
return logInSuccess();case LogInFailure() when logInFailure != null:
return logInFailure(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  logInLoading,required TResult Function()  logInSuccess,required TResult Function( String error)  logInFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case LogInLoading():
return logInLoading();case LogInSuccess():
return logInSuccess();case LogInFailure():
return logInFailure(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  logInLoading,TResult? Function()?  logInSuccess,TResult? Function( String error)?  logInFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case LogInLoading() when logInLoading != null:
return logInLoading();case LogInSuccess() when logInSuccess != null:
return logInSuccess();case LogInFailure() when logInFailure != null:
return logInFailure(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LogInState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogInState.initial()';
}


}




/// @nodoc


class LogInLoading implements LogInState {
  const LogInLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogInLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogInState.logInLoading()';
}


}




/// @nodoc


class LogInSuccess implements LogInState {
  const LogInSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogInSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogInState.logInSuccess()';
}


}




/// @nodoc


class LogInFailure implements LogInState {
  const LogInFailure({required this.error});
  

 final  String error;

/// Create a copy of LogInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogInFailureCopyWith<LogInFailure> get copyWith => _$LogInFailureCopyWithImpl<LogInFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogInFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'LogInState.logInFailure(error: $error)';
}


}

/// @nodoc
abstract mixin class $LogInFailureCopyWith<$Res> implements $LogInStateCopyWith<$Res> {
  factory $LogInFailureCopyWith(LogInFailure value, $Res Function(LogInFailure) _then) = _$LogInFailureCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$LogInFailureCopyWithImpl<$Res>
    implements $LogInFailureCopyWith<$Res> {
  _$LogInFailureCopyWithImpl(this._self, this._then);

  final LogInFailure _self;
  final $Res Function(LogInFailure) _then;

/// Create a copy of LogInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(LogInFailure(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
