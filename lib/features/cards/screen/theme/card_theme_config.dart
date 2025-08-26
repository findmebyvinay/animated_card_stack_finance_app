// lib/features/cards/presentation/theme/card_theme_config.dart
import 'package:flutter/material.dart';
import 'package:animated_card_stack_finance/core/enums/card_type.dart';

class CardThemeConfig {
  static const Duration animationDuration = Duration(milliseconds: 800);
  static const Curve animationCurve = Curves.easeInOut;
  static const double cardHeight = 200.0;
  static const double cardBorderRadius = 16.0;
  static const double cardPadding = 24.0;
  static const double chipWidth = 32.0;
  static const double chipHeight = 24.0;
  static const double magneticStripHeight = 45.0;
  static const double signatureStripHeight = 32.0;
  
  // Typography
  static const TextStyle bankNameStyle = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );
  
  static const TextStyle cardNumberStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 3,
    fontFamily: 'monospace',
  );
  
  static const TextStyle holderNameStyle = TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
  );
  
  static const TextStyle labelStyle = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );
  
  static const TextStyle balanceStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'monospace',
  );
  
  static const TextStyle cvvStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'monospace',
  );
}

class CardColorScheme {
  final List<Color> gradientColors;
  final Color accentColor;
  final String brandName;
  final String? backgroundPattern;
  
  const CardColorScheme({
    required this.gradientColors,
    required this.accentColor,
    required this.brandName,
    this.backgroundPattern,
  });
  
  static const Map<CardType, CardColorScheme> _schemes = {
    CardType.visa: CardColorScheme(
      gradientColors: [Color(0xFF1B5E20), Color(0xFF4CAF50)],
      accentColor: Color(0xFFFFFFFF),
      brandName: 'VISA',
    ),
    CardType.mastercard: CardColorScheme(
      gradientColors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
      accentColor: Color(0xFF4CAF50),
      brandName: 'MASTERCARD',
      backgroundPattern: 'geometric',
    ),
    CardType.dollarcard: CardColorScheme(
      gradientColors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 41, 43, 45)],
      accentColor: Color(0xFF00A651),
      brandName: 'Dollar Card',
    ),
  };
  
  static CardColorScheme getScheme(CardType type) {
    return _schemes[type] ?? _schemes[CardType.visa]!;
  }
}

class CardShadows {
  static List<BoxShadow> getCardShadows(List<Color> gradientColors) {
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.3),
        blurRadius: 20,
        offset: const Offset(0, 10),
        spreadRadius: 2,
      ),
      BoxShadow(
        color: gradientColors[0].withValues(alpha: 0.2),
        blurRadius: 40,
        offset: const Offset(0, 20),
        spreadRadius: -5,
      ),
    ];
  }
  
  static Gradient getTextureOverlay() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withValues(alpha: 0.1),
        Colors.transparent,
        Colors.black.withValues(alpha: 0.1),
      ],
    );
  }
}

class CardConstants {
  static const String nabilBankName = 'NABIL BANK';
  static const String defaultValidFrom = '01/22';
  static const String customerService = 'Customer Service:\n1-800-123-4567';
  static const String signatureText = 'Authorized Signature - Not Valid Unless Signed';
  static const String currentBalanceLabel = 'CURRENT BALANCE';
  static const String cardHolderLabel = 'CARD HOLDER';
  static const String validFromLabel = 'VALID\nFROM';
  static const String expiresEndLabel = 'EXPIRES\nEND';
  static const String validFromShort = 'VALID\nFROM';
  static const String validThruShort = 'VALID\nTHRU';
  static const String electronicUseOnly = 'ELECTRONIC USE ONLY';
}