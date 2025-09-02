import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/core/constants/enum.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/bloc/cards_event.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/bloc/cards_state.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/widgets/card_stack_widget.dart';
import 'package:animated_card_stack_finance/features/insight/presentation/screen/insights_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardStackScreen extends StatelessWidget {
  const CardStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardsBloc()..add(LoadCardsEvent()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<CardsBloc, CardsState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'CARDS DETAILS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace'
                          ),
                        ),
                        Row(
                          children: [
                            // INSIGHTS BUTTON - NEW
                            IconButton(
                              onPressed: () {
                                final cardsState = state.cardState;
                                if (cardsState.absNormalStatus == AbsNormalStatus.SUCCESS &&
                                    cardsState.data != null) {
                                  final data = cardsState.data!;
                                  
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InsightsScreen(
                                        cards: data.cards!,
                                        selectedCard: data.cards!.firstWhere(
                                          (card) => card.id == data.selectedCardId,
                                          orElse: () => data.cards!.first,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  // Show a message if cards haven't loaded yet
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please wait for cards to load'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.analytics, color: Colors.white, size: 28),
                              tooltip: 'View Insights',
                            ),
                            // EXISTING ADD BUTTON
                            IconButton(
                              onPressed: (){
                                // Your existing add functionality here
                              },
                              icon: const Icon(Icons.add, color: Colors.white, size: 28),
                              tooltip: 'Add Card',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Card Stack
              Expanded(
                child: BlocBuilder<CardsBloc, CardsState>(
                  builder: (context, state) {
                    final cardsState = state.cardState;
                    if (cardsState.absNormalStatus == AbsNormalStatus.SUCCESS &&
                        cardsState.data != null) {
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
      ),
    );
  }
}
