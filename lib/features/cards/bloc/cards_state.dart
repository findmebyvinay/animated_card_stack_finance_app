import 'package:animated_card_stack_finance/core/common/abs_normal_state.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/cards_data.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/spending_insight.dart';
import 'package:equatable/equatable.dart';

sealed class CardsState extends Equatable{
  final  AbsNormalState<CardsData> cardState;
  final AbsNormalState<SpendingInsight> inSightState;
  const CardsState({required this.cardState, required this.inSightState});

  CardsState copyWith({AbsNormalState<CardsData>? cardState, AbsNormalState<SpendingInsight>? inSightState}){
    return CardsStateImpl(cardState: cardState ?? this.cardState,
    inSightState:inSightState ?? this.inSightState,

    );
  }
@override
List<Object?> get props=>[cardState];
}

final class CardsStateImpl extends CardsState{
  const CardsStateImpl({required super.cardState,required super.inSightState});

  @override
  CardsState copyWith({AbsNormalState<CardsData>? cardState,AbsNormalState<SpendingInsight>? inSightState}){
    return CardsStateImpl(
      cardState: cardState ?? this.cardState,
      inSightState: inSightState ?? this.inSightState,
      );
  }
  @override
  List<Object?> get props=>[cardState];
}

final class CardsInitial extends CardsState{
  const CardsInitial():super(cardState: const AbsNormalInitialState<CardsData>(),inSightState:const AbsNormalInitialState<SpendingInsight>());
}