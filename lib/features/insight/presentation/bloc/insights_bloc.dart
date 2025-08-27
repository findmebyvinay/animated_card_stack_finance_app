import 'package:animated_card_stack_finance/core/common/abs_normal_state.dart';
import 'package:animated_card_stack_finance/core/common/failure_state.dart';
import 'package:animated_card_stack_finance/features/insight/domain/repo/insights_repo.dart';
import 'package:animated_card_stack_finance/features/insight/presentation/bloc/insights_event.dart';
import 'package:animated_card_stack_finance/features/insight/presentation/bloc/insights_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsightsBloc extends Bloc<InsightsEvent,InsightsState>{
  final InsightsRepo _repo;

  InsightsBloc(this._repo):super(const InsightsInitial()){
    on<LoadInsightsEvent>(_onLoadInsights);
    on<LoadCategoryBreakdownEvent>(_onLoadCategoryBreakdown);
  }


  Future<void> _onLoadInsights(LoadInsightsEvent event,Emitter<InsightsState> emit)async{
    emit(state.copyWith(insightState: const AbsNormalLoadingState()));
    try{
      final insights= await _repo.generateInsights(event.card);
      final currentData= (state.insightState is AbsNormalSuccessState<InsightsData>)?
      (state.insightState as AbsNormalSuccessState<InsightsData>).data: const InsightsData();

      final updatedData= currentData!.copyWith(
        insights: insights
      );
      emit(state.copyWith(
        insightState: AbsNormalSuccessState(data:updatedData)
      ));
    }
    catch(e){
      emit(state.copyWith(
        insightState: AbsNormalFailureState(failure: Failure(message: e.toString())),
      ));
      rethrow;
    }
  }

  Future<void> _onLoadCategoryBreakdown(LoadCategoryBreakdownEvent event, Emitter<InsightsState> emit)async{
    try{
      final categoryBreakdown= await _repo.getCategoryBreakdown(event.card);
      final monthlyTrends=await _repo.getMonthlyTrends(event.card);

      final currentData= (state.insightState is AbsNormalSuccessState<InsightsData>)?
      (state.insightState as AbsNormalSuccessState<InsightsData>).data:const InsightsData();

      final updatedData= currentData!.copyWith(
        categoryBreakdown: categoryBreakdown,
        monthlyTrends: monthlyTrends
      );
      emit(state.copyWith(
        insightState: AbsNormalSuccessState(data: updatedData)
      ));
    }
    catch(e){
      emit(state.copyWith(
        insightState: AbsNormalFailureState(failure: Failure(message: e.toString()))
      ));
    }
  }
}