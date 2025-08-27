import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/core/constants/enum.dart';
import 'package:animated_card_stack_finance/core/services/get_it/service_locator.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/features/insight/domain/repo/insights_repo.dart';
import 'package:animated_card_stack_finance/features/insight/presentation/bloc/insights_bloc.dart';
import 'package:animated_card_stack_finance/features/insight/presentation/bloc/insights_event.dart';
import 'package:animated_card_stack_finance/features/insight/presentation/bloc/insights_state.dart';
import 'package:animated_card_stack_finance/features/insight/presentation/widgets/category_chart.dart';
import 'package:animated_card_stack_finance/features/insight/presentation/widgets/insights_card.dart';
import 'package:animated_card_stack_finance/features/insight/presentation/widgets/monthly_trends_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsightsScreen extends StatelessWidget {
  final List<CreditCard> cards;
  final CreditCard selectedCard;
  const InsightsScreen({super.key, required this.cards, required this.selectedCard});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> InsightsBloc(getIt<InsightsRepo>())..add(LoadInsightsEvent(card: cards))..add(LoadCategoryBreakdownEvent(card: selectedCard)),
    child: Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation: 0,
        title: const Text('Smart Insights',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: BlocBuilder<InsightsBloc,InsightsState>(
        builder: (context,state){
        final insightState= state.insightState;
        if(insightState.absNormalStatus== AbsNormalStatus.SUCCESS && insightState.data!=null){
          final data= insightState.data!;
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  _buildSectionTitle('Personal Insights'),
                  const SizedBox(height: 16,),
                  ...data.insights.map((insight)=>InsightCard(insight: insight,)),

                  const SizedBox(height: 32,),
                  _buildSectionTitle('Spending by Category'),
                  const SizedBox(height: 16,),
                  if(data.categoryBreakdown.isNotEmpty) CategoryChart(categories: data.categoryBreakdown),

                  const SizedBox(height: 32,),
                  _buildSectionTitle('Monthly Trends'),
                  const SizedBox(height: 16,),
                  if(data.monthlyTrends.isNotEmpty) MonthlyTrendsChart(trends: data.monthlyTrends),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryTeal),
          ),
        );

        }),
    ),
    );
  }

  Widget _buildSectionTitle(String title){
    return Text(
      title,
      style: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold
      ),
    );
  }
}