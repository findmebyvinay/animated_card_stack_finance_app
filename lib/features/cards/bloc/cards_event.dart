sealed class CardsEvent {}
class LoadCardsEvent extends CardsEvent{}
class SelectCardEvent extends CardsEvent{
  final String cardId;
  SelectCardEvent({required this.cardId});
}
class FlipCardEvent extends CardsEvent{
  final String cardId;
  FlipCardEvent(this.cardId);
}
class ComputeInsights extends CardsEvent{
  final String cardId;
  ComputeInsights(this.cardId);
  
}
 final class CardsResetEvent extends CardsEvent{}

 