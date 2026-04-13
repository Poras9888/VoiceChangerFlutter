import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core/ads/ad_service.dart';
import 'core/ads/consent_manager.dart';
import 'core/ads/remote_ads_config_service.dart';
import 'core/security/biometric_guard_service.dart';
import 'data/database/app_database.dart';
import 'data/repositories/effect_repository.dart';
import 'data/repositories/effect_repository_impl.dart';
import 'data/repositories/recording_repository.dart';
import 'data/repositories/recording_repository_impl.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.registerLazySingleton<ConsentManager>(ConsentManager.new);
  getIt.registerLazySingleton<AdService>(AdService.new);
  getIt.registerLazySingleton<RemoteAdsConfigService>(RemoteAdsConfigService.new);
  getIt.registerLazySingleton<BiometricGuardService>(BiometricGuardService.new);
  final appDatabase = AppDatabase();
  await appDatabase.ensureReady();
  getIt.registerSingleton<AppDatabase>(appDatabase);
  getIt.registerLazySingleton<RecordingRepository>(
    () => RecordingRepositoryImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<EffectRepository>(EffectRepositoryImpl.new);
}
