// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class SpendingCategory extends Equatable {
  final String name;
  final double amount;
  final double percentage;
  final IconData icon;

  const SpendingCategory(
  {
    required this.name,
    required this.amount,
    required this.percentage,
    required this.icon,
  }
  );

  @override
  List<Object> get props=> [
    name,
    amount,
    percentage,
    icon,
  ];
  }


class SpendingInsight extends Equatable {
    final List<SpendingCategory> categories;
    final double totalSpent;
    final double projectedMonthlySpend;
    final String insightTip;

  const SpendingInsight(
  {
      required this.categories,
    required this.totalSpent,
    required this.projectedMonthlySpend,
    required this.insightTip,
  }
  );

  @override
  List<Object> get props=>[
    categories,
    totalSpent,
    projectedMonthlySpend,
    insightTip,
  ];
  }
