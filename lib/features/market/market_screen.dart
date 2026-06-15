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
    (name: 'EGX30CAPPED', price: '62,249.00', change: '-535.12 (-0.85%)'),
    (name: 'EGX70 EWI', price: '8,412.55', change: '-62.18 (-0.73%)'),
    (name: 'EGX100 EWI', price: '12,304.10', change: '-98.22 (-0.79%)'),
  ];

  static const _turnoverByTab = {
    'Turnover': (
      lastColumn: 'Turnover',
      rows: [
        (
          ticker: 'PRDC',
          initial: 'P',
          price: '6.25',
          change: '2.63%',
          isUp: true,
          value: '1.36B',
          logoColor: Color(0xFFBA1A1A),
        ),
        (
          ticker: 'KORA',
          initial: 'K',
          price: '3.55',
          change: '19.53%',
          isUp: true,
          value: '980.16M',
          logoColor: Color(0xFF75777D),
        ),
        (
          ticker: 'GDWA',
          initial: 'G',
          price: '0.773',
          change: '-2.15%',
          isUp: false,
          value: '911.09M',
          logoColor: Color(0xFF1B1B1D),
        ),
        (
          ticker: 'CCAP',
          initial: 'C',
          price: '5.14',
          change: '-0.19%',
          isUp: false,
          value: '586.17M',
          logoColor: Color(0xFF0059C7),
        ),
        (
          ticker: 'COMI',
          initial: 'C',
          price: '131.69',
          change: '0.49%',
          isUp: true,
          value: '478.14M',
          logoColor: Color(0xFF0059C7),
        ),
      ],
    ),
    'Volume': (
      lastColumn: 'Volume',
      rows: [
        (
          ticker: 'GDWA',
          initial: 'G',
          price: '0.773',
          change: '-2.15%',
          isUp: false,
          value: '1.17B',
          logoColor: Color(0xFF1B1B1D),
        ),
        (
          ticker: 'ARAB',
          initial: 'A',
          price: '0.206',
          change: '1.98%',
          isUp: true,
          value: '311.80M',
          logoColor: Color(0xFF1B8A44),
        ),
        (
          ticker: 'KORA',
          initial: 'K',
          price: '3.55',
          change: '19.53%',
          isUp: true,
          value: '270.30M',
          logoColor: Color(0xFF75777D),
        ),
        (
          ticker: 'PRDC',
          initial: 'P',
          price: '6.25',
          change: '2.63%',
          isUp: true,
          value: '225.68M',
          logoColor: Color(0xFFBA1A1A),
        ),
        (
          ticker: 'ASPI',
          initial: 'A',
          price: '0.31',
          change: '-6.91%',
          isUp: false,
          value: '135.01M',
          logoColor: Color(0xFF45474C),
        ),
      ],
    ),
    'Gainers': (
      lastColumn: 'Volume',
      rows: [
        (
          ticker: 'KORA',
          initial: 'K',
          price: '3.55',
          change: '19.53%',
          isUp: true,
          value: '270.30M',
          logoColor: Color(0xFF75777D),
        ),
        (
          ticker: 'TYCN',
          initial: 'T',
          price: '21.65',
          change: '9.62%',
          isUp: true,
          value: '48.20M',
          logoColor: Color(0xFF0059C7),
        ),
        (
          ticker: 'ARVA',
          initial: 'A',
          price: '8.44',
          change: '8.19%',
          isUp: true,
          value: '35.10M',
          logoColor: Color(0xFF1B8A44),
        ),
        (
          ticker: 'ISMQ',
          initial: 'I',
          price: '12.30',
          change: '6.45%',
          isUp: true,
          value: '28.90M',
          logoColor: Color(0xFFBA1A1A),
        ),
        (
          ticker: 'VALU',
          initial: 'V',
          price: '5.88',
          change: '5.12%',
          isUp: true,
          value: '22.40M',
          logoColor: Color(0xFF0059C7),
        ),
      ],
    ),
    'Losers': (
      lastColumn: 'Volume',
      rows: [
        (
          ticker: 'ASPI_r3',
          initial: 'A',
          price: '0.11',
          change: '-7.56%',
          isUp: false,
          value: '72.01M',
          logoColor: Color(0xFF45474C),
        ),
        (
          ticker: 'CRST',
          initial: 'C',
          price: '1.16',
          change: '-7.20%',
          isUp: false,
          value: '51.12M',
          logoColor: Color(0xFF1B1B1D),
        ),
        (
          ticker: 'ASPI',
          initial: 'A',
          price: '0.31',
          change: '-6.91%',
          isUp: false,
          value: '135.01M',
          logoColor: Color(0xFF45474C),
        ),
        (
          ticker: 'KASABF',
          initial: 'K',
          price: '3.82',
          change: '-6.14%',
          isUp: false,
          value: '1.73M',
          logoColor: Color(0xFF75777D),
        ),
        (
          ticker: 'COSG',
          initial: 'C',
          price: '1.55',
          change: '-6.06%',
          isUp: false,
          value: '41.41M',
          logoColor: Color(0xFFBA1A1A),
        ),
      ],
    ),
  };

  List<
      ({
        String ticker,
        String initial,
        String price,
        String change,
        bool isUp,
        String value,
        Color logoColor,
      })> get _activeTurnoverRows =>
      _turnoverByTab[_turnoverTab]!.rows;

  String get _activeLastColumn => _turnoverByTab[_turnoverTab]!.lastColumn;

  static const _breadthPages = [
    (
      subtitle: 'Number OF Stocks',
      items: [
        (
          label: 'Advancing',
          value: '49',
          percent: 22.0,
          color: Color(0xFF1B8A44),
        ),
        (
          label: 'Unchanged',
          value: '17',
          percent: 7.6,
          color: Color(0xFFF59E0B),
        ),
        (
          label: 'Declining',
          value: '157',
          percent: 70.4,
          color: Color(0xFFBA1A1A),
        ),
      ],
    ),
    (
      subtitle: 'Turnover',
      items: [
        (
          label: 'Advancing',
          value: '4.68B',
          percent: 43.6,
          color: Color(0xFF1B8A44),
        ),
        (
          label: 'Unchanged',
          value: '61.87M',
          percent: 0.6,
          color: Color(0xFFF59E0B),
        ),
        (
          label: 'Declining',
          value: '5.98B',
          percent: 55.8,
          color: Color(0xFFBA1A1A),
        ),
      ],
    ),
    (
      subtitle: 'Volume',
      items: [
        (
          label: 'Advancing',
          value: '1.18B',
          percent: 31.8,
          color: Color(0xFF1B8A44),
        ),
        (
          label: 'Unchanged',
          value: '33.46M',
          percent: 0.9,
          color: Color(0xFFF59E0B),
        ),
        (
          label: 'Declining',
          value: '2.49B',
          percent: 67.3,
          color: Color(0xFFBA1A1A),
        ),
      ],
    ),
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
                          _TurnoverTable(
                            rows: _activeTurnoverRows,
                            lastColumnLabel: _activeLastColumn,
                          ),
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
                          Center(
                            child: Text(
                              _breadthPages[_breadthPage].subtitle,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: grw.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(height: _cardInnerGap),
                          Row(
                            children:
                                _breadthPages[_breadthPage].items.map((item) {
                              return Expanded(
                                child: _BreadthDonut(
                                  label: item.label,
                                  value: item.value,
                                  percent: item.percent,
                                  color: item.color,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_breadthPages.length, (i) {
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _breadthPage = i),
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: i == _breadthPage
                                        ? GrwColors.primary
                                        : grw.borderLight,
                                    shape: BoxShape.circle,
                                  ),
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
                    color: isActive ? GrwColors.primary : grw.chipInactiveText,
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
        String value,
        Color logoColor,
      })> rows;
  final String lastColumnLabel;

  const _TurnoverTable({
    required this.rows,
    required this.lastColumnLabel,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    final headerBg = context.isDarkMode
        ? const Color(0xFF528DFF).withValues(alpha: 0.1)
        : const Color(0xFFE8F0FE);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: headerBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Expanded(
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
              const Expanded(
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
              const Expanded(
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
                  lastColumnLabel,
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
                    row.value,
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
  final String value;
  final double percent;
  final Color color;

  const _BreadthDonut({
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    final trackColor = grw.borderLight.withValues(alpha: 0.4);
    final percentLabel = '${percent.toStringAsFixed(1)}%';

    return Column(
      children: [
        SizedBox(
          width: 88,
          height: 88,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
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
              Text(
                percentLabel,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
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
