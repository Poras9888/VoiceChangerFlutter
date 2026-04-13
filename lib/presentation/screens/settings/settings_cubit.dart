import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsState {
  const SettingsState({
    this.quality = 'High',
    this.storage = 'Internal',
    this.defaultEffect = 'Normal',
    this.biometricLock = false,
  });

  final String quality;
  final String storage;
  final String defaultEffect;
  final bool biometricLock;

  SettingsState copyWith({String? quality, String? storage, String? defaultEffect, bool? biometricLock}) {
    return SettingsState(
      quality: quality ?? this.quality,
      storage: storage ?? this.storage,
      defaultEffect: defaultEffect ?? this.defaultEffect,
      biometricLock: biometricLock ?? this.biometricLock,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void setQuality(String value) => emit(state.copyWith(quality: value));
  void setStorage(String value) => emit(state.copyWith(storage: value));
  void setDefaultEffect(String value) => emit(state.copyWith(defaultEffect: value));
  void setBiometricLock(bool value) => emit(state.copyWith(biometricLock: value));
}
