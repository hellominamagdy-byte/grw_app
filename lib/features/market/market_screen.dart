import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:grw_app/core/theme/grw_colors.dart';

class MarketTab extends StatefulWidget {
  const MarketTab({super.key});

  @override
  State<MarketTab> createState() => _MarketTabState();
}

class _MarketTabState extends State<MarketTab> {
  static const _sectionGap = 12.0;
  static const _cardInnerGap = 12.0;

  String _turnoverTab = 'Turnover';
  bool _investorByPercent = true;
  int _breadthPage = 0;

  static const _turnoverTabs = ['Turnover', 'Volume', 'Gainers', 'Losers'];

  static const _indices = [
    (name: 'EGX30', price: '50,818.84', change: '-437.81 (-0.85%)'),
    (name: 'EGX30CAPPED', price: '14,986.99', change: '-215.40 (-1.44%)'),
    (name: 'EGX70 EWI', price: '8,412.55', change: '-62.18 (-0.73%)'),
    (name: 'EGX100 EWI', price: '12,304.10', change: '-98.22 (-0.79%)'),
  ];

  static const _turnoverRows = [
    (
      ticker: 'PRDC',
      initial: 'P',
      price: '6.25',
      change: '2.63%',
      isUp: true,
      turnover: '1.36B',
      logoColor: Color(0xFFBA1A1A),
    ),
    (
      ticker: 'KORA',
      initial: 'K',
      price: '3.55',
      change: '19.53%',
      isUp: true,
      turnover: '980.16M',
      logoColor: Color(0xFF75777D),
    ),
    (
      ticker: 'GDWA',
      initial: 'G',
      price: '0.773',
      change: '-2.15%',
      isUp: false,
      turnover: '911.09M',
      logoColor: Color(0xFF1B1B1D),
    ),
    (
      ticker: 'CCAP',
      initial: 'C',
      price: '5.14',
      change: '-0.19%',
      isUp: false,
      turnover: '586.17M',
      logoColor: Color(0xFF0059C7),
    ),
    (
      ticker: 'COMI',
      initial: 'C',
      price: '131.69',
      change: '0.49%',
      isUp: true,
      turnover: '478.14M',
      logoColor: Color(0xFF0059C7),
    ),
  ];

  static const _breadth = [
    (label: 'Advancing', count: '49', percent: 22.0, color: Color(0xFF1B8A44)),
    (label: 'Unchanged', count: '17', percent: 7.6, color: Color(0xFFF59E0B)),
    (label: 'Declining', count: '157', percent: 70.4, color: Color(0xFFBA1A1A)),
  ];

  static const _newsCategories = [
    (icon: Icons.swap_horiz, title: 'Block Trades', subtitle: '(EGX)'),
    (icon: Icons.trending_up, title: 'Special Stock', subtitle: '(EGX)'),
    (icon: Icons.savings, title: 'Dividends', subtitle: '(EGX)'),
    (icon: Icons.account_balance, title: 'IPO News', subtitle: '(EGX)'),
  ];

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;

