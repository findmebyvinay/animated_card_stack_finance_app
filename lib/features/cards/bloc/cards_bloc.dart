import 'package:animated_card_stack_finance/core/common/abs_normal_state.dart';
import 'package:animated_card_stack_finance/core/common/failure_state.dart';
import 'package:animated_card_stack_finance/core/enums/card_type.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_event.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_state.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/cards_data.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CardsBloc extends Bloc<CardsEvent,CardsState> {
  CardsBloc():super(const CardsInitial()){
    on<LoadCardsEvent>(_onLoadCardsEvent);
    on<SelectCardEvent> (_onSelectCardEvent);
    on<FlipCardEvent>(_onFlipCardEvent);
    on<CardsResetEvent>((event, emit) => AbsNormalInitialState<CardsData>(),);
  }

  Future<void> _onLoadCardsEvent(LoadCardsEvent event,Emitter<CardsState>emit)async{
    emit(state.copyWith(
      cardState: AbsNormalLoadingState()
    ));
    try{
        await Future.delayed(Duration(milliseconds: 800));
        final cards= _generateMockCards();
        final cardsData= CardsData(cards: cards);
        emit(state.copyWith(
          cardState: AbsNormalSuccessState<CardsData>(data: cardsData)
        ));
      
    }
    catch(e){
      emit(state.copyWith(
        cardState: AbsNormalFailureState(failure: Failure(message: e.toString()))));
    }
  }

  Future<void>_onSelectCardEvent(SelectCardEvent event,Emitter<CardsState> emit)async{
    final currentState= state.cardState;
    if(currentState is AbsNormalSuccessState<CardsData> && currentState.data !=null){
      final updatedData=currentState.data?.copyWith(selectedCardId: event.cardId);
      emit(state.copyWith(
        cardState: AbsNormalSuccessState<CardsData>(data: updatedData!)
      ));
    }
  }

  Future<void> _onFlipCardEvent(FlipCardEvent event,Emitter<CardsState> emit)async{
    final currentState= state.cardState;
    if(currentState is AbsNormalSuccessState<CardsData> && currentState.data!=null){
      final currentData=currentState.data;
    final flippedCards= Set<String>.from(currentData!.flippedCard);
    if(flippedCards.contains(event.cardId)){
      flippedCards.remove(event.cardId);
    }
    else{
      flippedCards.add(event.cardId);
    }
    final updatedData= currentData.copyWith(flippedCard: flippedCards);
    emit(state.copyWith(
      cardState: AbsNormalSuccessState<CardsData>(data: updatedData)
    ));
    }
  }
} 
  List<CreditCard> _generateMockCards() {
    return [
      CreditCard(
        id: '1',
        cardNumber: '**** **** **** 1234',
        holderName: 'John Doe',
        expiryDate: '12/25',
        cvv: '123',
        balance: 5420.50,
        type: CardType.visa,
        primaryColor: const Color(0xFF6C63FF),
        secondaryColor: const Color(0xFF4ECDC4),
        recentTransactions: [
          Transaction(
            id: 't1',
            merchantName: 'Starbucks',
            amount: -4.50,
            date: DateTime.now().subtract(const Duration(hours: 2)),
            category: 'Food & Dining',
            icon: Icons.local_cafe,
          ),
          Transaction(
            id: 't2',
            merchantName: 'Amazon',
            amount: -89.99,
            date: DateTime.now().subtract(const Duration(days: 1)),
            category: 'Shopping',
            icon: Icons.shopping_bag,
          ),
        ],
      ),
      CreditCard(
        id: '2',
        cardNumber: '**** **** **** 5678',
        holderName: 'Jane Smith',
        expiryDate: '09/26',
        cvv: '456',
        balance: 12750.25,
        type: CardType.mastercard,
        primaryColor: const Color(0xFFFF6B6B),
        secondaryColor: const Color(0xFFFFE66D),
        recentTransactions: [
          Transaction(
            id: 't3',
            merchantName: 'Netflix',
            amount: -15.99,
            date: DateTime.now().subtract(const Duration(days: 2)),
            category: 'Entertainment',
            icon: Icons.movie,
          ),
        ],
      ),
      CreditCard(
        id: '3',
        cardNumber: '**** **** **** 9012',
        holderName: 'Mike Johnson',
        expiryDate: '03/27',
        cvv: '789',
        balance: 2890.75,
        type: CardType.amex,
        primaryColor: const Color(0xFF4ECDC4),
        secondaryColor: const Color(0xFF45B7D1),
        recentTransactions: [
          Transaction(
            id: 't4',
            merchantName: 'Shell',
            amount: -65.40,
            date: DateTime.now().subtract(const Duration(days: 3)),
            category: 'Gas',
            icon: Icons.local_gas_station,
          ),
        ],
      ),
    ];
  }