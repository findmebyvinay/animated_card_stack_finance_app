import 'package:animated_card_stack_finance/features/insight/domain/model/spending_insight.dart';
import 'package:flutter/material.dart';

class InsightCard extends StatefulWidget {
  final SpendingInsight insight;
  
  const InsightCard({super.key, required this.insight});

  @override
  State<InsightCard> createState() => _InsightCardState();
}

class _InsightCardState extends State<InsightCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    
    _slideAnimation = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: widget.insight.color.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.insight.color.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: widget.insight.color.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            widget.insight.icon,
                            color: widget.insight.color,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.insight.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (widget.insight.percentage != null)
                                Text(
                                  '${widget.insight.percentage!.toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    color: widget.insight.color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        _buildTypeIndicator(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.insight.description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    if (widget.insight.actionText != null) ...[
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _handleAction(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.insight.color,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(widget.insight.actionText!),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildTypeIndicator() {
    Color indicatorColor;
    IconData indicatorIcon;
    
    switch (widget.insight.type) {
      case InsightType.warning:
        indicatorColor = Colors.orange;
        indicatorIcon = Icons.warning_amber;
        break;
      case InsightType.tip:
        indicatorColor = Colors.amberAccent;
        indicatorIcon = Icons.lightbulb;
        break;
      case InsightType.achievement:
        indicatorColor = Colors.green;
        indicatorIcon = Icons.check_circle;
        break;
      case InsightType.trend:
        indicatorColor = Colors.purple;
        indicatorIcon = Icons.trending_up;
        break;
    }
    
    return Icon(
      indicatorIcon,
      color: indicatorColor,
      size: 20,
    );
  }
  
  void _handleAction() {
    // Handle action button press
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.insight.actionText} - Coming Soon!'),
        backgroundColor: widget.insight.color,
      ),
    );
  }
}