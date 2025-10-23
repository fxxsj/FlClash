import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/models/ticket.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:async';

// 工单详情包装器，负责动态标题和状态显示
class TicketDetailPage extends ConsumerStatefulWidget {
  final int ticketId;

  const TicketDetailPage({
    super.key,
    required this.ticketId,
  });

  @override
  ConsumerState<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends ConsumerState<TicketDetailPage> {
  TicketDetailModel? _ticket;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTicketBasicInfo();
  }

  Future<void> _loadTicketBasicInfo() async {
    try {
      final api = ref.read(v2boardApiProvider);
      final ticket = await api.getTicketDetail(widget.ticketId);
      
      final ticketDetail = TicketDetailModel(
        id: ticket.id,
        subject: ticket.subject,
        level: ticket.level,
        status: ticket.status,
        lastReplyAt: ticket.lastReplyAt,
        createdAt: ticket.createdAt,
        updatedAt: ticket.updatedAt,
        messages: ticket.messages ?? [],
      );
      
      if (mounted) {
        setState(() {
          _ticket = ticketDetail;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getStatusText(TicketDetailModel ticket) {
    return ticket.statusName;
  }

  Color _getStatusColor(TicketDetailModel ticket) {
    if (ticket.isClosed) {
      return Colors.grey;
    } else if (ticket.isReplied) {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: _isLoading || _ticket == null 
          ? appLocalizations.ticketDetails 
          : _ticket!.subject,
      centerTitle: true,
      actions: _ticket != null ? [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(_ticket!).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _getStatusText(_ticket!),
            style: TextStyle(
              color: _getStatusColor(_ticket!),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ] : [],
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : TicketDetailSheet(
              ticketId: widget.ticketId,
              onTicketUpdated: (updatedTicket) {
                // 当内部工单状态更新时，同步更新包装器的状态
                if (mounted) {
                  setState(() {
                    _ticket = updatedTicket;
                  });
                }
              },
            ),
      leading: IconButton(
        icon: const BackButtonIcon(),
        onPressed: () => Navigator.pop(context, true),
      ),
      automaticallyImplyLeading: false,
    );
  }
}

// 桌面模式的工单详情包装器
class TicketDetailSheetWidget extends ConsumerStatefulWidget {
  final int ticketId;

  const TicketDetailSheetWidget({
    super.key,
    required this.ticketId,
  });

  @override
  ConsumerState<TicketDetailSheetWidget> createState() => _TicketDetailSheetWidgetState();
}

class _TicketDetailSheetWidgetState extends ConsumerState<TicketDetailSheetWidget> {
  TicketDetailModel? _ticket;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTicketBasicInfo();
  }

  Future<void> _loadTicketBasicInfo() async {
    try {
      final api = ref.read(v2boardApiProvider);
      final ticket = await api.getTicketDetail(widget.ticketId);
      
      final ticketDetail = TicketDetailModel(
        id: ticket.id,
        subject: ticket.subject,
        level: ticket.level,
        status: ticket.status,
        lastReplyAt: ticket.lastReplyAt,
        createdAt: ticket.createdAt,
        updatedAt: ticket.updatedAt,
        messages: ticket.messages ?? [],
      );
      
      if (mounted) {
        setState(() {
          _ticket = ticketDetail;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getStatusText(TicketDetailModel ticket) {
    return ticket.statusName;
  }

  Color _getStatusColor(TicketDetailModel ticket) {
    if (ticket.isClosed) {
      return Colors.grey;
    } else if (ticket.isReplied) {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
      width: 900,
      height: 700,
      constraints: BoxConstraints(
        minWidth: 800,
        maxWidth: 1000,
        minHeight: 600,
        maxHeight: 800,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // 标题栏
          Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.support_agent_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLoading || _ticket == null 
                            ? appLocalizations.ticketDetails 
                            : _ticket!.subject,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (_ticket != null) ...[
                  // 状态标签
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(_ticket!).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getStatusColor(_ticket!).withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _getStatusColor(_ticket!),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _getStatusText(_ticket!),
                          style: TextStyle(
                            color: _getStatusColor(_ticket!),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 关闭按钮 - 只有在工单未关闭时显示
                  if (!_ticket!.isClosed) 
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: ElevatedButton.icon(
                        onPressed: () => _handleCloseTicket(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(context).colorScheme.onError,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 18,
                        ),
                        label: Text(
                          appLocalizations.closeTicketButton,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                ],
                // 关闭对话框按钮
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.outline,
                      size: 20,
                    ),
                    tooltip: appLocalizations.cancel,
                  ),
                ),
              ],
            ),
          ),
          // 内容区域
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: _isLoading 
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                            strokeWidth: 3,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "加载工单详情中...",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : TicketDetailSheet(
                      ticketId: widget.ticketId,
                      onTicketUpdated: (updatedTicket) {
                        // 当内部工单状态更新时，同步更新包装器的状态
                        if (mounted) {
                          setState(() {
                            _ticket = updatedTicket;
                          });
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Future<void> _handleCloseTicket() async {
    if (_ticket == null) return;

    // 显示确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.closeTicket),
        content: Text(appLocalizations.confirmCloseTicket(_ticket!.subject)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(appLocalizations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(appLocalizations.confirm),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final api = ref.read(v2boardApiProvider);
      await api.closeTicket(_ticket!.id);
      
      // 关闭成功后重新加载工单信息
      await _loadTicketBasicInfo();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(appLocalizations.ticketClosedSuccess),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(appLocalizations.ticketCloseFailed(e.toString())),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

class TicketDetailSheet extends ConsumerStatefulWidget {
  final int ticketId;
  final Function(TicketDetailModel)? onTicketUpdated; // 添加回调函数

  const TicketDetailSheet({
    super.key,
    required this.ticketId,
    this.onTicketUpdated,
  });

  @override
  ConsumerState<TicketDetailSheet> createState() => _TicketDetailSheetState();
}

class _TicketDetailSheetState extends ConsumerState<TicketDetailSheet> {
  TicketDetailModel? _ticket;
  bool _isLoading = true;
  bool _isSilentRefreshing = false;  // 添加无感刷新状态
  String? _error;
  final _replyController = TextEditingController();
  bool _isReplying = false;
  Timer? _refreshTimer;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadTicketDetail();
  }

  @override
  void dispose() {
    _replyController.dispose();
    _refreshTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startRefreshTimer() {
    _refreshTimer?.cancel();
    if (_ticket != null && !_ticket!.isClosed) { // 只有在工单未关闭时才轮询
      _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (mounted) {
          _silentRefresh();  // 使用无感刷新
        }
      });
    }
  }

  // 添加无感刷新方法
  Future<void> _silentRefresh() async {
    if (_isSilentRefreshing) return;  // 防止重复刷新
    
    setState(() {
      _isSilentRefreshing = true;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      final ticket = await api.getTicketDetail(widget.ticketId);
      
      // 将 TicketModel 转换为 TicketDetailModel
      final ticketDetail = TicketDetailModel(
        id: ticket.id,
        subject: ticket.subject,
        level: ticket.level,
        status: ticket.status,
        lastReplyAt: ticket.lastReplyAt,
        createdAt: ticket.createdAt,
        updatedAt: ticket.updatedAt,
        messages: ticket.messages ?? [],
      );
      
      // 记录当前消息数量，用于检测是否有新消息
      final oldMessagesCount = _ticket?.messages?.length ?? 0;
      final newMessagesCount = ticketDetail.messages?.length ?? 0;
      
      setState(() {
        _ticket = ticketDetail;
        _isSilentRefreshing = false;
      });
      
      // 通知包装器状态已更新
      if (widget.onTicketUpdated != null) {
        widget.onTicketUpdated!(ticketDetail);
      }
      
      // 如果有新消息且已经滚动到底部附近，则自动滚动到底部
      if (newMessagesCount > oldMessagesCount && _isScrolledNearBottom()) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSilentRefreshing = false;
        });
      }
    }
  }
  
  // 检查是否已经滚动到接近底部
  bool _isScrolledNearBottom() {
    if (!_scrollController.hasClients) return true;
    
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // 如果在底部100像素范围内，认为是接近底部
    return maxScroll - currentScroll < 100;
  }
  
  // 滚动到底部
  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _loadTicketDetail() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      final ticket = await api.getTicketDetail(widget.ticketId);
      // 将 TicketModel 转换为 TicketDetailModel
      final ticketDetail = TicketDetailModel(
        id: ticket.id,
        subject: ticket.subject,
        level: ticket.level,
        status: ticket.status,
        lastReplyAt: ticket.lastReplyAt,
        createdAt: ticket.createdAt,
        updatedAt: ticket.updatedAt,
        messages: ticket.messages ?? [],
      );
      
      setState(() {
        _ticket = ticketDetail;
        _isLoading = false;
      });
      
      // 初始加载完成后，滚动到底部
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
      
      _startRefreshTimer();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _handleReply() async {
    if (_replyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.pleaseEnterReplyContent)),
      );
      return;
    }

    setState(() {
      _isReplying = true;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      await api.replyTicket(
        widget.ticketId,
        _replyController.text,
      );
      _replyController.clear();
      await _silentRefresh(); // 使用无感刷新替代全量刷新，这里会自动调用回调
      
      // 回复成功后滚动到底部
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isReplying = false;
        });
      }
    }
  }

  String _formatDateTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('MM-dd HH:mm').format(dateTime);
  }

  String _getStatusText(TicketDetailModel ticket) {
    // 使用模型中的statusName方法，它会根据消息记录智能判断状态
    return ticket.statusName;
  }

  Color _getStatusColor(TicketDetailModel ticket) {
    if (ticket.isClosed) {
      return Colors.grey; // 已关闭
    } else if (ticket.isReplied) {
      return Colors.green; // 已回复
    } else {
      return Colors.orange; // 待回复
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                "加载中...",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                appLocalizations.loadFailed,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loadTicketDetail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(appLocalizations.retryButton),
              ),
            ],
          ),
        ),
      );
    }

    if (_ticket == null) {
      return Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.description_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                appLocalizations.ticketNotFound,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final ticket = _ticket!;
    final replies = ticket.messages ?? [];

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _silentRefresh,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                ),
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    // 消息列表
                    ...replies.map((message) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            // 时间戳放在气泡上方
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                mainAxisAlignment: message.isMe 
                                    ? MainAxisAlignment.end 
                                    : MainAxisAlignment.start,
                                children: [
                                  Text(
                                    _formatDateTime(message.createdAt),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: message.isMe 
                                  ? MainAxisAlignment.end 
                                  : MainAxisAlignment.start,
                              children: [
                                // 为了创建聊天气泡效果，限制最大宽度
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                                    minWidth: 80,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: message.isMe
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(20),
                                      topRight: const Radius.circular(20),
                                      bottomLeft: message.isMe 
                                          ? const Radius.circular(20) 
                                          : const Radius.circular(6),
                                      bottomRight: message.isMe 
                                          ? const Radius.circular(6) 
                                          : const Radius.circular(20),
                                    ),
                                    border: message.isMe 
                                        ? null
                                        : Border.all(
                                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                                            width: 1,
                                          ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor.withValues(alpha: 0.08),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    message.message,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: message.isMe
                                          ? Theme.of(context).colorScheme.onPrimary
                                          : Theme.of(context).colorScheme.onSurface,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          // 回复框 - 只有在工单未关闭时才显示
          if (!ticket.isClosed)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 44,
                          maxHeight: 120,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _replyController,
                          decoration: InputDecoration(
                            hintText: appLocalizations.enterMessage,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: null,
                          minLines: 1,
                          enabled: !_isReplying,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _isReplying 
                            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.6)
                            : Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: _isReplying ? null : _handleReply,
                        icon: _isReplying
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.send_rounded,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 20,
                              ),
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