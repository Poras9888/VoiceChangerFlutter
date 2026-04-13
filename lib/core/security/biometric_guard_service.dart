import 'package:flutter/foundation.dart';

class BiometricGuardService {
  final ValueNotifier<bool> lockEnabled = ValueNotifier<bool>(false);

  void setLockEnabled(bool enabled) {
    lockEnabled.value = enabled;
  }
}