    return ColoredBox(
      color: GrwColors.primary,
      child: Column(
        children: [
          _MarketHeader(topPadding: MediaQuery.paddingOf(context).top),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: grw.background,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MarketCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionHeader(
                            title: 'Market Indices',
                            action: 'See More',
                          ),
                          const SizedBox(height: _cardInnerGap),
                          Row(
                            children: _indices.map((index) {
                              return Expanded(
                                child: _IndexItem(
                                  name: index.name,
                                  price: index.price,
                                  change: index.change,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: _sectionGap),
                    _MarketCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'MKT. Turnover',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: grw.textPrimary,
                                ),
                              ),
                              const Text(
                                '10,824.27M',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: GrwColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: _cardInnerGap),
                          _TurnoverTabs(
                            tabs: _turnoverTabs,
                            selected: _turnoverTab,
                            onSelected: (tab) =>
                                setState(() => _turnoverTab = tab),
                          ),
                          const SizedBox(height: _cardInnerGap),
                          _TurnoverTable(rows: _turnoverRows),
                        ],
                      ),
                    ),
                    const SizedBox(height: _sectionGap),
                    _MarketCard(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Market Breadth',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: grw.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Number OF Stocks',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: grw.textSecondary,
                            ),
                          ),
                          const SizedBox(height: _cardInnerGap),
                          Row(
                            children: _breadth.map((item) {
                              return Expanded(
                                child: _BreadthDonut(
                                  label: item.label,
                                  count: item.count,
                                  percent: item.percent,
                                  color: item.color,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (i) {
                              return Container(
                                width: 6,
                                height: 6,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  color: i == _breadthPage
                                      ? GrwColors.primary
                                      : grw.borderLight,
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: _sectionGap),
                    _MarketCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Investor Classification',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: grw.textPrimary,
                                ),
                              ),
                              _PercentHashToggle(
                                byPercent: _investorByPercent,
                                onChanged: (value) =>
                                    setState(() => _investorByPercent = value),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              'No investor classification data available',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: grw.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Market News',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: grw.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const spacing = 12.0;
                        const cardHeight = 112.0;
                        final cardWidth = (constraints.maxWidth - spacing) / 2;

                        Widget row(int left, int right) {
                          return Row(
                            children: [
                              SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: _NewsCategoryCard(
                                  icon: _newsCategories[left].icon,
                                  title: _newsCategories[left].title,
                                  subtitle: _newsCategories[left].subtitle,
                                ),
                              ),
                              const SizedBox(width: spacing),
                              SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: _NewsCategoryCard(
                                  icon: _newsCategories[right].icon,
                                  title: _newsCategories[right].title,
                                  subtitle: _newsCategories[right].subtitle,
                                ),
                              ),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            row(0, 1),
                            const SizedBox(height: spacing),
                            row(2, 3),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MarketTab(),
    );
  }
}

class _MarketHeader extends StatelessWidget {
  final double topPadding;

  const _MarketHeader({required this.topPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, topPadding + 12, 16, 16),
      color: GrwColors.primary,
      child: const Text(
        'Market',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }
}

class _MarketCard extends StatelessWidget {
  final Widget child;

  const _MarketCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: grw.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: grw.cardShadow,
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String action;

  const _SectionHeader({required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: grw.textPrimary,
          ),
        ),
        Row(
          children: [
            Text(
              action,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: GrwColors.primary,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.chevron_right, size: 12, color: GrwColors.primary),
          ],
        ),
      ],
    );
  }
}

class _IndexItem extends StatelessWidget {
  final String name;
  final String price;
  final String change;

  const _IndexItem({
    required this.name,
    required this.price,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: GrwColors.loss, width: 1.5),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 9,
              height: 1.2,
              color: grw.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          price,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: grw.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          change,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 9,
            color: GrwColors.loss,
          ),
        ),
      ],
    );
  }
}

class _TurnoverTabs extends StatelessWidget {
  final List<String> tabs;
  final String selected;
  final ValueChanged<String> onSelected;

  const _TurnoverTabs({
    required this.tabs,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: grw.searchField,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: tabs.map((tab) {
          final isActive = tab == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? grw.card : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: grw.cardShadow,
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: isActive ? GrwColors.primary : grw.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TurnoverTable extends StatelessWidget {
  final List<
      ({
        String ticker,
        String initial,
        String price,
        String change,
        bool isUp,
        String turnover,
        Color logoColor,
      })> rows;

  const _TurnoverTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF528DFF).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: GrwColors.primary,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Price',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: GrwColors.primary,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'chg %',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: GrwColors.primary,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Turnover',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: GrwColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...rows.map((row) {
          final changeColor =
              row.isUp ? GrwColors.gain : grw.lossAmount;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: grw.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: row.logoColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          row.initial,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        row.ticker,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: grw.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        row.price,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: grw.textPrimary,
                        ),
                      ),
                      Icon(
                        row.isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        size: 16,
                        color: changeColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    row.change,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: changeColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    row.turnover,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: GrwColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _BreadthDonut extends StatelessWidget {
  final String label;
  final String count;
  final double percent;
  final Color color;

  const _BreadthDonut({
    required this.label,
    required this.count,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    final trackColor = grw.borderLight.withValues(alpha: 0.4);

    return Column(
      children: [
        SizedBox(
          width: 88,
          height: 88,
          child: PieChart(
            PieChartData(
              startDegreeOffset: -90,
              sectionsSpace: 0,
              centerSpaceRadius: 30,
              sections: [
                PieChartSectionData(
                  value: percent,
                  color: color,
                  radius: 12,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: 100 - percent,
                  color: trackColor,
                  radius: 12,
                  showTitle: false,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${percent.toStringAsFixed(1)}%',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          count,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: grw.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _PercentHashToggle extends StatelessWidget {
  final bool byPercent;
  final ValueChanged<bool> onChanged;

  const _PercentHashToggle({
    required this.byPercent,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: grw.searchField,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleChip(
            label: '%',
            active: byPercent,
            onTap: () => onChanged(true),
          ),
          _ToggleChip(
            label: '#',
            active: !byPercent,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _ToggleChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? grw.card : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: grw.cardShadow,
                    blurRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: active ? GrwColors.primary : grw.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _NewsCategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _NewsCategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    final iconBg = context.isDarkMode
        ? grw.iconCircleBg
        : const Color(0xFFE8F0FE);

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: grw.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: grw.cardShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: GrwColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 13,
              height: 1.3,
              color: grw.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              height: 1.3,
              color: grw.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
