import 'package:flutter/material.dart';

class MarketIndex {
  final String name;
  final String price;
  final String change;
  final double changePercent;

  const MarketIndex({
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
  });

  String get formattedChange {
    final sign = changePercent >= 0 ? '+' : '';
    return '$change ($sign${changePercent.toStringAsFixed(2)}%)';
  }
}

class MarketStock {
  final String symbol;
  final String price;
  final double changePercent;
  final String volume;
  final Color color;

  const MarketStock({
    required this.symbol,
    required this.price,
    required this.changePercent,
    required this.volume,
    required this.color,
  });

  bool get isUp => changePercent >= 0;

  String get initial => symbol.isNotEmpty ? symbol[0].toUpperCase() : '?';

  String get formattedChangePercent {
    final value = changePercent.abs().toStringAsFixed(2);
    return '${isUp ? '' : '-'}$value%';
  }
}

class MarketBreadthMetric {
  final double percent;
  final String value;

  const MarketBreadthMetric({
    required this.percent,
    required this.value,
  });
}

class MarketBreadth {
  final MarketBreadthMetric advancing;
  final MarketBreadthMetric unchanged;
  final MarketBreadthMetric declining;

  const MarketBreadth({
    required this.advancing,
    required this.unchanged,
    required this.declining,
  });
}

class MarketBreadthPage {
  final String subtitle;
  final MarketBreadth breadth;

  const MarketBreadthPage({
    required this.subtitle,
    required this.breadth,
  });

  List<MarketBreadthChartItem> get chartItems => [
        MarketBreadthChartItem(
          label: 'Advancing',
          value: breadth.advancing.value,
          percent: breadth.advancing.percent,
          color: MarketBreadthColors.advancing,
        ),
        MarketBreadthChartItem(
          label: 'Unchanged',
          value: breadth.unchanged.value,
          percent: breadth.unchanged.percent,
          color: MarketBreadthColors.unchanged,
        ),
        MarketBreadthChartItem(
          label: 'Declining',
          value: breadth.declining.value,
          percent: breadth.declining.percent,
          color: MarketBreadthColors.declining,
        ),
      ];
}

class MarketBreadthChartItem {
  final String label;
  final String value;
  final double percent;
  final Color color;

  const MarketBreadthChartItem({
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });
}

class MarketTurnoverTab {
  final String name;
  final String lastColumnLabel;
  final List<MarketStock> stocks;

  const MarketTurnoverTab({
    required this.name,
    required this.lastColumnLabel,
    required this.stocks,
  });
}

class MarketNewsCategory {
  final IconData icon;
  final String title;
  final String subtitle;

