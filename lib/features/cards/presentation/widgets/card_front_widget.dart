
// lib/features/cards/presentation/widgets/card_front_widget.dart
import 'package:animated_card_stack_finance/features/cards/presentation/theme/card_theme_config.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/utils/card_formatters.dart';
import 'package:flutter/material.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/core/enums/card_type.dart';
import 'card_widgets.dart';
import 'nabil_card_backgrounds.dart';

class CardFrontWidget extends StatelessWidget {
  final CreditCard card;
  
  const CardFrontWidget({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background pattern
        _buildBackgroundPattern(),
        // Card content
        Padding(
          padding: const EdgeInsets.all(CardThemeConfig.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildChipAndContactless(),
              const Spacer(),
              _buildCardNumber(),
              const SizedBox(height: 16),
              _buildBottomInfo(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundPattern() {
    switch (card.type) {
      case CardType.visa:
        return const GeometricBackground(
          color: Colors.white,
          opacity: 0.15,
        );
      case CardType.mastercard:
        return const GeometricBackground(
          color: Colors.white,
          opacity: 0.1,
        );
      case CardType.dollarcard:
        return Container(); // Simple background for Amex
    }
  }
  
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const NabilBankHeader(),
        Row(
          children: [
            if (card.type == CardType.visa) ...[
              Text(
                'VALID ONLY IN NEPAL & INDIA',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 6,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
            ],
            const NabilContactlessIcon(),
            const SizedBox(width: 8),
            NabilBrandLogo(cardType: card.type),
          ],
        ),
      ],
    );
  }
  
  Widget _buildChipAndContactless() {
    return const Row(
      children: [
        CardChip(),
      ],
    );
  }
  
  Widget _buildCardNumber() {
    return Text(
      CardFormatters.formatCardNumber(card.cardNumber, card.type),
      style: CardThemeConfig.cardNumberStyle.copyWith(
        fontSize: 18,
        letterSpacing: 2.5,
      ),
    );
  }
  
  Widget _buildBottomInfo() {
    return Row(
      children: [
        // Left side - vertical text for electronic use only
        if (card.type == CardType.visa)
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              CardConstants.electronicUseOnly,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 6,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ),
        
        if (card.type == CardType.visa) const SizedBox(width: 16),
        
        // Card holder name
        Expanded(
          flex: 3,
          child: CardInfoLabel(
            label: CardConstants.cardHolderLabel,
            value: CardFormatters.formatHolderName(card.holderName),
            valueStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        
        // Valid from and expiry
        if (card.type == CardType.visa) ...[
          Expanded(
            child: CardInfoLabel(
              label: CardConstants.validFromShort,
              value: CardConstants.defaultValidFrom,
              valueStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: CardInfoLabel(
              label: CardConstants.validThruShort,
              value: card.expiryDate,
              valueStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ] else ...[
          // For Mastercard - different layout
          Expanded(
            child: CardInfoLabel(
              label: CardConstants.validFromShort,
              value: CardConstants.defaultValidFrom,
              valueStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: CardInfoLabel(
              label: CardConstants.validThruShort,
              value: card.expiryDate,
              valueStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}