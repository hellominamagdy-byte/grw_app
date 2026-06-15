class NewsArticle {
  final String id;
  final String category;
  final String title;
  final String body;
  final String imageUrl;
  final String source;
  final String date;

  const NewsArticle({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.imageUrl,
    required this.source,
    required this.date,
  });
}

class NewsListCategory {
  final String label;

  const NewsListCategory(this.label);
}

class FeaturedNewsCard {
  final String id;
  final String tag;
  final String title;
  final String imageUrl;
  final String filterCategory;

  const FeaturedNewsCard({
    required this.id,
    required this.tag,
    required this.title,
    required this.imageUrl,
    required this.filterCategory,
  });
}

class NewsData {
  static String _image(String seed) =>
      'https://picsum.photos/seed/$seed/400/600';

  static const _topTrending = [
    (
      'EGX30 Rises 1.8% as Foreign Investors Return to Egyptian Equities',
      'The Egyptian Exchange benchmark index climbed on strong buying interest from regional funds, with banking and telecom names leading the session.',
      'Arab Finance',
      '14/06/2026 09:15',
    ),
    (
      'Central Bank Signals Stable Policy as Inflation Cools',
      'The CBE indicated it will maintain a data-dependent approach while core inflation continues its gradual descent toward target levels.',
      'Al Mal',
      '14/06/2026 08:40',
    ),
    (
      'Suez Canal Revenue Rebounds on Improved Global Trade Flows',
      'Canal authority data showed a notable pickup in transit volumes as shipping routes normalize and container demand strengthens.',
      'Reuters',
      '13/06/2026 16:20',
    ),
    (
      'Egyptian Fintech Startups Attract Record Venture Funding',
      'Payments and lending platforms secured the largest share of new capital, reflecting growing digital adoption across retail banking.',
      'Enterprise',
      '13/06/2026 11:05',
    ),
    (
      'Remittances Hit New High, Supporting FX Reserves',
      'Official figures showed expatriate transfers rose year-on-year, providing additional support for the local currency and import coverage.',
      'Masrawy',
      '12/06/2026 14:30',
    ),
    (
      'Oil Prices Edge Higher on Middle East Supply Concerns',
      'Brent crude gained as traders priced in tighter near-term supply, with implications for Egypt\'s import bill and subsidy framework.',
      'Bloomberg',
      '12/06/2026 10:00',
    ),
    (
      'Tourism Receipts Boost Services Sector Outlook',
      'Hotel occupancy and airport arrivals improved ahead of the summer season, lifting expectations for Q3 current account performance.',
      'Ahram Online',
      '11/06/2026 15:45',
    ),
    (
      'Telecom Operators Invest in 5G Rollout Across Major Cities',
      'Network upgrades are expected to accelerate digital services adoption and support enterprise cloud migration in Cairo and Alexandria.',
      'Arab Finance',
      '11/06/2026 09:20',
    ),
    (
      'Sovereign Eurobond Demand Remains Strong at Auction',
      'Investors showed sustained appetite for Egyptian paper amid improving macro visibility and attractive carry relative to peers.',
      'Financial Times',
      '10/06/2026 13:10',
    ),
    (
      'Industrial Production Index Posts Modest Monthly Gain',
      'Manufacturing output improved on stronger domestic orders, though exporters remain cautious about global demand softness.',
      'Daily News Egypt',
      '10/06/2026 08:55',
    ),
  ];

