import 'package:flutter/material.dart';

class MyHubTab extends StatelessWidget {
  const MyHubTab({super.key});

  static const _services = [
    (label: 'Insurance', icon: Icons.shield_outlined),
    (label: 'Invest In Gold', icon: Icons.monetization_on_outlined),
    (label: 'Legal Service', icon: Icons.gavel_outlined),
  ];

  static const _marketFeed = [
    (label: 'News', icon: Icons.article_outlined),
    (label: 'Commodity Prices', icon: Icons.trending_up),
    (label: 'Economic Calendar', icon: Icons.calendar_today_outlined),
  ];

  static const _quickAccess = [
    (label: 'Subscriptions', icon: Icons.card_membership_outlined),
    (label: 'My Reports', icon: Icons.description_outlined),
    (label: 'About Us', icon: Icons.info_outline),
    (label: 'My Account', icon: Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF8FAFF),
      child: Column(
        children: [
          const _MyHubHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 23, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionBlock(
                    title: 'SERVICES',
                    child: Column(
                      children: _services
                          .map(
                            (s) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _ServiceRow(
                                label: s.label,
                                icon: s.icon,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 31),
                  _SectionBlock(
                    title: 'MARKET FEED',
                    child: SizedBox(
                      height: 104,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _marketFeed.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          final item = _marketFeed[i];
                          return _MarketFeedCard(
                            label: item.label,
                            icon: item.icon,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 31),
                  _SectionBlock(
                    title: 'QUICK ACCESS',
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const spacing = 12.0;
                        final cardWidth = (constraints.maxWidth - spacing) / 2;
                        return Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children: _quickAccess.map((q) {
                            return SizedBox(
                              width: cardWidth,
                              height: 80,
                              child: _QuickAccessCard(
                                label: q.label,
                                icon: q.icon,
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyHubHeader extends StatelessWidget {
  const _MyHubHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top,
        16,
        0,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A64D4), Color(0xFF0E4BAF)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EDEF),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0A1628).withValues(alpha: 0.05),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF45474C),
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Test Account',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'maramnowaisser+statement@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      height: 1.5,
                      color: Color(0xB3FFFFFF),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBA1A1A),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF101C2E), width: 1),
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

class _SectionBlock extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionBlock({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 13,
            height: 1.5,
            letterSpacing: 0.65,
            color: Color(0xFF8AACC8),
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _ServiceRow extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ServiceRow({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1628).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF528DFF).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF0059C7)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF1B1B1D),
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

class _MarketFeedCard extends StatelessWidget {
  final String label;
  final IconData icon;

  const _MarketFeedCard({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 111,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1628).withValues(alpha: 0.04),
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF528DFF).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: const Color(0xFF0059C7)),
          ),
          const SizedBox(height: 11),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 11,
              height: 1.5,
              color: Color(0xFF1B1B1D),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final String label;
  final IconData icon;

  const _QuickAccessCard({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1628).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF528DFF).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: const Color(0xFF0059C7)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 13,
                height: 1.25,
                color: Color(0xFF1B1B1D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
