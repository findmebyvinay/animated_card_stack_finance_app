// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_card_stack_finance/core/common/abs_normal_state.dart';
import 'package:animated_card_stack_finance/features/insight/domain/model/category_spending.dart';
import 'package:animated_card_stack_finance/features/insight/domain/model/spending_insight.dart';
import 'package:equatable/equatable.dart';

class InsightsData {
  final List<SpendingInsight> insights;
  final List<CategorySpending> categoryBreakdown;
  final Map<String,double> monthlyTrends;

  const InsightsData(
    {this.insights= const [],
    this.categoryBreakdown= const [],
    this.monthlyTrends= const {},}
  );

  InsightsData copyWith({
  List<SpendingInsight>? insights,
  List<CategorySpending>?categoryBreakdown,
  Map<String,double>? monthlyTrends,
  }){
   return InsightsData(
    insights: insights ?? this.insights,
    categoryBreakdown: categoryBreakdown ?? this.categoryBreakdown,
    monthlyTrends: monthlyTrends ?? this.monthlyTrends,
   );
  }
}


sealed class InsightsState extends Equatable {
  final AbsNormalState<InsightsData> insightState;
  const InsightsState({required this.insightState});

InsightsState copyWith({AbsNormalState<InsightsData> ? insightState}){
  return InsightsStateImpl(insightState: insightState ?? this.insightState);
}
@override
List<Object?> get props=>[insightState];

}


final class InsightsStateImpl extends InsightsState{
  const InsightsStateImpl({required super.insightState});
  @override
  InsightsState copyWith({AbsNormalState<InsightsData>? insightState}){
    return InsightsStateImpl(insightState: insightState ?? this.insightState);
  }
}

final class InsightsInitial extends InsightsState{
  const InsightsInitial():super(insightState:const AbsNormalInitialState<InsightsData>());
}