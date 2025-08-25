import 'package:animated_card_stack_finance/core/constants/typedef.dart';

abstract class CardsRepo {
  Future<DynamicResponse> fetchCards();
}