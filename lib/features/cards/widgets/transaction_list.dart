import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/features/cards/widgets/animated_transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final CreditCard card;

  const TransactionList({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    color: card.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Transaction Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: card.recentTransactions.length,
              itemBuilder: (context, index) {
                final transaction = card.recentTransactions[index];
                return AnimatedTransactionItem(
                  transaction: transaction,
                  delay: Duration(milliseconds: index * 100),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}