  static const _financeBanking = [
    (
      'Commercial Banks Report Higher Net Interest Margins',
      'Lenders benefited from the rate environment and improved loan mix, with asset quality metrics remaining broadly stable.',
      'Al Mal',
      '14/06/2026 10:30',
    ),
    (
      'CBE Maintains Overnight Deposit Rate at Latest MPC Meeting',
      'The committee emphasized balancing growth and price stability while monitoring food and energy price developments.',
      'Arab Finance',
      '14/06/2026 09:00',
    ),
    (
      'Retail Deposits Grow as Savers Seek Higher Yields',
      'Time deposits and savings products saw inflows as households responded to attractive fixed-income alternatives.',
      'Enterprise',
      '13/06/2026 17:00',
    ),
    (
      'Islamic Banking Assets Expand Faster Than Conventional Peers',
      'Sharia-compliant financing gained share in corporate and SME segments, supported by new product launches.',
      'Masrawy',
      '13/06/2026 12:15',
    ),
    (
      'NPL Ratio Edges Lower Across Listed Banks',
      'Provisions and recoveries helped reduce non-performing exposure, though selective sector stress remains in trade finance.',
      'Arab Finance',
      '12/06/2026 15:40',
    ),
    (
      'Mobile Wallet Transactions Surpass Cash at Major Merchants',
      'Digital payment penetration accelerated in urban retail, with QR adoption rising among small businesses.',
      'Al Mal',
      '12/06/2026 11:25',
    ),
    (
      'Corporate Lending Pipeline Strengthens Ahead of FY Close',
      'Banks reported healthy demand for working capital and capex facilities from industrial and consumer names.',
      'Reuters',
      '11/06/2026 14:50',
    ),
    (
      'Treasury Bill Auctions Oversubscribed as Yields Stabilize',
      'Local institutions dominated bidding, reflecting continued appetite for short-duration government paper.',
      'Bloomberg',
      '11/06/2026 10:10',
    ),
    (
      'Microfinance Institutions See Rising Female Borrower Share',
      'Inclusive finance programs expanded in Upper Egypt, supporting small enterprise growth outside major cities.',
      'Ahram Online',
      '10/06/2026 16:35',
    ),
    (
      'Banking Sector Capital Adequacy Ratios Remain Well Above Minimums',
      'Regulatory buffers provide room for dividend distributions while supporting planned credit expansion.',
      'Arab Finance',
      '10/06/2026 09:45',
    ),
  ];

  static const _realEstate = [
    (
      'New Cairo Apartment Prices Hold Firm Despite Higher Rates',
      'Developers reported steady absorption in mid-income projects, with buyers favoring flexible payment plans.',
      'Aqarmap',
      '14/06/2026 08:20',
    ),
    (
      'North Coast Summer Units See Early Booking Momentum',
      'Seasonal demand picked up along the Mediterranean coast as developers launch limited premium inventory.',
      'Enterprise',
      '13/06/2026 18:00',
    ),
    (
      'Government Social Housing Allocations Open in Three Governorates',
      'Eligible applicants can register for subsidized units under the latest national housing initiative.',
      'Youm7',
      '13/06/2026 13:30',
    ),
    (
      'Commercial Office Vacancy Falls in New Administrative Capital',
      'Corporate relocations and BPO expansion supported occupancy in Grade A buildings.',
      'Arab Finance',
      '12/06/2026 11:50',
    ),
    (
      'Mortgage Lending Grows on Improved Affordability Programs',
      'Banks partnered with developers to offer longer tenors and lower down payments for first-time buyers.',
      'Al Mal',
      '12/06/2026 09:35',
    ),
    (
      'Construction Material Costs Ease, Supporting Project Margins',
      'Cement and steel prices moderated month-on-month, easing pressure on contractor bids.',
      'Masrawy',
      '11/06/2026 15:10',
    ),
    (
      'Sixth Settlement Townhouses Attract End-User Demand',
      'Family-oriented communities with schools and retail outperformed speculative investment zones.',
      'Aqarmap',
      '11/06/2026 10:40',
    ),
    (
      'Hotel-Linked Residential Projects Launch on Red Sea Coast',
      'Mixed-use resorts combine hospitality assets with branded residences targeting Gulf buyers.',
      'Reuters',
      '10/06/2026 14:25',
    ),
    (
      'Rental Yields Improve in Zamalek and Maadi Districts',
      'Expatriate demand supported lease rates in established Cairo neighborhoods.',
      'Enterprise',
      '10/06/2026 08:15',
    ),
    (
      'Real Estate Developers Announce Green Building Standards',
      'New projects will target energy efficiency certifications to appeal to institutional investors.',
      'Daily News Egypt',
      '09/06/2026 12:00',
    ),
  ];

