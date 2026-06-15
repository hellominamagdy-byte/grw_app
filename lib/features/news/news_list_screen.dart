import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grw_app/features/news/news_data.dart';

class NewsListScreen extends StatefulWidget {
  final String? initialCategory;

  const NewsListScreen({super.key, this.initialCategory});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  static const _backgroundColor = Color(0xFFF8F9FB);

  late String _selectedCategory;
  bool _showAllLatest = false;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory ?? 'Macroeconomic';
  }

  @override
  Widget build(BuildContext context) {
    final featured = NewsData.featuredForCategory(_selectedCategory);
    final latest = _showAllLatest
        ? NewsData.allLatestForCategory(_selectedCategory)
        : NewsData.latestForCategory(_selectedCategory);

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          _NewsListHeader(onBack: () => context.pop()),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _CategoryChips(
                    selected: _selectedCategory,
                    onSelected: (category) {
                      setState(() {
                        _selectedCategory = category;
                        _showAllLatest = false;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  if (featured.isNotEmpty) ...[
                    _FeaturedBentoGrid(cards: featured),
                    const SizedBox(height: 12),
                  ],
                  _LatestNewsHeader(
                    onSeeMore: () {
                      setState(() => _showAllLatest = true);
                    },
                  ),
                  const SizedBox(height: 12),
                  ...latest.map(
                    (article) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _LatestNewsItem(article: article),
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

class _NewsListHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _NewsListHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          color: const Color(0xFFFBF8FA).withValues(alpha: 0.8),
          padding: EdgeInsets.fromLTRB(
            8,
            MediaQuery.of(context).padding.top + 8,
            8,
            16,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF45474C), size: 20),
              ),
              const SizedBox(width: 8),
              const Text(
                'News',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1.4,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.bookmark_border, color: Color(0xFF45474C), size: 20),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {},
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.info_outline, color: Color(0xFF45474C), size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const _CategoryChips({
    required this.selected,
    required this.onSelected,
  });

  String _chipLabel(String category) {
    if (category == 'Finance & Banking') return 'Finance And Banking';
    return category;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: NewsData.listCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = NewsData.listCategories[index].label;
          final isActive = category == selected;
          return GestureDetector(
            onTap: () => onSelected(category),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isActive ? 5 : 4,
              ),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF0059C7) : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
                border: isActive
                    ? null
                    : Border.all(color: const Color(0xFFC5C6CD)),
              ),
              child: Center(
                child: Text(
                  _chipLabel(category),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    height: 1.33,
                    letterSpacing: 0.6,
                    color: isActive ? Colors.white : const Color(0xFF45474C),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FeaturedBentoGrid extends StatelessWidget {
  final List<FeaturedNewsCard> cards;

  const _FeaturedBentoGrid({required this.cards});

  static const _cardHeight = 190.0;
  static const _spacing = 12.0;

  @override
  Widget build(BuildContext context) {
    final displayCards = cards.take(4).toList();
    if (displayCards.isEmpty) return const SizedBox.shrink();

    Widget row(int leftIndex, int rightIndex) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: _cardHeight,
              child: _FeaturedCard(card: displayCards[leftIndex]),
            ),
          ),
          const SizedBox(width: _spacing),
          Expanded(
            child: SizedBox(
              height: _cardHeight,
              child: _FeaturedCard(card: displayCards[rightIndex]),
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        row(0, 1),
        const SizedBox(height: _spacing),
        row(2, 3),
      ],
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final FeaturedNewsCard card;

  const _FeaturedCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: card.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: const Color(0xFFE2E8F0)),
              errorWidget: (_, __, ___) =>
                  Container(color: const Color(0xFFE2E8F0)),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF101C2E).withValues(alpha: 0.9),
                    const Color(0xFF101C2E).withValues(alpha: 0),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Icon(
                Icons.bookmark_border,
                size: 18,
                color: Colors.white.withValues(alpha: 0.95),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    card.tag,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      height: 1.5,
                      letterSpacing: 0.5,
                      color: Color(0xFFD9E2FF),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    card.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.375,
                      color: Colors.white,
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

class _LatestNewsHeader extends StatelessWidget {
  final VoidCallback onSeeMore;

  const _LatestNewsHeader({required this.onSeeMore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'Latest News',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              height: 1.4,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: onSeeMore,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: const [
                Text(
                  'See More',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    height: 1.33,
                    letterSpacing: 0.6,
                    color: Color(0xFF0059C7),
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.chevron_right, size: 12, color: Color(0xFF0059C7)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LatestNewsItem extends StatelessWidget {
  final NewsArticle article;

  const _LatestNewsItem({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFC5C6CD).withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1628).withValues(alpha: 0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: article.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: 64,
                height: 64,
                color: const Color(0xFF528DFF).withValues(alpha: 0.2),
              ),
              errorWidget: (_, __, ___) => Container(
                width: 64,
                height: 64,
                color: const Color(0xFF528DFF).withValues(alpha: 0.2),
                child: const Icon(Icons.article_outlined, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.43,
                    color: Color(0xFF1B1B1D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${article.source} • ${article.date}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    height: 1.5,
                    color: Color(0xFF45474C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.bookmark_border, size: 16, color: Color(0xFF75777D)),
        ],
      ),
    );
  }
}
