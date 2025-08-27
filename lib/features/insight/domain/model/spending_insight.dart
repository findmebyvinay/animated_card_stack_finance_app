// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

enum InsightType{
  warning,
  tip,
  achievement,
  trend
}

class SpendingInsight {
  final String id;
  final String title;
  final String description;
  final InsightType type;
  final IconData icon;
  final Color color;
  final double? percentage;
  final String? actionText;

  const SpendingInsight(
   {
     required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.icon,
    required this.color,
    this.percentage,
    this.actionText,
   }
  );
}
