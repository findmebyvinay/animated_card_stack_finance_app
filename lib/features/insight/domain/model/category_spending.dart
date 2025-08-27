// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategorySpending {
  final String category;
  final double amount;
  final double percentage;
  final Color color;
  final IconData icon;
  final List<String> topMerchants;

  const CategorySpending(
 {
     required this.category,
    required this.amount,
    required this.percentage,
    required this.color,
    required this.icon,
    required this.topMerchants,
 }
  );
}
