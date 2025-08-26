import 'package:animated_card_stack_finance/features/cards/screen/mixin/card_animation_mixin.dart';
import 'package:animated_card_stack_finance/features/cards/screen/theme/card_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'card_front_widget.dart';
import 'card_back_widget.dart';
class AnimatedCard extends StatefulWidget {
  final CreditCard card;
  final bool isFlipped;

  const AnimatedCard({
    super.key,
    required this.card,
    required this.isFlipped,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin, CardAnimationMixin {

  late CardColorScheme _colorScheme;

  @override
  void initState() {
    super.initState();
    _colorScheme = CardColorScheme.getScheme(widget.card.type);
  }

  @override
  void didUpdateWidget(AnimatedCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update color scheme if card type changed
    if (widget.card.type != oldWidget.card.type) {
      _colorScheme = CardColorScheme.getScheme(widget.card.type);
    }
    
    // Handle flip animation
    if (widget.isFlipped != oldWidget.isFlipped) {
      handleFlipAnimation(widget.isFlipped);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: flipAnimation,
      builder: (context, child) => _buildCard(),
    );
  }

  Widget _buildCard() {
    return Transform(
      alignment: Alignment.center,
      transform: flipTransform,
      child: Container(
        width: double.infinity,
        height: CardThemeConfig.cardHeight,
        decoration: _buildCardDecoration(),
        child: _buildCardContent(),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(CardThemeConfig.cardBorderRadius),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: _colorScheme.gradientColors,
      ),
      boxShadow: CardShadows.getCardShadows(_colorScheme.gradientColors),
    );
  }

  Widget _buildCardContent() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CardThemeConfig.cardBorderRadius),
        gradient: CardShadows.getTextureOverlay(),
      ),
      child: isShowingFront 
          ? _buildFrontSide() 
          : _buildBackSide(),
    );
  }

  Widget _buildFrontSide() {
    return CardFrontWidget(card: widget.card);
  }

  Widget _buildBackSide() {
    return Transform(
      alignment: Alignment.center,
      transform: backSideTransform,
      child: CardBackWidget(
        card: widget.card,
        gradientColors: _colorScheme.gradientColors,
        accentColor: _colorScheme.accentColor,
      ),
    );
  }
}