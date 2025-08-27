import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/features/insight/domain/model/category_spending.dart';
import 'package:animated_card_stack_finance/features/insight/domain/model/spending_insight.dart';

abstract class InsightsRepo {
  Future<List<SpendingInsight>> generateInsights(List<CreditCard> cards);
  Future<List<CategorySpending>>getCategoryBreakdown(CreditCard card);
  Future<Map<String,double>> getMonthlyTrends(CreditCard card);
}


