import 'dart:developer';

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

  CardsBloc():super( CardsInitial()){
    on<LoadCardsEvent>(_onLoadCardsEvent);
    on<SelectCardEvent> (_onSelectCardEvent);
    on<FlipCardEvent>(_onFlipCardEvent);
    on<CardsResetEvent>((event, emit) => CardsInitial(),);
  }

  Future<void> _onLoadCardsEvent(LoadCardsEvent event,Emitter<CardsState>emit)async{
    emit(state.copyWith(
      cardState: AbsNormalLoadingState()
    ));
    try{
        await Future.delayed(Duration(milliseconds: 800));
        final cards= _generateMockCards();
        final cardsData= CardsData(cards: cards);
        log('Cards loaded ');
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
      log('card selected');
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
      log('card id is removed');
      flippedCards.remove(event.cardId);
    }
    else{
      log('card id has been added');
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
        holderName: 'Vinay Thapa',
        expiryDate: '12/25',
        cvv: '123',
        balance: 54520.50,
        type: CardType.visa,
        primaryColor: const Color.fromARGB(255, 8, 127, 20),
        secondaryColor: const Color.fromARGB(255, 27, 166, 57),
        recentTransactions: [
          Transaction(
            id: 't1',
            merchantName: 'Himalayan Java',
            amount: -450.50,
            date: DateTime.now().subtract(const Duration(hours: 2)),
            category: 'Coffee',
            icon: Icons.local_cafe,
          ),
           Transaction(
            id: 't3',
            merchantName: 'Jeeve Nepal',
            amount: -1500,
            date: DateTime.now().subtract(const Duration(days: 1)),
            category: 'Shopping',
            icon: Icons.shopping_bag,
          ),
           Transaction(
            id: 't4',
            merchantName: 'Big Mart',
            amount: -5000,
            date: DateTime.now().subtract(const Duration(days: 1)),
            category: 'Grocery',
            icon: Icons.shopping_bag,
          ), Transaction(
            id: 't5',
            merchantName: 'Nepal Electricity',
            amount: -3000,
            date: DateTime.now().subtract(const Duration(days: 1)),
            category: 'Electricity Bill',
            icon: Icons.receipt,
          ),
          
        ],
      ),
      CreditCard(
        id: '2',
        cardNumber: '**** **** **** 5678',
        holderName: 'Vinay Thapa',
        expiryDate: '09/26',
        cvv: '456',
        balance: 12750.25,
        type: CardType.mastercard,
        primaryColor: const Color.fromARGB(255, 193, 23, 23),
        secondaryColor: const Color.fromARGB(255, 158, 61, 23),
        recentTransactions: [
          Transaction(
            id: 't6',
            merchantName: 'Netflix',
            amount: -1000,
            date: DateTime.now().subtract(const Duration(days: 2)),
            category: 'Entertainment',
            icon: Icons.movie,
          ),
          Transaction(
            id: 't7',
            merchantName: 'Samsung',
            amount: -30000,
            date: DateTime.now().subtract(const Duration(days: 2)),
            category: 'Home appliance',
            icon: Icons.shopping_cart,
          ),
          Transaction(
            id: 't8',
            merchantName: 'Spotify',
            amount: -1000,
            date: DateTime.now().subtract(const Duration(days: 2)),
            category: 'Song',
            icon: Icons.movie,
          ),
        ],
      ),
      CreditCard(
        id: '3',
        cardNumber: '**** **** **** 9012',
        holderName: 'Vinay Thapa',
        expiryDate: '03/27',
        cvv: '789',
        balance: 289000.75,
        type: CardType.dollarcard,
        primaryColor: const Color.fromARGB(255, 8, 8, 8),
        secondaryColor: const Color.fromARGB(255, 41, 43, 43),
        recentTransactions: [
          Transaction(
            id: 't9',
            merchantName: 'ABC Enterprise',
            amount: 9000,
            date: DateTime.now().subtract(const Duration(days: 3)),
            category: 'Business',
            icon: Icons.money,
          ),
            Transaction(
            id: 't11',
            merchantName: 'Anta Shoes',
            amount: -9000,
            date: DateTime.now().subtract(const Duration(days: 3)),
            category: 'shopping',
            icon: Icons.sports_basketball_rounded,
          ),
          Transaction(
            id: '12',
            merchantName: 'Amazon',
            amount: -10000,
            date: DateTime.now().subtract(const Duration(days: 2)),
            category: 'Camera',
            icon: Icons.camera,
          ),
        ],
      ),
    ];
  }