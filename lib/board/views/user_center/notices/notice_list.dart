import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/models/notice.dart';
import 'notice_detail_sheet.dart';
import 'dart:async';

class NoticeList extends ConsumerStatefulWidget {
  const NoticeList({super.key});

  @override
  ConsumerState<NoticeList> createState() => _NoticeListState();
}

class _NoticeListState extends ConsumerState<NoticeList> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  static const _autoScrollDuration = Duration(seconds: 5);
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    if (_isDragging) return; // 如果正在拖动，不启动自动滚动

    _timer?.cancel();
    _timer = Timer.periodic(_autoScrollDuration, (timer) {
      if (!mounted || _isDragging) return;

      final userState = ref.read(userStateProvider);
      if (userState.notices.isEmpty) return;

      final nextPage = (_currentPage + 1) % userState.notices.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoScroll() {
    _isDragging = true;
    _timer?.cancel();
    _timer = null;
  }

  void _onDragEnd() {
    _isDragging = false;
    _startAutoScroll();
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }

  void _showNoticeDetail(BuildContext context, NoticeModel notice) {
    _stopAutoScroll();
    
    // 区分移动和桌面模式，与工单详情保持一致
    final viewMode = globalState.appController.viewMode;
    
    if (viewMode == ViewMode.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoticeDetailWrapper(notice: notice),
        ),
      );
    } else {
      // 桌面模式使用弹窗，与订单详情和工单详情保持一致的显示方式
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: NoticeDetailSheetWrapper(notice: notice),
          );
        },
      );
    }
    
    _startAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateProvider);
    
    if (userState.isLoading) {
      return Container(
        height: 180,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (userState.notices.isEmpty) {
      return Container(
        height: 180,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            appLocalizations.noNotices,
            style: context.textTheme.bodyMedium,
          ),
        ),
      );
    }

    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: userState.notices.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            dragStartBehavior: DragStartBehavior.start,
            // 使用Listener来监听拖动事件
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final notice = userState.notices[index];
              return Listener(
                onPointerDown: (_) => _stopAutoScroll(),
                onPointerUp: (_) => _onDragEnd(),
                onPointerCancel: (_) => _onDragEnd(),
                child: GestureDetector(
                  onTap: () => _showNoticeDetail(context, notice),
                  behavior: HitTestBehavior.opaque,
                  child: _NoticeCard(notice: notice),
                ),
              );
            },
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: userState.isRefreshingNotices
                  ? null
                  : () => ref.read(userStateProvider.notifier).fetchNotices(),
              icon: userState.isRefreshingNotices
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    )
                  : Icon(
                      Icons.refresh,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
              tooltip: appLocalizations.refresh,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                userState.notices.length,
                (index) => GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    child: Container(
                      width: 16,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
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

/// 公告卡片组件 - 优化图片加载处理
class _NoticeCard extends StatefulWidget {
  final NoticeModel notice;

  const _NoticeCard({required this.notice});

  @override
  State<_NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<_NoticeCard> {
  bool _imageLoadError = false;
  bool _imageLoading = true;

  // 检查图片URL是否有效
  bool get _hasValidImageUrl {
    final url = widget.notice.imgUrl;
    return url != null && url.isNotEmpty && url.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    if (_hasValidImageUrl) {
      _preloadImage();
    } else {
      _imageLoading = false;
    }
  }

  // 预加载图片
  void _preloadImage() {
    if (!_hasValidImageUrl) return;

    final imageProvider = NetworkImage(widget.notice.imgUrl!);
    final imageStream = imageProvider.resolve(const ImageConfiguration());
    
    imageStream.addListener(
      ImageStreamListener(
        (info, synchronousCall) {
          if (mounted) {
            setState(() {
              _imageLoading = false;
              _imageLoadError = false;
            });
          }
        },
        onError: (exception, stackTrace) {
          if (mounted) {
            setState(() {
              _imageLoading = false;
              _imageLoadError = true;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 背景图片层
          if (_hasValidImageUrl && !_imageLoadError) ...[
            Image.network(
              widget.notice.imgUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // 图片加载失败，显示默认背景
                return Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Icon(
                      Icons.campaign_rounded,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                );
              },
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: child,
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                
                return Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / 
                              loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 3,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                );
              },
            ),
          ] else ...[
            // 无图片或加载失败时的默认背景
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                    Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.campaign_rounded,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
            ),
          ],
          
          // 渐变遮罩层
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          
          // 内容层
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.notice.title,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.notice.content != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    widget.notice.content!,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  widget.notice.createdAt != null
                      ? appLocalizations.publishedAt((() {
                          final dt = DateTime.fromMillisecondsSinceEpoch(
                              widget.notice.createdAt! * 1000);
                          return '${dt.year}/${dt.month}/${dt.day}';
                        })())
                      : '',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
