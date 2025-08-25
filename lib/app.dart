import 'package:animated_card_stack_finance/features/cards/bloc/cards_bloc.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_event.dart';
import 'package:animated_card_stack_finance/features/cards/screen/card_stack_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3D Finance Cards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'SF Pro Display',
      ),
      home: BlocProvider(
        create: (context)=>CardsBloc()..add(LoadCardsEvent()),
        child: const CardStackScreen(),
        ),
        
    );
  }
}