  static const _marketWatch = [
    (
      'EGX30 Closes Higher Led by Commercial International Bank',
      'The main index gained ground as heavyweight financials rallied on earnings optimism and dividend expectations.',
      'Arab Finance',
      '14/06/2026 16:05',
    ),
    (
      'EGX70 EWI Declines on Profit-Taking in Small Caps',
      'Broader market weakness reflected selective selling after a multi-session rally in industrial names.',
      'Al Mal',
      '14/06/2026 15:30',
    ),
    (
      'Foreign Investors Net Buyers for Third Straight Session',
      'Cross-border flows turned positive amid improving sentiment on Egypt\'s reform trajectory.',
      'Bloomberg',
      '13/06/2026 16:45',
    ),
    (
      'Gold Hits Intraday High as Safe-Haven Demand Returns',
      'Precious metals rallied on geopolitical uncertainty, benefiting mining-linked equities globally.',
      'Reuters',
      '13/06/2026 11:20',
    ),
    (
      'Copper Prices Rebound on China Stimulus Hopes',
      'Industrial metals gained, supporting global materials stocks and commodity-sensitive EM assets.',
      'Financial Times',
      '12/06/2026 14:15',
    ),
    (
      'Dollar Index Softens, EM Currencies Firm Slightly',
      'A weaker greenback provided breathing room for emerging market debt and equity valuations.',
      'Masrawy',
      '12/06/2026 10:50',
    ),
    (
      'Sector Rotation Favors Defensive Utilities and Healthcare',
      'Investors shifted toward stable dividend payers as volatility picked up in growth segments.',
      'Arab Finance',
      '11/06/2026 15:55',
    ),
    (
      'Trading Volumes Rise 12% Week-on-Week on EGX',
      'Higher turnover reflected increased participation from retail and institutional accounts.',
      'Enterprise',
      '11/06/2026 09:10',
    ),
    (
      'Technical Analysts Eye Resistance at Prior EGX30 Peak',
      'Chart patterns suggest momentum could extend if the index clears key levels with volume support.',
      'Al Mal',
      '10/06/2026 13:40',
    ),
    (
      'Weekly Market Wrap: Banks Outperform, Real Estate Mixed',
      'Financials led gains while property names diverged on company-specific project updates.',
      'Arab Finance',
      '10/06/2026 08:30',
    ),
  ];

  static List<NewsArticle> _articlesForCategory(
    String category,
    String idPrefix,
    List<(String, String, String, String)> items,
  ) {
    return List.generate(items.length, (index) {
      final (title, body, source, date) = items[index];
      final n = index + 1;
      return NewsArticle(
        id: '$idPrefix-$n',
        category: category,
        title: title,
        body: body,
        imageUrl: _image('${idPrefix}$n'),
        source: source,
        date: date,
      );
    });
  }

  static final List<NewsArticle> articles = [
    ..._articlesForCategory('Top 10 Trending', 'trending', _topTrending),
    ..._articlesForCategory('Finance & Banking', 'finance', _financeBanking),
    ..._articlesForCategory('Real Estate News', 'realestate', _realEstate),
    ..._articlesForCategory('Market Watch', 'market', _marketWatch),
  ];

  static List<NewsArticle> byCategory(String category) =>
      articles.where((a) => a.category == category).toList();

  static NewsArticle? articleById(String id) =>
      articles.where((a) => a.id == id).firstOrNull;

  static const listCategories = [
    NewsListCategory('Macroeconomic'),
    NewsListCategory('Finance & Banking'),
    NewsListCategory('Real Estate'),
    NewsListCategory('Markets'),
    NewsListCategory('Trade'),
  ];

