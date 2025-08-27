// lib/features/cards/presentation/widgets/card_back_widget.dart
import 'package:animated_card_stack_finance/core/enums/card_type.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/theme/card_theme_config.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/utils/card_formatters.dart';
import 'package:flutter/material.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'card_widgets.dart';
import 'nabil_card_backgrounds.dart';

class CardBackWidget extends StatelessWidget {
  final CreditCard card;
  final List<Color> gradientColors;
  final Color accentColor;
  
  const CardBackWidget({
    super.key,
    required this.card,
    required this.gradientColors,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CardThemeConfig.cardBorderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradientColors[0].withValues(alpha: 0.95),
            gradientColors[1].withValues(alpha: 0.95),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background pattern (subtle)
          if (card.type == CardType.mastercard)
            const GeometricBackground(
              color: Colors.white,
              opacity: 0.05,
            ),
          // Content
          Column(
            children: [
              const SizedBox(height: CardThemeConfig.cardPadding),
              const MagneticStrip(),
              const SizedBox(height: CardThemeConfig.cardPadding),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CardThemeConfig.cardPadding,
                ),
                child: _buildBackContent(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildBackContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildSignatureSection(),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInfoSection(),
        ),
      ],
    );
  }
  
  Widget _buildSignatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SignatureStrip(cvv: card.cvv),
        const SizedBox(height: 8),
        Text(
          CardConstants.signatureText,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 7,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
  
  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Nabil Bank logo/text
        const NabilBankHeader(),
        const SizedBox(height: 8),
        
        // Balance
        Text(
          CardConstants.currentBalanceLabel,
          style: CardThemeConfig.labelStyle.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 9,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          CardFormatters.formatBalance(card.balance),
          style: CardThemeConfig.balanceStyle.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        
        // Customer service
        Text(
          'www.nabilbank.com\nCustomer Care: 16600101010',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 7,
            height: 1.3,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}