  const MarketNewsCategory({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

abstract final class MarketBreadthColors {
  static const advancing = Color(0xFF1B8A44);
  static const unchanged = Color(0xFFF59E0B);
  static const declining = Color(0xFFBA1A1A);
}

/// Mock market data. Swap [MarketDataProvider] methods with real API calls later.
class MarketDataProvider {
  // TODO: replace with real API call
  static List<MarketIndex> get indices => const [
        MarketIndex(
          name: 'EGX30',
          price: '50,818.84',
          change: '-437.81',
          changePercent: -0.85,
        ),
        MarketIndex(
          name: 'EGX30CAPPED',
          price: '62,249.00',
          change: '-535.12',
          changePercent: -0.85,
        ),
        MarketIndex(
          name: 'EGX70 EWI',
          price: '8,412.55',
          change: '-62.18',
          changePercent: -0.73,
        ),
        MarketIndex(
          name: 'EGX100 EWI',
          price: '12,304.10',
          change: '-98.22',
          changePercent: -0.79,
        ),
      ];

  // TODO: replace with real API call
  static String get totalTurnover => '10,824.27M';

  // TODO: replace with real API call
  static List<String> get turnoverTabNames =>
      turnoverTabs.map((tab) => tab.name).toList();

  // TODO: replace with real API call
  static List<MarketTurnoverTab> get turnoverTabs => const [
        MarketTurnoverTab(
          name: 'Turnover',
          lastColumnLabel: 'Turnover',
          stocks: [
            MarketStock(
              symbol: 'PRDC',
              price: '6.25',
              changePercent: 2.63,
              volume: '1.36B',
              color: Color(0xFFBA1A1A),
            ),
            MarketStock(
              symbol: 'KORA',
              price: '3.55',
              changePercent: 19.53,
              volume: '980.16M',
              color: Color(0xFF75777D),
            ),
            MarketStock(
              symbol: 'GDWA',
              price: '0.773',
              changePercent: -2.15,
              volume: '911.09M',
              color: Color(0xFF1B1B1D),
            ),
            MarketStock(
              symbol: 'CCAP',
              price: '5.14',
              changePercent: -0.19,
              volume: '586.17M',
              color: Color(0xFF0059C7),
            ),
            MarketStock(
              symbol: 'COMI',
              price: '131.69',
              changePercent: 0.49,
              volume: '478.14M',
              color: Color(0xFF0059C7),
            ),
          ],
        ),
        MarketTurnoverTab(
          name: 'Volume',
          lastColumnLabel: 'Volume',
          stocks: [
            MarketStock(
              symbol: 'GDWA',
              price: '0.773',
              changePercent: -2.15,
              volume: '1.17B',
              color: Color(0xFF1B1B1D),
            ),
            MarketStock(
              symbol: 'ARAB',
              price: '0.206',
              changePercent: 1.98,
              volume: '311.80M',
              color: Color(0xFF1B8A44),
            ),
            MarketStock(
              symbol: 'KORA',
              price: '3.55',
              changePercent: 19.53,
              volume: '270.30M',
              color: Color(0xFF75777D),
            ),
            MarketStock(
              symbol: 'PRDC',
              price: '6.25',
              changePercent: 2.63,
              volume: '225.68M',
              color: Color(0xFFBA1A1A),
            ),
            MarketStock(
              symbol: 'ASPI',
              price: '0.31',
              changePercent: -6.91,
              volume: '135.01M',
              color: Color(0xFF45474C),
            ),
          ],
        ),
        MarketTurnoverTab(
          name: 'Gainers',
          lastColumnLabel: 'Volume',
          stocks: [
            MarketStock(
              symbol: 'KORA',
              price: '3.55',
              changePercent: 19.53,
              volume: '270.30M',
              color: Color(0xFF75777D),
            ),
            MarketStock(
              symbol: 'TYCN',
              price: '21.65',
              changePercent: 9.62,
              volume: '48.20M',
              color: Color(0xFF0059C7),
            ),
            MarketStock(
              symbol: 'ARVA',
              price: '8.44',
              changePercent: 8.19,
              volume: '35.10M',
              color: Color(0xFF1B8A44),
            ),
            MarketStock(
              symbol: 'ISMQ',
              price: '12.30',
              changePercent: 6.45,
              volume: '28.90M',
              color: Color(0xFFBA1A1A),
            ),
            MarketStock(
              symbol: 'VALU',
              price: '5.88',
              changePercent: 5.12,
              volume: '22.40M',
              color: Color(0xFF0059C7),
            ),
          ],
        ),
        MarketTurnoverTab(
          name: 'Losers',
          lastColumnLabel: 'Volume',
          stocks: [
            MarketStock(
              symbol: 'ASPI_r3',
              price: '0.11',
              changePercent: -7.56,
              volume: '72.01M',
              color: Color(0xFF45474C),
            ),
            MarketStock(
              symbol: 'CRST',
              price: '1.16',
              changePercent: -7.20,
              volume: '51.12M',
              color: Color(0xFF1B1B1D),
            ),
            MarketStock(
              symbol: 'ASPI',
              price: '0.31',
              changePercent: -6.91,
              volume: '135.01M',
              color: Color(0xFF45474C),
            ),
            MarketStock(
              symbol: 'KASABF',
              price: '3.82',
              changePercent: -6.14,
              volume: '1.73M',
              color: Color(0xFF75777D),
            ),
            MarketStock(
              symbol: 'COSG',
              price: '1.55',
              changePercent: -6.06,
              volume: '41.41M',
              color: Color(0xFFBA1A1A),
            ),
          ],
        ),
      ];

  // TODO: replace with real API call
  static MarketTurnoverTab? turnoverTabByName(String name) {
    for (final tab in turnoverTabs) {
      if (tab.name == name) return tab;
    }
    return null;
  }

  // TODO: replace with real API call
  static List<MarketBreadthPage> get breadthPages => const [
        MarketBreadthPage(
          subtitle: 'Number OF Stocks',
          breadth: MarketBreadth(
            advancing: MarketBreadthMetric(percent: 22.0, value: '49'),
            unchanged: MarketBreadthMetric(percent: 7.6, value: '17'),
            declining: MarketBreadthMetric(percent: 70.4, value: '157'),
          ),
        ),
        MarketBreadthPage(
          subtitle: 'Turnover',
          breadth: MarketBreadth(
            advancing: MarketBreadthMetric(percent: 43.6, value: '4.68B'),
            unchanged: MarketBreadthMetric(percent: 0.6, value: '61.87M'),
            declining: MarketBreadthMetric(percent: 55.8, value: '5.98B'),
          ),
        ),
        MarketBreadthPage(
          subtitle: 'Volume',
          breadth: MarketBreadth(
            advancing: MarketBreadthMetric(percent: 31.8, value: '1.18B'),
            unchanged: MarketBreadthMetric(percent: 0.9, value: '33.46M'),
            declining: MarketBreadthMetric(percent: 67.3, value: '2.49B'),
          ),
        ),
      ];

  // TODO: replace with real API call
  static List<MarketNewsCategory> get newsCategories => const [
        MarketNewsCategory(
          icon: Icons.swap_horiz,
          title: 'Block Trades',
          subtitle: '(EGX)',
        ),
        MarketNewsCategory(
          icon: Icons.trending_up,
          title: 'Special Stock',
          subtitle: '(EGX)',
        ),
        MarketNewsCategory(
          icon: Icons.savings,
          title: 'Dividends',
          subtitle: '(EGX)',
        ),
        MarketNewsCategory(
          icon: Icons.account_balance,
          title: 'IPO News',
          subtitle: '(EGX)',
        ),
      ];

  // TODO: replace with real API call
  static String get investorClassificationMessage =>
      'No investor classification data available';
}
