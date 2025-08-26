import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/core/constants/enum.dart';
import 'package:animated_card_stack_finance/core/services/get_it/service_locator.dart';
import 'package:animated_card_stack_finance/core/services/spending_insights_services.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_bloc.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_event.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_state.dart';
import 'package:animated_card_stack_finance/features/cards/widgets/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardStackScreen extends StatelessWidget {
  const CardStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardsBloc(inSightProvider: getIt<SpendingInsightsServices>())..add(LoadCardsEvent()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              // Header
               Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CARDS DETAILS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'monospace'
                      ),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.add, color: Colors.white, size: 28)
                    ),
                  ],
                ),
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
