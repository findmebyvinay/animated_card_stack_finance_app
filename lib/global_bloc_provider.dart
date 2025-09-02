import 'package:animated_card_stack_finance/core/bloc/internet_cubit.dart';
import 'package:animated_card_stack_finance/core/bloc/language_cubit.dart';
import 'package:animated_card_stack_finance/core/services/get_it/service_locator.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> _coreBlocProvider(){
  return [
    BlocProvider<InternetCubit>.value(value: getIt<InternetCubit>()),
    BlocProvider<LanguageCubit>.value(value: getIt<LanguageCubit>()),
  ];
}

List<SingleChildWidget> _featureBlocProvider(){
  return[
    BlocProvider<CardsBloc>.value(value: getIt<CardsBloc>()),
  ];
}

List<SingleChildWidget> globalBlocProvider(){
  return [
 ..._coreBlocProvider(),
 ..._featureBlocProvider(),
  ];
}