import 'dart:ui';

class DebounceUtils {
  bool _isButtonDisabled = false;

  void run(VoidCallback action) {
    if (_isButtonDisabled) return;
    _isButtonDisabled = true;
    action();
    Future.delayed(Duration(seconds: 2), () => _isButtonDisabled = false);
  }
}
