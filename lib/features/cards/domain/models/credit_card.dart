// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:animated_card_stack_finance/core/enums/card_type.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/transaction.dart';

class CreditCard {
  final String id;
  final String cardNumber;
  final String holderName;
  final String expiryDate;
  final String cvv;
  final double balance;
  final CardType type;
  final Color primaryColor;
  final Color secondaryColor;
  final List<Transaction> recentTransactions;

  const CreditCard(
    {
    required this.id,
    required this.cardNumber,
    required this.holderName,
    required this.expiryDate,
    required this.cvv,
    required this.balance,
    required this.type,
    required this.primaryColor,
    required this.secondaryColor,
    required this.recentTransactions,
    }
  );

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'cardNumber':cardNumber,
      'holderName':holderName,
      'expiryDate':expiryDate,
      'cvv':cvv,
      'balance':balance,
      'type':type,
      'primaryColor':primaryColor,
      'secondaryColor':secondaryColor,
      'recentTransactions':recentTransactions,
    };
  }

  factory CreditCard.fromJson(Map<String,dynamic> json){
    return CreditCard(
      id: json['id'], 
      cardNumber: json['cardNumber'], 
      holderName: json['holderName'], 
      expiryDate: json['expiryDate'], 
      cvv: json['cvv'], 
      balance: json['balance'], 
      type: json['type'], 
      primaryColor: json['primaryColor'], 
      secondaryColor: json['secondaryColor'], 
      recentTransactions: json['recentTransactions']);
  }
}

