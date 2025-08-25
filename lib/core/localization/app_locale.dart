// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter_localization/flutter_localization.dart';

part 'ne_locale.dart';
part 'en_locale.dart';

class AppLanguage {
  AppLanguage._();

  static const String ne_lang = 'ne';
  static const String en_lang = 'en';
}

mixin AppLocale {
  final FlutterLocalization localization = FlutterLocalization.instance;

  VoidCallback? onLanguageChanged;

  void initLang({required String languageCode}) {
    localization.init(
      mapLocales: [
        const MapLocale(AppLanguage.en_lang, AppLocale.en),
        const MapLocale(AppLanguage.ne_lang, AppLocale.ne),
      ],
      initLanguageCode: languageCode,
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  void _onTranslatedLanguage(Locale? locale) {
    onLanguageChanged?.call();
  }

  static const String languagae = 'languagae';
  static const String selectLanguagae = 'selectLanguagae';
  static const String selectTheme = 'selectTheme';

  ///========== NavBar ==========
  static const String home = 'home';
  static const String startSurvey = 'startSurvey';
  static const String profile = 'profile';
  static const String notifications = 'notifications';

  ///========== LogIn Screen ==========
  static const String logIn = 'logIn';
  static const String loginButton = 'loginButton';
  static const String forgotPassword = 'forgotPassword';
  static const String emailAddress = 'emailAddress';
  static const String username = 'username';
  static const String password = 'password';

  static const String emailRequired = 'emailRequired';
  static const String passwordRequired = 'passwordRequired';
  static const String invalidEmail = 'invalidEmail';
  static const String invalidPassword = 'invalidPassword';

  ///========== Beneficiary Profile Register ==========
  static const String beneficiaryProfileRegister = 'beneficiaryProfileRegister';

  ///========== Edit Screen ==========
  static const String beneficiaryProfileList = "beneficiaryProfileList";
  static const String successfullyDeleted = "successfullyDeleted";
  static const String errorOnDeleting = "errorOnDeleting";
  static const String academicYear = "academicYear";
  static const String name = "name";
  static const String surveyDate = "surveyDate";

  ///========== Upload Screen ==========
  static const String uploading = "uploading";
  static const String selectAll = "selectAll";
  static const String adultData = "adultData";
  static const String childData = "childData";
  static const String firstSelectDataToUpload = "firstSelectDataToUpload";

  ///==========Person Register Screen ==========
  static const String adultDetails = "adultDetails";
  static const String childDetails = "childDetails";
  static const String addAdult = "addAdult";
  static const String addChild = "addChild";

  ///==========CastDropDown ==========
  static const String selectCaste = "selectCaste";
  static const String pleaseSelectCaste = " pleaseSelectCaste";

  ///==========ChildAgeInput Widget ==========
  static const String selectYear = 'selectYear';
  static const String pleaseSelectYear = "pleaseSelectYear";
  static const String selectMonth = "selectMonth";
  static const String pleaseSelectMonth = "pleaseSelectMonth";
  static const String age = 'age';

  ///==========DisabilityDropdown Widget ==========
  static const String selectValue = 'selectValue';

  ///==========DistrictDropdown Widget ==========
  static const String selectDistrict = 'selectDistrict';
  static const String pleaseSelectDistrict = "pleaseSelectDistrict";

  ///==========FreeTextWidget ==========
  static const String enterValue = "enterValue";
  static const String pleaseEnterMobileNumber = "pleaseEnterMobileNumber";
  static const String pleaseEnterValidMobileNumber =
      "pleaseEnterValidMobileNumber";
  static const String pleaseEnterAge = "pleaseEnterAge";
  static const String pleaseEnterValidAge = "pleaseEnterValidAge";
  static const String mustBeEligibleAge = "mustBeEligibleAge";
  static const String mustBeValidAge = "mustBeValidAge";
  static const String mustbeGreaterThanZero = "mustbeGreaterThanZero";

  ///==========GenderDropDown Widget ==========
  static const String selectGender = "selectGender";
  static const String pleaseSelectGender = "pleaseSelectGender";

  ///==========MaritalStatusDropDown Widget ==========
  static const String selectMaritalStatus = "selectMaritalStatus";
  static const String pleaseSelectMaritalStatus = "pleaseSelectMaritalStatus";

  ///==========ToleDropDown Widget ==========
  static const String tole='tole';
  static const String selectTole = "selectTole";
  static const String pleaseSelectTole = "pleaseSelectTole";

  ///==========VDCDropDown Widget ==========
  static const String vdc= 'vdc';
  static const String selectVdc = "selectVdc";
  static const String pleaseSelectVdc = "pleaseSelectVdc";

    ///==========LocalBodyDropDown Widget ==========
  static const String localBody= 'localBody';
  static const String selectLocalBody = "selectLocalBody";
  static const String pleaseSelectLocalBody = "pleaseSelectLocalBody";


  ///==========WardDropDown Widget ==========
  static const String ward='ward';
  static const String selectWard = "selectWard";
  static const String pleaseSelectWard = "pleaseSelectWard";


///==========ReponseDropDown Widget ==========
  static const String response='response';
  static const String selectResponse = "selectResponse";
  static const String pleaseSelectResponse = "pleaseSelectResponse";

  


  ///========== Global ==========
  static const String noData = 'noData';
  static const String somethingWentWrong = 'somethingWentWrong';
  static const String somethingWentWrongMessage = 'somethingWentWrongMessage';
  static const String retry = 'retry';
  static const String filter = 'filter';
  static const String appExitLable = 'appExitLable';
  static const String appExitMessage = 'appExitMessage';
  static const String backOnline = 'backOnline';
  static const String noInternetConnection = 'noInternetConnection';
  static const String exitAppTitle = 'exitAppTitle';
  static const String exitAppConfirmation = 'exitAppConfirmation';
  static const String search = "search";
  static const String selectItem = "selectItem";
  static const String openAppSetting = "openAppSetting";
  static const String version = "version";
  static const String devVersion = "devVersion";

  ///========== Buttons ==========
  static const String ok = 'ok';
  static const String cancel = 'cancel';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String save = 'save';
  static const String delete = 'delete';
  static const String edit = 'edit';
  static const String add = 'add';
  static const String next = 'next';
  static const String previous = 'previous';
  static const String submit = 'submit';
  static const String close = 'close';
  static const String back = 'back';
  static const String continueButton = 'continue';
  static const String view = 'view';
  static const String viewAll = 'viewAll';
  static const String viewDetails = 'viewDetails';
  static const String viewMore = 'viewMore';
  static const String viewLess = 'viewLess';
  static const String start = 'start';
  static const String accept = 'accept';
  static const String decline = 'decline';
  static const String level='level';
  /// =========== Form Fields =============
  static const String province = 'province';
  static const String district = 'district';
  static const String municipality = 'municipality';
  static const String national='national';
  static const String select = 'select';
  static const String year = 'year';
  static const String month = 'month';



  /// === Dashboard =========
  static const String humanitarianApp='humanitarianApp';
  static const String download = 'download';
  static const String downloadSubLable = 'downloadSubLable';
  static const String upload = 'upload';
  static const String uploadSubLable = 'uploadSubLable';
  static const String editSubLable = 'editSubLable';
  static const String dashbordLable = 'dashbordLable';
  static const String downloading = 'downloading';
  static const String downloadPopulation='downloadPopulation';
  static const String itemDistributed='itemDistributed';
  static const String beneficiary='beneficiary';
  static const String totalProducts='totalProducts';

///========== SELECT DISTRIBUTION LOCATION ==========
  static const String distributionDate='distributionDate';
  static const String distributionType='distributionType';
  static const String distributionLocation='distributionLocation';
  static const String selectDate='selectDate';
  static const String selectDistributionLocation='selectDistributionLocation';
  static const String individual='individual';
  static const String bulk='bulk';
  static const String distributeItem='distributeItem';

///==========  DISTRIBUTION ==========  
static const String distribution='distribution';
static const String external='external';
static const String benficiary='benficiary';
static const String changeward='changeWard';
static const String sn='sn';
static const String fullName='fullName';
static const String gender='gender';
static const String addExternalData='addExternalData';
static const String mobileNumber='mobileNumber';
static const String ethnicity='ethnicity';
static const String enterExternalDataInformation='enterExternalDataInformation';
static const String chooseward='chooseward';

/// ================= Drawer setting option ==============
 static const String downloadBeneficiary='downloadBeneficiary';
 static const String downloadInventory='downloadInventory';
  /// ================= BackUp And Restore ==============
  static const String backupRestore = 'backupRestore';
  static const String backupMessage = 'backupMessage';
  static const String restoreMessage = 'restoreMessage';
  static const String backupButtonLabel = 'backupButtonLabel';
  static const String restoreButtonLabel = 'restoreButtonLabel';

  ///========== Profile ==========
  static const String theme = 'theme';
  static const String logout = 'logout';
  static const String logoutSubtitle = 'logoutSubtitle';
  static const String logoutMessage = 'logoutMessage';
  static const String themeSubtitle = 'themeSubtitle';
  static const String languageSubtitle = 'languageSubtitle';
  static const String backupRestoreSubtitle = 'backupRestoreSubtitle';

  /// ======== English Language
  static const Map<String, dynamic> en = enLocale;

  ///========== Nepali Languagae ==========
  static const Map<String, dynamic> ne = neLocale;
}
