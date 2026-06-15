import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grw_app/features/news/news_data.dart';
import 'package:grw_app/features/news/story_viewed_provider.dart';

/// Opens the story viewer as a full-screen bottom sheet.
Future<void> showStoryViewerSheet(
  BuildContext context, {
  required String category,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    useSafeArea: false,
    enableDrag: false,
    builder: (sheetContext) {
      final height = MediaQuery.sizeOf(sheetContext).height;
      return SizedBox(
        height: height,
        child: StoryViewerScreen(
          category: category,
          onClose: () => Navigator.of(sheetContext, rootNavigator: true).pop(),
        ),
      );
    },
  );
}

class StoryViewerScreen extends ConsumerStatefulWidget {
  final String category;
  final VoidCallback onClose;

  const StoryViewerScreen({
    super.key,
    required this.category,
    required this.onClose,
  });

  @override
  ConsumerState<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends ConsumerState<StoryViewerScreen>
    with SingleTickerProviderStateMixin {
  static const _storyDuration = Duration(seconds: 5);
  static const _backgroundColor = Color(0xFF0A1628);

  late final List<NewsArticle> _articles;
  late final PageController _pageController;
  late AnimationController _progressController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _articles = NewsData.byCategory(widget.category);
    _pageController = PageController();
    _progressController = AnimationController(vsync: this);
    _progressController.addStatusListener(_onProgressComplete);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_articles.isEmpty) {
        _dismiss();
        return;
      }
      _startStory(0);
    });
  }

  @override
  void dispose() {
    _progressController.removeStatusListener(_onProgressComplete);
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _dismiss() {
    widget.onClose();
  }

  void _onProgressComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _goToNext();
    }
  }

  void _startStory(int index) {
    if (index < 0 || index >= _articles.length) return;

    _progressController.stop();
    _progressController.reset();

    setState(() => _currentIndex = index);
    ref.read(storyViewedProvider.notifier).markViewed(_articles[index].id);

    _progressController.duration = _storyDuration;
    _progressController.forward(from: 0);
  }

  void _goToNext() {
    if (_currentIndex >= _articles.length - 1) {
      _dismiss();
      return;
    }
    final nextIndex = _currentIndex + 1;
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    _startStory(nextIndex);
  }

  void _goToPrevious() {
    if (_currentIndex <= 0) {
      _startStory(0);
      return;
    }
    final prevIndex = _currentIndex - 1;
    _pageController.animateToPage(
      prevIndex,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    _startStory(prevIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.isEmpty) {
      return const SizedBox.shrink();
    }

    final topPadding = MediaQuery.of(context).padding.top;
    const headerHeight = 88.0;

    return Material(
      color: _backgroundColor,
      child: Stack(
          fit: StackFit.expand,
          children: [
            // Layer 1: story pages
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                return _StoryPage(article: _articles[index]);
              },
            ),

            // Layer 2: left/right tap zones (below header only)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: topPadding + headerHeight,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _goToPrevious,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _goToNext,
                    ),
                  ),
                ],
              ),
            ),

            // Layer 3: header controls (on top, absorbs its own taps)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Material(
                color: Colors.transparent,
                child: SafeArea(
                  bottom: false,
                  child: SizedBox(
                    height: headerHeight - topPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Row(
                            children: List.generate(_articles.length, (index) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? 0 : 2,
                                    right: index == _articles.length - 1 ? 0 : 2,
                                  ),
                                  child: _StoryProgressBar(
                                    active: index == _currentIndex,
                                    completed: index < _currentIndex,
                                    progress: index == _currentIndex
                                        ? _progressController
                                        : null,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: _dismiss,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class _StoryProgressBar extends StatelessWidget {
  final bool active;
  final bool completed;
  final AnimationController? progress;

  const _StoryProgressBar({
    required this.active,
    required this.completed,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final dimTrack = Colors.white.withValues(alpha: 0.25);

    return ClipRRect(
      borderRadius: BorderRadius.circular(1),
      child: SizedBox(
        height: 2,
        child: progress != null && active
            ? AnimatedBuilder(
                animation: progress!,
                builder: (context, _) {
                  return LinearProgressIndicator(
                    value: progress!.value,
                    backgroundColor: dimTrack,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  );
                },
              )
            : LinearProgressIndicator(
                value: completed ? 1 : 0,
                backgroundColor: dimTrack,
                valueColor: AlwaysStoppedAnimation(
                  completed ? Colors.white : Colors.white.withValues(alpha: 0),
                ),
              ),
      ),
    );
  }
}

class _StoryPage extends StatelessWidget {
  final NewsArticle article;

  const _StoryPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: article.imageUrl,
          fit: BoxFit.cover,
          placeholder: (_, __) => const ColoredBox(color: Color(0xFF0A1628)),
          errorWidget: (_, __, ___) =>
              const ColoredBox(color: Color(0xFF0A1628)),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.45),
                Colors.black.withValues(alpha: 0.15),
                const Color(0xFF0A1628).withValues(alpha: 0.85),
              ],
              stops: const [0, 0.4, 1],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).padding.bottom + 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                article.title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 1.25,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${article.source} • ${article.date}',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * 0.28,
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Text(
                    article.body,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
