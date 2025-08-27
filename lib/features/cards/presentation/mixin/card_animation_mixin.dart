import 'package:flutter/material.dart';
import '../theme/card_theme_config.dart';

mixin CardAnimationMixin<T extends StatefulWidget> on State<T>, SingleTickerProviderStateMixin<T> {
  late AnimationController flipController;
  late Animation<double> flipAnimation;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }
  
  @override
  void dispose() {
    flipController.dispose();
    super.dispose();
  }
  
  void _initializeAnimations() {
    flipController = AnimationController(
      duration: CardThemeConfig.animationDuration,
      vsync: this,
    );
    
    flipAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: flipController,
      curve: CardThemeConfig.animationCurve,
    ));
  }
  
  void handleFlipAnimation(bool isFlipped) {
    if (isFlipped) {
      flipController.forward();
    } else {
      flipController.reverse();
    }
  }
  
  bool get isShowingFront => flipAnimation.value < 0.5;
  
  Matrix4 get flipTransform => Matrix4.identity()
    ..setEntry(3, 2, 0.001)
    ..rotateY(flipAnimation.value * 3.14159);
    
  Matrix4 get backSideTransform => Matrix4.identity()..rotateY(3.14159);
}