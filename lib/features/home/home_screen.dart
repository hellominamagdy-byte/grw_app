import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grw_app/core/theme/grw_colors.dart';
import 'package:grw_app/features/explore/explore_screen.dart';
import 'package:grw_app/features/home/my_hub_screen.dart';
import 'package:grw_app/features/news/news_data.dart';
import 'package:grw_app/features/news/story_viewed_provider.dart';
import 'package:grw_app/features/news/story_viewer_screen.dart';
import 'package:grw_app/features/news/widgets/story_ring.dart';
import 'package:grw_app/features/wallet/wallet_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Scaffold(
      backgroundColor: grw.background,
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _HomeTab(),
          const WalletTab(),
          const ExploreTab(),
          _PlaceholderTab('Market', Icons.bar_chart_outlined),
          const MyHubTab(),
        ],
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

// ─── Bottom Navigation ────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  static const _items = [
    ('Home', Icons.home_outlined, Icons.home),
    ('Wallet', Icons.account_balance_wallet_outlined,
        Icons.account_balance_wallet),
    ('Explore', Icons.explore_outlined, Icons.explore),
    ('Market', Icons.bar_chart_outlined, Icons.bar_chart),
    ('My Hub', Icons.person_outline, Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: grw.navBar,
            boxShadow: [
              BoxShadow(
                color: grw.cardShadow,
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_items.length, (i) {
                  final (label, icon, activeIcon) = _items[i];
                  final active = i == currentIndex;
                  return GestureDetector(
                    onTap: () => onTap(i),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: active
                          ? const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4)
                          : const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                      decoration: active
                          ? BoxDecoration(
                              color: grw.navActiveBg,
                              borderRadius: BorderRadius.circular(999),
                            )
                          : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            active ? activeIcon : icon,
                            color: active
                                ? grw.primaryAction
                                : grw.navInactive,
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            label,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: active
                                  ? grw.primaryAction
                                  : grw.navInactive,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Home Tab ─────────────────────────────────────────────────────────────────

class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PortfolioCard(),
                const SizedBox(height: 32),
                _DailyNewsSection(),
                const SizedBox(height: 32),
                _MyInvestmentsSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Top Bar ──────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    final now = DateTime.now();
    final dateStr = DateFormat('EEE, MMM d, y').format(now);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          color: grw.headerBar.withValues(alpha: 0.8),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8,
            bottom: 16,
            left: 24,
            right: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatar + greeting
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0059C7),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'M',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Mina!',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: grw.textPrimary,
                          height: 1.25,
                        ),
                      ),
                      Text(
                        dateStr,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: grw.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // EGP pill + GRW logo
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 5),
                    decoration: BoxDecoration(
                      color: grw.card,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: grw.borderLight),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'EGP',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: grw.textPrimary,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down,
                            size: 14, color: grw.textSecondary),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'GRW',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: GrwColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Portfolio Card ───────────────────────────────────────────────────────────

