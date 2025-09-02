import 'dart:math';

import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/features/insight/domain/model/category_spending.dart';
import 'package:animated_card_stack_finance/features/insight/domain/model/spending_insight.dart';
import 'package:animated_card_stack_finance/features/insight/domain/repo/insights_repo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:InsightsRepo)
class InsightsRepoImpl implements InsightsRepo{
  @override
  Future<List<SpendingInsight>> generateInsights(List<CreditCard> cards)async {
    await Future.delayed(const Duration(milliseconds: 500));
    final insights=<SpendingInsight>[];
    final totalBalance= cards.fold<double>(0, (sum,card)=> sum + card.balance);
    if(totalBalance>1000000){
      insights.add(const SpendingInsight(
        id: '1', 
        title: 'High Balance Alert', 
        description: 'You have a high balance across your cards.Consider investing or savings', 
        type: InsightType.tip, 
        icon: Icons.trending_up, 
        color: Colors.amber,
        actionText: 'View Ivestment Options'
        ));
    }
    final coffeeTransactions=cards.expand(
      (card)=> card.recentTransactions
    ).where((t)=>t.category.toLowerCase().contains('coffee')).length;

    if(coffeeTransactions> 2){
      insights.add(
        SpendingInsight(
          id: '2', 
          title: 'Coffee Lover Detected', 
          description: 'You have  spent on coffee $coffeeTransactions times recently. Consider a monthly coffee budget', 
          type: InsightType.warning, 
          icon: Icons.local_cafe, 
          color: Colors.brown)
      );
    }
    insights.add(
      const SpendingInsight(
        id: '3', 
        title: 'Great Job', 
        description: 'You\' ve successfully tracked your expenses this month', 
        type: InsightType.achievement, 
        icon: Icons.star, 
        color: Colors.amber)
    );
    return insights;
  }

  @override
  Future<List<CategorySpending>> getCategoryBreakdown(CreditCard card)async {
    await Future.delayed(const Duration(milliseconds: 300));
    final categories= <String,double>{};
    final categoryMerchants= <String,Set<String>>{};

    for(final transaction in card.recentTransactions){
      categories[transaction.category]=(categories[transaction.category]?? 0)+ transaction.amount.abs();
      categoryMerchants[transaction.category]= <String>{};
      categoryMerchants[transaction.category]!.add(transaction.merchantName);
    }
    final totalSpending= categories.values.fold<double>(0, (sum,amount)=>sum + amount);
    final colors=[Colors.blue,Colors.green,Colors.orange,Colors.purple,Colors.red];
    final icons=[Icons.shopping_bag,Icons.local_cafe,Icons.movie,Icons.restaurant,Icons.local_gas_station];

    return categories.entries.map(
      (entry){
        final index= categories.keys.toList().indexOf(entry.key);
        return CategorySpending(
          category: entry.key,
           amount: entry.value, 
           percentage: (entry.value/totalSpending)*100, 
           color: colors[index % colors.length], 
           icon: icons[index % icons.length], 
           topMerchants: categoryMerchants[entry.key]!.take(3).toList());
      }
    ).toList()..sort((a,b)=>b.amount.compareTo(a.amount));
  }

  @override
  Future<Map<String, double>> getMonthlyTrends(CreditCard card)async {
  await Future.delayed(const Duration(milliseconds: 200));
   final random= Random();

   return{
    'Jan':15000+ random.nextDouble()*5000,
    'Feb':18000+ random.nextDouble()*4000,
    'Mar':16000 + random.nextDouble()*6000,
    'Apr': 17000+ random.nextDouble()*3000,
    'May':18000+ random.nextDouble()*5000,
    'Jun':13000+ random.nextDouble()*3000,
    'July':19000+ random.nextDouble()*3000, 
   };
  }

}