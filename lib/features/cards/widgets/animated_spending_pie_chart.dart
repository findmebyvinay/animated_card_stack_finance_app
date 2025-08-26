import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/spending_insight.dart';

class AnimatedSpendingPieChart extends StatefulWidget {
  final SpendingInsight insight;

  const AnimatedSpendingPieChart({super.key, required this.insight});

  @override
  State<AnimatedSpendingPieChart> createState() => _AnimatedSpendingPieChartState();
}

class _AnimatedSpendingPieChartState extends State<AnimatedSpendingPieChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Spending Insights',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.whiteColor),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200, // Explicit height for pie chart
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sectionsSpace: 2,
                    centerSpaceRadius: 40 * _animation.value,
                    sections: widget.insight.categories.asMap().entries.map((entry) {
                      final i = entry.key;
                      final cat = entry.value;
                      final isTouched = i == touchedIndex;
                      final fontSize = isTouched ? 16.0 : 12.0;
                      final radius = isTouched ? 60.0 : 50.0;
                      return PieChartSectionData(
                        color: _getColorForIndex(i),
                        value: cat.percentage,
                        title: '${cat.percentage.toStringAsFixed(1)}%',
                        radius: radius * _animation.value,
                        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: widget.insight.categories.map((cat) {
                  return Chip(
                    avatar: Icon(cat.icon, color: AppColors.whiteColor),
                    label: Text('${cat.name}: Rs.${cat.amount.toStringAsFixed(2)}'),
                    backgroundColor: AppColors.secondaryTeal,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text('Total Spent: Rs.${widget.insight.totalSpent.toStringAsFixed(2)}',
                  style: const TextStyle(color: AppColors.whiteColor)),
              Text('Projected Monthly: Rs.${widget.insight.projectedMonthlySpend.toStringAsFixed(2)}',
                  style: const TextStyle(color: AppColors.whiteColor)),
              Text('AI Tip: ${widget.insight.insightTip}',
                  style: const TextStyle(color: AppColors.whiteColor, fontStyle: FontStyle.italic)),
            ],
          ),
        );
      },
    );
  }

  Color _getColorForIndex(int index) {
    final colors = [Colors.blue, Colors.green, Colors.red, Colors.orange, Colors.purple];
    return colors[index % colors.length];
  }
}