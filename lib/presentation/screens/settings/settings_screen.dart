import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(12),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('AUDIO', style: TextStyle(fontSize: 12, color: Colors.black54)),
                ),
                _tile(context, Icons.high_quality, 'Audio Quality', state.quality, () => _showRadioDialog(context, 'Audio Quality', ['Low', 'Medium', 'High'], state.quality, context.read<SettingsCubit>().setQuality)),
                _tile(context, Icons.sd_storage, 'Storage Location', state.storage, () => _showRadioDialog(context, 'Storage', ['Internal', 'SD Card'], state.storage, context.read<SettingsCubit>().setStorage)),
                _tile(context, Icons.auto_fix_high, 'Default Effect', state.defaultEffect, () => _showEffectDialog(context)),
                SwitchListTile(
                  title: const Text('Biometric Lock'),
                  value: state.biometricLock,
                  onChanged: (value) async {
                    final ok = await LocalAuthentication().authenticate(
                      localizedReason: 'Enable biometric lock',
                      options: const AuthenticationOptions(biometricOnly: true),
                    );
                    if (ok) {
                      context.read<SettingsCubit>().setBiometricLock(value);
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('ABOUT', style: TextStyle(fontSize: 12, color: Colors.black54)),
                ),
                _tile(context, Icons.privacy_tip, 'Privacy Policy', '', () => launchUrl(Uri.parse('https://example.com/privacy'))),
                _tile(context, Icons.star_rate, 'Rate App', '', () => launchUrl(Uri.parse('https://example.com/store'))),
                _tile(context, Icons.share, 'Share App', '', () => Share.share('Try Voice Changer & Sound Effects Recorder!')),
                _tile(context, Icons.info, 'Version', '1.0.0', null),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String title, String trailing, VoidCallback? onTap) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: trailing.isEmpty ? null : Text(trailing),
        onTap: onTap,
      ),
    );
  }

  Future<void> _showRadioDialog(
    BuildContext context,
    String title,
    List<String> values,
    String selected,
    ValueChanged<String> onSelected,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: values
              .map((e) => RadioListTile<String>(
                    value: e,
                    groupValue: selected,
                    title: Text(e),
                    onChanged: (v) {
                      onSelected(v!);
                      Navigator.pop(context);
                    },
                  ))
              .toList(growable: false),
        ),
      ),
    );
  }

  Future<void> _showEffectDialog(BuildContext context) async {
    final effects = const [
      'Normal', 'Monster', 'Robot', 'Cave', 'Alien', 'Nervous', 'Death', 'Drunk', 'Underwater', 'Big Robot',
      'Zombie', 'Hexafluoride', 'Small Alien', 'Telephone', 'Helium', 'Giant', 'Chipmunk', 'Ghost', 'Darth Vader', 'Reverse',
    ];

    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Default Effect'),
        content: SizedBox(
          width: 340,
          height: 360,
          child: GridView.count(
            crossAxisCount: 3,
            children: effects
                .map(
                  (e) => InkWell(
                    onTap: () {
                      context.read<SettingsCubit>().setDefaultEffect(e);
                      Navigator.pop(context);
                    },
                    child: Card(child: Center(child: Text(e, textAlign: TextAlign.center))),
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}