class _PortfolioCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [grw.balanceGradientStart, grw.balanceGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: grw.balanceGradientStart.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circle
          Positioned(
            right: -64,
            top: -128,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label + eye
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL PORTFOLIO VALUE',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                      letterSpacing: 0.6,
                    ),
                  ),
                  Icon(Icons.visibility_outlined,
                      color: Colors.white.withValues(alpha: 0.8), size: 20),
                ],
              ),
              const SizedBox(height: 8),

              // Amount
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '516,831.27 ',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 40,
                        color: Colors.white,
                        letterSpacing: -1.92,
                        height: 1.4,
                      ),
                    ),
                    TextSpan(
                      text: 'EGP',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Return row
              Row(
                children: [
                  Text(
                    'Total Return: -2,128,523.28 EGP',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFFBA1A1A).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_downward,
                            color: Color(0xFFFFDAD6), size: 10),
                        SizedBox(width: 2),
                        Text(
                          '80.46%',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            color: Color(0xFFFFDAD6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),

              // Divider
              Divider(
                  color: Colors.white.withValues(alpha: 0.2), height: 1),
              const SizedBox(height: 17),

              // Total invested
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL INVESTED',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const Text(
                    '2,645,354.55 EGP',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Daily News Section ───────────────────────────────────────────────────────

class _DailyNewsSection extends ConsumerWidget {
  static const _categories = [
    (
      label: 'Top 10\nTrending',
      categoryKey: 'Top 10 Trending',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/8e1584c2-7eb2-4964-9cd1-dbf407542377',
    ),
    (
      label: 'Finance &\nBanking',
      categoryKey: 'Finance & Banking',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/e75ffab8-f276-4683-99a1-2c92a73272a7',
    ),
    (
      label: 'Real Estate\nNews',
      categoryKey: 'Real Estate News',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/45d63bae-1d5e-4a00-be16-8bf5197efd3c',
    ),
    (
      label: 'Market\nWatch',
      categoryKey: 'Market Watch',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/133e678e-5754-4b9f-86ae-d6740e5bbd6d',
    ),
  ];

  const _DailyNewsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grw = context.grw;
    final viewedIds = ref.watch(storyViewedProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily News',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: grw.textPrimary,
                    height: 1.4,
                  ),
                ),
                Text(
                  'Get the latest news in the market today',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: grw.textSecondary,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => context.push('/news-list'),
              behavior: HitTestBehavior.opaque,
              child: const Text(
                'See More >',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: GrwColors.primary,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _categories.map((category) {
            final articles = NewsData.byCategory(category.categoryKey);
            return StoryRing(
              label: category.label,
              imageUrl: category.imageUrl,
              articleIds: articles.map((a) => a.id).toList(),
              viewedArticleIds: viewedIds,
              onTap: () => showStoryViewerSheet(
                context,
                category: category.categoryKey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ─── My Investments Section ───────────────────────────────────────────────────

class _MyInvestmentsSection extends StatelessWidget {
  static const _investments = [
    (
      initials: 'AF',
      name: 'AF Securities',
      subtitle: '6,002 Units',
      bgColor: Color(0xFFEAE7E9),
      textColor: Color(0xFF45474C),
      price: '0.00 EGP',
      change: '↓100.00%',
      isLoss: true,
    ),
    (
      initials: 'GO',
      name: 'GOCO',
      subtitle: 'Golden Coast • 2 Stocks',
      bgColor: Color(0xFF1B8A44),
      textColor: Colors.white,
      price: '1.04 EGP',
      change: '↓81.90%',
      isLoss: true,
    ),
    (
      initials: 'BT',
      name: 'BTFH',
      subtitle: 'Beltone Fina.. • 3 Stocks',
      bgColor: Color(0xFF0059C7),
      textColor: Colors.white,
      price: '3.20 EGP',
      change: '↓33.30%',
      isLoss: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Investments',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: grw.textPrimary,
                height: 1.4,
              ),
            ),
            const Text(
              'See All',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: GrwColors.primary,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._investments.map((inv) => _InvestmentItem(
              initials: inv.initials,
              name: inv.name,
              subtitle: inv.subtitle,
              bgColor: inv.bgColor,
              textColor: inv.textColor,
              price: inv.price,
              change: inv.change,
              isLoss: inv.isLoss,
            )),
      ],
    );
  }
}

class _InvestmentItem extends StatelessWidget {
  final String initials;
  final String name;
  final String subtitle;
  final Color bgColor;
  final Color textColor;
  final String price;
  final String change;
  final bool isLoss;

  const _InvestmentItem({
    required this.initials,
    required this.name,
    required this.subtitle,
    required this.bgColor,
    required this.textColor,
    required this.price,
    required this.change,
    required this.isLoss,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: grw.investmentCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: grw.border),
        boxShadow: [
          BoxShadow(
            color: grw.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: grw.textPrimary,
                      height: 1.25,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: grw.textSecondary,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: grw.textPrimary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: isLoss
                      ? grw.lossAmount.withValues(alpha: 0.1)
                      : grw.gainBadgeText.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      isLoss ? Icons.arrow_downward : Icons.arrow_upward,
                      size: 8,
                      color: isLoss ? grw.lossAmount : grw.gainBadgeText,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      change.replaceAll('↓', '').replaceAll('↑', ''),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        color: isLoss ? grw.lossAmount : grw.gainBadgeText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Placeholder Tab ──────────────────────────────────────────────────────────

class _PlaceholderTab extends StatelessWidget {
  final String name;
  final IconData icon;

  const _PlaceholderTab(this.name, this.icon);

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: GrwColors.primary),
          const SizedBox(height: 16),
          Text(
            '$name — Coming Soon',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              color: grw.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
