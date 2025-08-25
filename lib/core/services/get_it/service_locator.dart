


import 'package:animated_card_stack_finance/core/services/get_it/service_locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
  usesNullSafety: true, // default
)
Future<void> configureDependencies() async => getIt.init();
