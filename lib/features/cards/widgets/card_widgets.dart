// lib/features/cards/presentation/widgets/card_widgets.dart
import 'package:animated_card_stack_finance/features/cards/screen/theme/card_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:animated_card_stack_finance/core/enums/card_type.dart';
import 'nabil_card_backgrounds.dart';

class CardChip extends StatelessWidget {
  const CardChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CardThemeConfig.chipWidth,
      height: CardThemeConfig.chipHeight,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class NabilContactlessIcon extends StatelessWidget {
  const NabilContactlessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContactlessWaves(
      color: Colors.white,
      size: 24,
    );
  }
}

class NabilBrandLogo extends StatelessWidget {
  final CardType cardType;
  
  const NabilBrandLogo({
    super.key,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    switch (cardType) {
      case CardType.visa:
        return _buildVisaLogo();
      case CardType.mastercard:
        return _buildMastercardLogo();
      case CardType.dollarcard:
        return _buildAmexLogo();
    }
  }
  
  Widget _buildVisaLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'VISA',
        style: TextStyle(
          color: Color(0xFF1A1F71),
          fontSize: 14,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
  
  Widget _buildMastercardLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Color(0xFFEB001B),
            shape: BoxShape.circle,
          ),
        ),
        Transform.translate(
          offset: const Offset(-6, 0),
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFFFF5F00),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          'mastercard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
  
  Widget _buildAmexLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'ICard',
        style: TextStyle(
          color: Color.fromARGB(255, 19, 20, 20),
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class MagneticStrip extends StatelessWidget {
  const MagneticStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: CardThemeConfig.magneticStripHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1A1A1A),
            Color(0xFF000000),
            Color(0xFF1A1A1A),
          ],
        ),
      ),
    );
  }
}

class SignatureStrip extends StatelessWidget {
  final String cvv;
  
  const SignatureStrip({
    super.key,
    required this.cvv,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: CardThemeConfig.signatureStripHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                cvv,
                style: CardThemeConfig.cvvStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardInfoLabel extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;
  final CrossAxisAlignment alignment;
  
  const CardInfoLabel({
    super.key,
    required this.label,
    required this.value,
    this.valueStyle,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: CardThemeConfig.labelStyle.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            height: 1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: valueStyle ?? CardThemeConfig.holderNameStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class NabilBankHeader extends StatelessWidget {
  const NabilBankHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Nabil Bank Logo (simplified)
        Container(
          width: 8,
          height: 12,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(1)),
          ),
        ),
        const SizedBox(width: 6),
        const Text(
          'NABIL BANK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}