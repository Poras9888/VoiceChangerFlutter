import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import 'remote_ads_config.dart';

class RemoteAdsConfigService {
  Future<RemoteAdsConfig?> fetchRemoteConfig() async {
    final uri = Uri.parse(
      '${AppConstants.remoteAdsBaseEndpoint}?appName=${AppConstants.remoteAdsAppName}',
    );
    final response = await http.get(uri).timeout(const Duration(seconds: 8));

    if (response.statusCode != 200) {
      return null;
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    final success = decoded['success'] == true;
    if (!success) {
      return null;
    }

    final config = RemoteAdsConfig.fromJson(decoded);
    if (!config.isActive) {
      return null;
    }

    if (config.bannerId.isEmpty || config.interstitialId.isEmpty) {
      return null;
    }

    return config;
  }
}
