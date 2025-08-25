import 'package:animated_card_stack_finance/core/common/abs_normal_state.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/cards_data.dart';
import 'package:equatable/equatable.dart';

sealed class CardsState extends Equatable{
  final  AbsNormalState<CardsData> cardState;
  const CardsState({required this.cardState});

  CardsState copyWith({AbsNormalState<CardsData>? cardState}){
    return CardsStateImpl(cardState: cardState ?? this.cardState);
  }
@override
List<Object?> get props=>[cardState];
}

final class CardsStateImpl extends CardsState{
  const CardsStateImpl({required super.cardState});

  @override
  CardsState copyWith({AbsNormalState<CardsData>? cardState}){
    return CardsStateImpl(
      cardState: cardState ?? this.cardState);
  }
  @override
  List<Object?> get props=>[cardState];
}

final class CardsInitial extends CardsState{
  const CardsInitial():super(cardState: const AbsNormalInitialState<CardsData>());
}