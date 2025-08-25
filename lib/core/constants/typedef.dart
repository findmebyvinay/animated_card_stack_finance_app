import 'package:animated_card_stack_finance/core/common/failure_state.dart';
import 'package:dartz/dartz.dart';



typedef GestureTapCallback = void Function();
typedef VoidCallback = void Function()?;
typedef VoidCallbackWithValue<T> = void Function(T? value)?;

typedef FutureDynamicResponse = Future<Either<dynamic, Failure>>;
typedef DynamicResponse = Either<dynamic, Failure>;

typedef FutureListMap = Future<List<Map<String, dynamic>>>;
typedef ListMap = List<Map<String, dynamic>>;
typedef FutureMap = Future<Map<String, dynamic>>;
typedef FutureString = Future<String>;
typedef FutureBool = Future<bool>;
typedef FutureInt = Future<int>;
typedef FutureDouble = Future<double>;
typedef FutureVoid = Future<void>;
