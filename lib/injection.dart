import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

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
  getIt.registerLazySingleton<AppDatabase>(AppDatabase.new);
  getIt.registerLazySingleton<RecordingRepository>(
    () => RecordingRepositoryImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<EffectRepository>(EffectRepositoryImpl.new);
}
