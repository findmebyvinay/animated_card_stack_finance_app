import 'package:flutter/material.dart';
import 'dart:math';

class MonthlyTrendsChart extends StatefulWidget {
  final Map<String, double> trends;
  
  const MonthlyTrendsChart({super.key, required this.trends});

  @override
  State<MonthlyTrendsChart> createState() => _MonthlyTrendsChartState();
}

class _MonthlyTrendsChartState extends State<MonthlyTrendsChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0, 1.0,curve:Curves.easeInOutCubic),
    ));
    
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
        color:  const Color.fromARGB(255, 46, 106, 80),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 112, 154, 128),
            offset: Offset(0, 4),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        children: [
          // Chart
          SizedBox(
            height: 200,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(double.infinity, 200),
                  painter: LineChartPainter(
                    trends: widget.trends,
                    progress: _animation.value,
                    selectedIndex: _selectedIndex,
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Month indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.trends.keys.toList().asMap().entries.map((entry) {
              final index = entry.key;
              final month = entry.value;
              final amount = widget.trends[month]!;
              final isSelected = _selectedIndex == index;
              
              return GestureDetector(
                onTap: () => setState(() {
                  _selectedIndex = _selectedIndex == index ? null : index;
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? Colors.blue.withValues(alpha: 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        month,
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isSelected)
                        Text(
                          'Rs${amount.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final Map<String, double> trends;
  final double progress;
  final int? selectedIndex;
  
  LineChartPainter({
    required this.trends,
    required this.progress,
    this.selectedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (trends.isEmpty) return;
    
    final values = trends.values.toList();
    final maxValue = values.reduce(max);
    final minValue = values.reduce(min);
    final range = maxValue - minValue;
    
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blue.withValues(alpha: 0.3),
          Colors.blue.withValues(alpha: 0.3),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    
    final path = Path();
    final fillPath = Path();
    
    final stepWidth = size.width / (values.length - 1);
    
    for (int i = 0; i < values.length; i++) {
      final x = i * stepWidth * progress;
      final y = size.height - ((values[i] - minValue) / range) * size.height;
      
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    
    fillPath.lineTo(size.width * progress, size.height);
    fillPath.close();
    
    // Draw fill
    canvas.drawPath(fillPath, fillPaint);
    
    // Draw line
    canvas.drawPath(path, paint);
    
    // Draw points
    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    final selectedPointPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    
    for (int i = 0; i < values.length; i++) {
      final x = i * stepWidth * progress;
      final y = size.height - ((values[i] - minValue) / range) * size.height;
      final isSelected = selectedIndex == i;
      
      if (x <= size.width * progress) {
        canvas.drawCircle(
          Offset(x, y),
          isSelected ? 8 : 4,
          isSelected ? selectedPointPaint : pointPaint,
        );
        
        if (isSelected) {
          canvas.drawCircle(
            Offset(x, y),
            6,
            Paint()
              ..color = Colors.white
              ..style = PaintingStyle.fill,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}