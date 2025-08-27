import 'dart:async';
import 'dart:developer';

import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/core/services/get_it/service_locator.dart';
import 'package:animated_card_stack_finance/core/widgets/loader_widget.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/screen/card_stack_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

abstract class Absmain{
  Future<void> init();
}

class MainScreen extends Absmain{
  @override
  Future<void> init()async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureDependencies();
  await _initializeLocalization();
  runApp(const FinanceApp());
  }
  
  Future<void> _configureDependencies() async {
    try {
      await configureDependencies();
      log('successfully configured');
    } catch (e) {
      log('failed to configure ');
    }
  }
  Future<void> _initializeLocalization() async {
    try {
      await FlutterLocalization.instance.ensureInitialized();
      log('localizatiion initialized');
    } catch (e) {
      log('init localization failed');
    }
  }
}

class FinanceApp extends StatefulWidget {
  const FinanceApp({super.key});

  @override
  State<FinanceApp> createState() => _FinanceAppState();
}

class _FinanceAppState extends State<FinanceApp> {
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
  home:SplashScreen()
        
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(
      seconds: 3
    ), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CardStackScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.backgroundColor ,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animation/card.json'),
          Text('ANIMATED CARD FINANCE APP',style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: AppColors.whiteColor
          ),),
          const SizedBox(
            height: 20,
          ),
          LoaderWidget(dotColor: AppColors.secondaryTeal,)
        ],
      )),
    );
  }
}