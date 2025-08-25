
import 'package:animated_card_stack_finance/core/localization/app_locale.dart';
import 'package:animated_card_stack_finance/core/services/get_it/service_locator.dart';
import 'package:animated_card_stack_finance/core/services/local_storage/shared_pref_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LanguageCubit extends Cubit<String> with AppLocale {
  LanguageCubit() : super(AppLanguage.en_lang);

  void init() {
    final String language =
        getIt<SharedPrefData>().getLanguage ?? AppLanguage.en_lang;
    initLang(languageCode: language);
    emit(language);
  }

  void changeLanguage(String newLanguage) async {
    initLang(languageCode: newLanguage);
    emit(newLanguage);
    getIt<SharedPrefData>().saveLanguage(language: newLanguage);
  }

  void resetLanguage() {
    initLang(languageCode: AppLanguage.en_lang);
    emit(AppLanguage.en_lang);
  }

  bool isEnglish() {
    return state == AppLanguage.en_lang;
  }

  bool isNepali() {
    return state == AppLanguage.ne_lang;
  }

  String get currentLanguage => state;
  String get currentLanguageName {
    return state == AppLanguage.en_lang
        ? AppLocale.en[AppLocale.languagae]
        : AppLocale.ne[AppLocale.languagae];
  }
}
