class RemoteAdsConfig {
  const RemoteAdsConfig({
    required this.bannerId,
    required this.interstitialId,
    required this.status,
    required this.appName,
  });

  final String bannerId;
  final String interstitialId;
  final String status;
  final String appName;

  bool get isActive => status.toLowerCase() == 'active';

  factory RemoteAdsConfig.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as Map<String, dynamic>? ?? <String, dynamic>{});
    return RemoteAdsConfig(
      appName: (data['appName'] as String? ?? '').trim(),
      bannerId: (data['banner_id'] as String? ?? '').trim(),
      interstitialId: (data['inter_id'] as String? ?? '').trim(),
      status: (data['status'] as String? ?? '').trim(),
    );
  }
}
