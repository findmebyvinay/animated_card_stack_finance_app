import 'package:animated_card_stack_finance/core/constants/enum.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_bloc.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_state.dart';
import 'package:animated_card_stack_finance/features/cards/widgets/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardStackScreen extends StatelessWidget {
  const CardStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Cards',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),
            
            // Card Stack
            Expanded(
              child: BlocBuilder<CardsBloc, CardsState>(
                builder: (context, state) {
                  final cardsState = state.cardState;
                  
                  if (cardsState.absNormalStatus == AbsNormalStatus.LOADING) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  
                  if (cardsState.absNormalStatus == AbsNormalStatus.ERROR) {
                    return Center(
                      child: Text(
                        cardsState.failure?.message ?? 'An error occurred',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  
                  if (cardsState.absNormalStatus == AbsNormalStatus.SUCCESS && cardsState.data != null) {
                    final data = cardsState.data!;
                    return CardStackWidget(
                      cards: data.cards!,
                      selectedCardId: data.selectedCardId,
                      flippedCards: data.flippedCard,
                    );
                  }
                  
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}