  static const featuredCards = [
    FeaturedNewsCard(
      id: 'featured-1',
      tag: 'MARKETS',
      title: 'Tech Equities Surge as Q4 Earnings Exceed Expectations',
      imageUrl: 'https://picsum.photos/seed/featured1/400/400',
      filterCategory: 'Markets',
    ),
    FeaturedNewsCard(
      id: 'featured-2',
      tag: 'MARKETS',
      title: 'Tech Equities Surge as Q4 Earnings Exceed Expectations',
      imageUrl: 'https://picsum.photos/seed/featured2/400/400',
      filterCategory: 'Markets',
    ),
    FeaturedNewsCard(
      id: 'featured-3',
      tag: 'TRADE',
      title: 'Global Trade Volumes Stabilize After Supply Chain Disruptions',
      imageUrl: 'https://picsum.photos/seed/featured3/400/400',
      filterCategory: 'Trade',
    ),
    FeaturedNewsCard(
      id: 'featured-4',
      tag: 'TRADE',
      title: 'Global Trade Volumes Stabilize After Supply Chain Disruptions',
      imageUrl: 'https://picsum.photos/seed/featured4/400/400',
      filterCategory: 'Trade',
    ),
    FeaturedNewsCard(
      id: 'featured-5',
      tag: 'MACRO',
      title: 'Central Bank Signals Stable Policy as Inflation Cools',
      imageUrl: 'https://picsum.photos/seed/featured5/400/400',
      filterCategory: 'Macroeconomic',
    ),
    FeaturedNewsCard(
      id: 'featured-6',
      tag: 'BANKING',
      title: 'Banking Sector Reports Higher Net Interest Margins',
      imageUrl: 'https://picsum.photos/seed/featured6/400/400',
      filterCategory: 'Finance & Banking',
    ),
    FeaturedNewsCard(
      id: 'featured-7',
      tag: 'REAL ESTATE',
      title: 'New Cairo Apartment Prices Hold Firm Despite Higher Rates',
      imageUrl: 'https://picsum.photos/seed/featured7/400/400',
      filterCategory: 'Real Estate',
    ),
    FeaturedNewsCard(
      id: 'featured-8',
      tag: 'MARKETS',
      title: 'EGX30 Closes Higher Led by Commercial International Bank',
      imageUrl: 'https://picsum.photos/seed/featured8/400/400',
      filterCategory: 'Markets',
    ),
  ];

  static List<FeaturedNewsCard> featuredForCategory(String category) {
    List<FeaturedNewsCard> results;
    if (category == 'Macroeconomic') {
      results = featuredCards.take(4).toList();
    } else {
      results =
          featuredCards.where((c) => c.filterCategory == category).toList();
    }
    if (results.isEmpty) {
      results = featuredCards.take(4).toList();
    }
    final padded = <FeaturedNewsCard>[...results];
    var i = 0;
    while (padded.length < 4) {
      padded.add(results[i % results.length]);
      i++;
    }
    return padded.take(4).toList();
  }

  static List<NewsArticle> latestForCategory(String category) {
    return allLatestForCategory(category).take(4).toList();
  }

  static List<NewsArticle> allLatestForCategory(String category) {
    const mapping = {
      'Macroeconomic': 'Top 10 Trending',
      'Finance & Banking': 'Finance & Banking',
      'Real Estate': 'Real Estate News',
      'Markets': 'Market Watch',
      'Trade': 'Top 10 Trending',
    };
    final key = mapping[category] ?? category;
    return byCategory(key);
  }

  static String? categoryArticleKey(String filterCategory) {
    const mapping = {
      'Macroeconomic': 'Top 10 Trending',
      'Finance & Banking': 'Finance & Banking',
      'Real Estate': 'Real Estate News',
      'Markets': 'Market Watch',
      'Trade': 'Top 10 Trending',
    };
    return mapping[filterCategory];
  }
}
