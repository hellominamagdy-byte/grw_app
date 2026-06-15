import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:grw_app/core/theme/grw_colors.dart';
import 'package:grw_app/features/market/market_data.dart';

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
  final PageController _breadthPageController = PageController();

  @override
  void dispose() {
    _breadthPageController.dispose();
    super.dispose();
  }

  void _goBreadthPrev() {
    if (_breadthPage > 0) {
      _breadthPageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goBreadthNext() {
    if (_breadthPage < MarketDataProvider.breadthPages.length - 1) {
      _breadthPageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goBreadthPage(int index) {
    _breadthPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<MarketStock> get _activeTurnoverRows =>
      MarketDataProvider.turnoverTabByName(_turnoverTab)?.stocks ?? [];

  String get _activeLastColumn =>
      MarketDataProvider.turnoverTabByName(_turnoverTab)?.lastColumnLabel ??
      'Volume';

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;
    final indices = MarketDataProvider.indices;
    final breadthPages = MarketDataProvider.breadthPages;
    final newsCategories = MarketDataProvider.newsCategories;

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
                            children: indices.map((index) {
                              return Expanded(
                                child: _IndexItem(index: index),
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
                              Text(
                                MarketDataProvider.totalTurnover,
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
                            tabs: MarketDataProvider.turnoverTabNames,
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
                              breadthPages[_breadthPage].subtitle,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: grw.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(height: _cardInnerGap),
                          SizedBox(
                            height: 136,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                PageView.builder(
                                  controller: _breadthPageController,
                                  onPageChanged: (index) =>
                                      setState(() => _breadthPage = index),
                                  itemCount: breadthPages.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: breadthPages[index]
                                          .chartItems
                                          .map((item) {
                                        return Expanded(
                                          child: _BreadthDonut(
                                            label: item.label,
                                            value: item.value,
                                            percent: item.percent,
                                            color: item.color,
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                                Positioned(
                                  left: -4,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: _BreadthNavArrow(
                                      icon: Icons.chevron_left,
                                      enabled: _breadthPage > 0,
                                      onTap: _goBreadthPrev,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -4,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: _BreadthNavArrow(
                                      icon: Icons.chevron_right,
                                      enabled: _breadthPage <
                                          breadthPages.length - 1,
                                      onTap: _goBreadthNext,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(breadthPages.length, (i) {
                              return GestureDetector(
                                onTap: () => _goBreadthPage(i),
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
                              MarketDataProvider.investorClassificationMessage,
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
                                  category: newsCategories[left],
                                ),
                              ),
                              const SizedBox(width: spacing),
                              SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: _NewsCategoryCard(
                                  category: newsCategories[right],
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
  final MarketIndex index;

  const _IndexItem({required this.index});

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
            index.name,
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
          index.price,
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
          index.formattedChange,
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
  final List<MarketStock> rows;
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
        ...rows.map((stock) {
          final changeColor =
              stock.isUp ? GrwColors.gain : grw.lossAmount;
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
                          color: stock.color,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          stock.initial,
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
                        stock.symbol,
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
                        stock.price,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: grw.textPrimary,
                        ),
                      ),
                      Icon(
                        stock.isUp
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        size: 16,
                        color: changeColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    stock.formattedChangePercent,
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
                    stock.volume,
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

class _BreadthNavArrow extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _BreadthNavArrow({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final grw = context.grw;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: grw.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0A1628).withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? grw.textPrimary : grw.borderLight,
        ),
      ),
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
      mainAxisSize: MainAxisSize.min,
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
            height: 1.1,
            color: grw.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            height: 1.1,
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
  final MarketNewsCategory category;

  const _NewsCategoryCard({required this.category});

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
              category.icon,
              size: 20,
              color: GrwColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            category.title,
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
            category.subtitle,
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
