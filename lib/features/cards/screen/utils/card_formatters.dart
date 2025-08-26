import 'package:animated_card_stack_finance/core/enums/card_type.dart';

class CardFormatters {
  /// Formats card number based on card type
  /// American Express: XXXX XXXXXX XXXXX
  /// Others: XXXX XXXX XXXX XXXX
  static String formatCardNumber(String cardNumber, CardType cardType) {
    final cleanNumber = cardNumber.replaceAll(' ', '');
    
    switch (cardType) {
      case CardType.dollarcard:
        return _formatAmexNumber(cleanNumber);
      case CardType.visa:
      case CardType.mastercard:
        return _formatStandardNumber(cleanNumber);
    }
  }
  
  static String _formatAmexNumber(String cleanNumber) {
    if (cleanNumber.length >= 15) {
      return '${cleanNumber.substring(0, 4)} ${cleanNumber.substring(4, 10)} ${cleanNumber.substring(10, 15)}';
    }
    return cleanNumber;
  }
  
  static String _formatStandardNumber(String cleanNumber) {
    if (cleanNumber.length >= 16) {
      return '${cleanNumber.substring(0, 4)} ${cleanNumber.substring(4, 8)} ${cleanNumber.substring(8, 12)} ${cleanNumber.substring(12, 16)}';
    }
    return cleanNumber;
  }
  
  /// Formats balance amount
  static String formatBalance(double balance) {
    return 'Rs${balance.toStringAsFixed(2)}';
  }
  
  /// Formats holder name to uppercase
  static String formatHolderName(String name) {
    return name.toUpperCase();
  }
}