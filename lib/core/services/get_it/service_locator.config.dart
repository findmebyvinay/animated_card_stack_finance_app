// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../../features/cards/presentation/bloc/cards_bloc.dart' as _i365;
import '../../../features/insight/data/insights_repo_impl.dart' as _i784;
import '../../../features/insight/domain/repo/insights_repo.dart' as _i492;
import '../../../features/insight/presentation/bloc/insights_bloc.dart'
    as _i172;
import '../../bloc/internet_cubit.dart' as _i636;
import '../../bloc/language_cubit.dart' as _i957;
import '../local_storage/shared_pref_data.dart' as _i324;
import '../local_storage/shared_pref_data_impl.dart' as _i566;
import '../local_storage/shared_pref_module.dart' as _i421;
import '../local_storage/shared_pref_service.dart' as _i942;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPrefsModule = _$SharedPrefsModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefsModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i636.InternetCubit>(() => _i636.InternetCubit());
    gh.lazySingleton<_i957.LanguageCubit>(() => _i957.LanguageCubit());
    gh.lazySingleton<_i365.CardsBloc>(() => _i365.CardsBloc());
    gh.lazySingleton<_i324.SharedPrefData>(() => _i566.SharedPrefDataImpl());
    gh.factory<_i492.InsightsRepo>(() => _i784.InsightsRepoImpl());
    gh.lazySingleton<_i942.SharedPrefsServices>(
      () => _i942.SharedPrefsServices(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i172.InsightsBloc>(
      () => _i172.InsightsBloc(gh<_i492.InsightsRepo>()),
    );
    return this;
  }
}

class _$SharedPrefsModule extends _i421.SharedPrefsModule {}
