import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';

sealed class InsightsEvent {}

class LoadInsightsEvent extends InsightsEvent{
  final List<CreditCard> card;
  LoadInsightsEvent({required this.card});
}

class LoadCategoryBreakdownEvent extends InsightsEvent{
  final CreditCard card;
  LoadCategoryBreakdownEvent({required this.card});
}