// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';

class CardsData extends Equatable {
  final List<CreditCard>? cards;
  final String? selectedCardId;
  final Set<String>? flippedCard;
const  CardsData(
    {
    this.cards,
    this.selectedCardId,
    this.flippedCard,
    }
  );

CardsData copyWith({
  List<CreditCard>? cards,
  String? selectedCardId,
  Set<String>? flippedCard,
}){

  return CardsData(
    cards: cards ?? this.cards,
    selectedCardId: selectedCardId ?? this.selectedCardId,
    flippedCard: flippedCard ?? this.flippedCard,
    );
}

  @override
  List<Object?> get props=> [
    cards,
    selectedCardId,
    flippedCard
  ];
}
