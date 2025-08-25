// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String merchantName;
  final double amount;
  final DateTime date;
  final String category;
  final IconData icon;

  const Transaction(
    {
    required this.id,
    required this.merchantName,
    required this.amount,
    required this.date,
    required this.category,
    required this.icon,
    }
  );
}
