import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/ads/ad_service.dart';
import '../../../../injection.dart';
import '../../widgets/feature_card.dart';
import '../../widgets/gradient_hero_card.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AdService _adService;

  @override
  void initState() {
    super.initState();
    _adService = getIt<AdService>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(const HomeStarted()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          title: const Text('Voice Changer'),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (context) => const [PopupMenuItem(value: 'settings', child: Text('Settings'))],
              onSelected: (v) => context.push('/settings'),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientHeroCard(
                      onStart: () async {
                        await _adService.showInterstitialIfReady();
                        if (!context.mounted) return;
                        context.push('/prank-sound');
                      },
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: 1.25,
                      children: [
                        FeatureCard(
                          title: 'Record & Change',
                          subtitle: 'Record and edit voice',
                          emoji: '🎙️',
                          colors: const [AppColors.featureRecordStart, AppColors.featureRecordEnd],
                          onTap: () => context.push('/recording'),
                        ),
                        FeatureCard(
                          title: 'Text To Audio',
                          subtitle: 'Speak your text',
                          emoji: '🎧',
                          colors: const [AppColors.featureTtsStart, AppColors.featureTtsEnd],
                          onTap: () => context.push('/text-to-audio'),
                        ),
                        FeatureCard(
                          title: 'Reverse Voice',
                          subtitle: 'Flip your speech',
                          emoji: '🔁',
                          colors: const [AppColors.featureReverseStart, AppColors.featureReverseEnd],
                          onTap: () => context.push('/reverse-voice'),
                        ),
                        FeatureCard(
                          title: 'Switch Voice',
                          subtitle: 'Live transformations',
                          emoji: '🔀',
                          colors: const [AppColors.featureSwitchStart, AppColors.featureSwitchEnd],
                          onTap: () => context.push('/switch-voice'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Text('Voice Effects', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        TextButton(onPressed: () => context.push('/add-effect'), child: const Text('See all')),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.effects.length,
                            itemBuilder: (context, index) {
                              final parts = state.effects[index].split(' ');
                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    CircleAvatar(radius: 28, child: Text(parts.first, style: const TextStyle(fontSize: 24))),
                                    const SizedBox(height: 4),
                                    Text(parts.skip(1).join(' '), style: const TextStyle(fontSize: 11)),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<BannerAd?>(
              valueListenable: _adService.bannerNotifier,
              builder: (context, bannerAd, _) {
                if (bannerAd == null) {
                  return const SizedBox.shrink();
                }
                return SizedBox(
                  width: bannerAd.size.width.toDouble(),
                  height: bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: bannerAd),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
