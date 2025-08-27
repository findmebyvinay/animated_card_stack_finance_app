import 'dart:math';
import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/features/insight/domain/model/category_spending.dart';
import 'package:flutter/material.dart';

class CategoryChart extends StatefulWidget {
  final List<CategorySpending> categories;
  
  const CategoryChart({super.key, required this.categories});

  @override
  State<CategoryChart> createState() => _CategoryChartState();
}

class _CategoryChartState extends State<CategoryChart>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _animations = List.generate(
      widget.categories.length,
      (index) => Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          index/widget.categories.length,
          (0.8+index/widget.categories.length).clamp(0, 1),
          curve: Curves.elasticOut,
        ),
      )),
    );
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: Offset(0, 5)
          )
        ]
      ),
      child: Column(
        children: [
          // Pie Chart
          SizedBox(
            height: 200,
            child: CustomPaint(
              size: const Size(200, 200),
              painter: PieChartPainter(
                categories: widget.categories,
                animations: _animations,
                selectedIndex: _selectedIndex,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Legend
          ...widget.categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Transform.scale(
                  scale: _animations[index].value,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _selectedIndex = _selectedIndex == index ? -1 : index;
                    }),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? category.color.withValues(alpha: 0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: category.color.withValues(alpha: 0.3),
                          width: _selectedIndex == index ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            category.icon,
                            color: category.color,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Rs${category.amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${category.percentage.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: category.color,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          // ignore: unnecessary_to_list_in_spreads
          }).toList(),
        ],
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<CategorySpending> categories;
  final List<Animation<double>> animations;
  final int selectedIndex;
  
  PieChartPainter({
    required this.categories,
    required this.animations,
    required this.selectedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 20;
    
    double startAngle = -pi / 2;
    
    for (int i = 0; i < categories.length; i++) {
      final category = categories[i];
      final sweepAngle = (category.percentage / 100) * 2 * pi * animations[i].value;
      final isSelected = selectedIndex == i;
      
      final paint = Paint()
        ..color = category.color.withValues(alpha: 0.8)
        ..style = PaintingStyle.fill;
      
      final strokePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      
      // Draw pie slice with offset if selected
      final sliceCenter = isSelected ? 
        Offset(
          center.dx + cos(startAngle + sweepAngle / 2) * 10,
          center.dy + sin(startAngle + sweepAngle / 2) * 10,
        ) : center;
      
      final rect = Rect.fromCenter(
        center: sliceCenter,
        width: radius * 2,
        height: radius * 2,
      );
      
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      canvas.drawArc(rect, startAngle, sweepAngle, true, strokePaint);
      
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}