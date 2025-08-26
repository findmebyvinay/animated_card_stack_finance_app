import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/spending_insight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

abstract class ISpendingInsightsProvider{
  SpendingInsight computeInsights(CreditCard card);
}

@lazySingleton
@injectable
class SpendingInsightsServices implements ISpendingInsightsProvider{
 @override
  SpendingInsight computeInsights(CreditCard card) {
    final transactions= card.recentTransactions.where(
      (t)=> t.amount<0
    ).toList();
    final totalSpent= transactions.fold(0.0, (sum,t)=>sum+t.amount.abs());

    //aggregate by category
    final categoryMap= <String,double>{};
    for(var t in transactions){
      categoryMap.update(t.category, (value)=>value+ t.amount.abs(),ifAbsent: () => t.amount.abs(),);
    }
    final categories= categoryMap.entries.map(
      (entry){
       return SpendingCategory(
        name: entry.key, 
        amount: entry.value, 
        percentage: totalSpent>0 ? (entry.value/totalSpent)*100:0, 
        icon:_getIconCategory(entry.key) );
      }
    ).toList();

    final now= DateTime.now();
    final daysInMonth= DateTime(now.year, now.month+1,0).day;
    final daysPassed= now.day;
    final avgDaily= totalSpent/(daysPassed>0 ? daysPassed:1);
    final projected=totalSpent + (avgDaily* (daysInMonth-daysPassed));

    final topCategory= categories.isNotEmpty? categories.reduce((a,b)=>a.amount> b.amount?a:b):null;
    final tip= topCategory!=null?
    'You are Spending a lot on ${topCategory.name}. consider setting a budget of Rs${topCategory.amount.toStringAsFixed(0)} this month':'No spending data yet start tracking';

    return SpendingInsight(
      categories: categories, 
      totalSpent: totalSpent, 
      projectedMonthlySpend: projected,
       insightTip:tip); 
  } 

  IconData _getIconCategory(String category){
    switch (category.toLowerCase()){
      case 'coffee':
      return Icons.local_cafe;

      case 'shopping':
      return Icons.shopping_bag;

      case 'entertainment':
      return Icons.movie;

      case 'business':
      return Icons.business;

      case 'grocery':
      return Icons.shopping_basket;
      default:
      return Icons.category; 

    }
  }
}