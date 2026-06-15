import 'dart:async';

import 'package:flutter/material.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  static const _investmentProducts = [
    (label: 'Stocks', icon: Icons.show_chart),
    (label: 'Funds', icon: Icons.savings_outlined),
    (label: 'T-Bills', icon: Icons.explore_outlined),
  ];

  static const _gainers = [
    (initial: 'K', name: 'KORA', price: '3.55', change: '+19.53%'),
    (initial: 'T', name: 'TYCN', price: '21.65', change: '+9.62%'),
    (initial: 'A', name: 'ARVA', price: '8.44', change: '+8.19%'),
  ];

  static const _marketMap = [
    (name: 'EGX30', value: '50,818.84', change: '-0.85%'),
    (name: 'EGX70 EWI', value: '14,986.99', change: '-1.44%'),
  ];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF8FAFF),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ExploreHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionBlock(
                    title: 'INVESTMENT PRODUCTS',
                    child: Column(
                      children: _investmentProducts
                          .map(
                            (p) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _ExploreListRow(
                                label: p.label,
                                icon: p.icon,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _SectionBlock(
                    title: 'TOP 5 GAINERS',
                    child: SizedBox(
                      height: 118,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _gainers.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          final g = _gainers[i];
                          return _GainerCard(
                            initial: g.initial,
                            name: g.name,
                            price: g.price,
                            change: g.change,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const _SectionTitle('MARKET MAP'),
                      Row(
                        children: const [
                          Text(
                            'View All',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              height: 1.5,
                              color: Color(0xFF0059C7),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.chevron_right,
                            size: 11,
                            color: Color(0xFF0059C7),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: _marketMap.map((m) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: m == _marketMap.last ? 0 : 12,
                          ),
                          child: _MarketMapCard(
                            name: m.name,
                            value: m.value,
                            change: m.change,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  _SectionBlock(
                    title: 'WATCHLIST',
                    child: _ExploreListRow(
                      label: 'My Watchlist',
                      icon: Icons.bookmark_outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreHeader extends StatelessWidget {
  const _ExploreHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A64D4), Color(0xFF0E4BAF)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 16,
        16,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Explore',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  height: 1.25,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.bar_chart, color: Colors.white, size: 18),
                  const SizedBox(width: 16),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFBA1A1A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _AdBanner(),
          const SizedBox(height: 16),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, size: 15, color: Color(0xFF8AACC8)),
                SizedBox(width: 8),
                Text(
                  'Search stocks, funds...',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFF8AACC8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdBanner extends StatefulWidget {
  const _AdBanner();

  @override
  State<_AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<_AdBanner> {
  static const _slideCount = 3;
  static const _bannerHeight = 170.0;
  static const _adAsset = 'assets/images/explore_ad_banner.png';

  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _goToPage((_currentIndex + 1) % _slideCount);
    });
  }

  void _goToPage(int index) {
    if (!_pageController.hasClients) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPrev() {
    _goToPage((_currentIndex - 1 + _slideCount) % _slideCount);
    _startAutoScroll();
  }

  void _goToNext() {
    _goToPage((_currentIndex + 1) % _slideCount);
    _startAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _bannerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBE2EF)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: PageView.builder(
              controller: _pageController,
              itemCount: _slideCount,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                return ColoredBox(
                  color: Colors.white,
                  child: Image.asset(
                    _adAsset,
                    width: double.infinity,
                    height: _bannerHeight,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 9,
            right: 9,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF45474C).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'AD',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 9,
                  height: 1.5,
                  letterSpacing: 0.45,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: 9,
            top: 0,
            bottom: 0,
            child: Center(
              child: _AdNavButton(icon: Icons.chevron_left, onTap: _goToPrev),
            ),
          ),
          Positioned(
            right: 9,
            top: 0,
            bottom: 0,
            child: Center(
              child: _AdNavButton(icon: Icons.chevron_right, onTap: _goToNext),
            ),
          ),
          Positioned(
            bottom: 9,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slideCount, (i) {
                return Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: i == _currentIndex
                        ? const Color(0xFF0059C7)
                        : const Color(0xFFC5C6CD),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AdNavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0A1628).withValues(alpha: 0.05),
              blurRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, size: 12, color: const Color(0xFF1B1B1D)),
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionBlock({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: 11,
        height: 1.5,
        letterSpacing: 2,
        color: Color(0xFF8AACC8),
      ),
    );
  }
}

class _ExploreListRow extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ExploreListRow({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1628).withValues(alpha: 0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFD9E2FF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF0059C7)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF0A1628),
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 12,
            color: Color(0xFFC5C6CD),
          ),
        ],
      ),
    );
  }
}

class _GainerCard extends StatelessWidget {
  final String initial;
  final String name;
  final String price;
  final String change;

  const _GainerCard({
    required this.initial,
    required this.name,
    required this.price,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1628).withValues(alpha: 0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F5FD),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initial,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  height: 1.5,
                  color: Color(0xFF0059C7),
                ),
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF0A1628),
            ),
          ),
          Row(
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: 1.5,
                  color: Color(0xFF45474C),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  change,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    height: 1.5,
                    color: Color(0xFF1B8A44),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MarketMapCard extends StatelessWidget {
  final String name;
  final String value;
  final String change;

  const _MarketMapCard({
    required this.name,
    required this.value,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1628).withValues(alpha: 0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF0A1628),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.5,
              color: Color(0xFF45474C),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.arrow_downward,
                size: 9,
                color: Color(0xFFBA1A1A),
              ),
              Text(
                change,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: 1.5,
                  color: Color(0xFFBA1A1A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
