import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../injection.dart';
import 'biometric_guard_service.dart';

class BiometricGate extends StatefulWidget {
  const BiometricGate({super.key, required this.child});

  final Widget child;

  @override
  State<BiometricGate> createState() => _BiometricGateState();
}

class _BiometricGateState extends State<BiometricGate> {
  bool _checking = true;
  bool _allowed = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    final guard = getIt<BiometricGuardService>();
    if (!guard.lockEnabled.value) {
      if (!mounted) return;
      setState(() {
        _allowed = true;
        _checking = false;
      });
      return;
    }

    final auth = LocalAuthentication();
    final ok = await auth.authenticate(
      localizedReason: 'Authenticate to view saved recordings',
      options: const AuthenticationOptions(biometricOnly: true),
    );

    if (!mounted) return;
    setState(() {
      _allowed = ok;
      _checking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_allowed) {
      return widget.child;
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Locked')),
      body: Center(
        child: ElevatedButton(
          onPressed: _authenticate,
          child: const Text('Try Again'),
        ),
      ),
    );
  }
}
