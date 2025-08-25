import 'dart:developer';

import 'package:animated_card_stack_finance/app.dart';
import 'package:animated_card_stack_finance/core/services/get_it/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main()async {
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