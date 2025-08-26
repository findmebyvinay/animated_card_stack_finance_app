import 'package:animated_card_stack_finance/core/common/abs_normal_state.dart';
import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_bloc.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_state.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/spending_insight.dart';
import 'package:animated_card_stack_finance/features/cards/widgets/animated_spending_pie_chart.dart';
import 'package:animated_card_stack_finance/features/cards/widgets/animated_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: Offset(0, 1),
            color: Color.fromARGB(255, 29, 109, 74)
          )
        ]
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
                    color: AppColors.whiteColor,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    color:AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Transaction Items
         // Transaction Items and Insights
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Transactions
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: card.recentTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = card.recentTransactions[index];
                      return AnimatedTransactionItem(
                        transaction: transaction,
                        delay: Duration(milliseconds: index * 100),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Insights
                  BlocBuilder<CardsBloc, CardsState>(
                    builder: (context, state) {
                      final insightsState = state.inSightState;
                      if (insightsState is AbsNormalSuccessState<SpendingInsight> && insightsState.data != null) {
                        return AnimatedSpendingPieChart(insight: insightsState.data!);
                      } else if (insightsState is AbsNormalLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 20), // A
        ],
      ),
    ))]));
  }
}