import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/models/ticket.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/common/app_localizations.dart';
import 'components/ticket_detail.dart';

class TicketListPage extends ConsumerStatefulWidget {
  const TicketListPage({super.key});

  @override
  ConsumerState<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends ConsumerState<TicketListPage> {
  List<TicketModel>? _tickets;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      final tickets = await api.getTickets();
      setState(() {
        _tickets = tickets;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return appLocalizations.ticketStatusOpen; // 未关闭状态，在列表中无法准确判断是否已回复，统一显示为待回复
      case 1:
        return appLocalizations.ticketStatusClosed;
      default:
        return appLocalizations.unknown;
    }
  }

  Color _getStatusColor(TicketModel ticket) {
    if (ticket.isClosed) {
      return Colors.grey; // 已关闭用灰色
    } else if (ticket.isReplied) {
      return Colors.green; // 已回复用绿色
    } else {
      return Colors.red; // 待回复用红色
    }
  }

  void _handleTicketTap(TicketModel ticket) async {
    // 区分移动和桌面模式
    final viewMode = globalState.appController.viewMode;
    bool? shouldRefresh;
    
    if (viewMode == ViewMode.mobile) {
      shouldRefresh = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => TicketDetailPage(ticketId: ticket.id),
        ),
      );
    } else {
      // 桌面模式使用居中对话框
      shouldRefresh = await showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: TicketDetailSheetWidget(ticketId: ticket.id),
          );
        },
      );
    }

    // 如果有变更，刷新工单列表
    if (shouldRefresh == true) {
      _loadTickets();
    }
  }

  Future<void> _handleCloseTicket(TicketModel ticket) async {
    // 显示确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.closeTicket),
        content: Text(appLocalizations.confirmCloseTicket(ticket.subject)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(appLocalizations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(appLocalizations.confirm),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final api = ref.read(v2boardApiProvider);
      await api.closeTicket(ticket.id);
      
      // 关闭成功后刷新列表
      _loadTickets();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.ticketClosedSuccess)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.ticketCloseFailed(e.toString()))),
        );
      }
    }
  }

  String _formatDateTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadTickets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16).copyWith(bottom: 88),
        child: _buildTicketContent(),
      ),
    );
  }

  Widget _buildTicketContent() {
    if (_isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                _error!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadTickets,
                child: Text(appLocalizations.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (_tickets?.isEmpty ?? true) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.support_agent_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                appLocalizations.noTickets,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                appLocalizations.noTicketsYet,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 工单统计信息
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.support_agent,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                appLocalizations.totalTicketsCount(_tickets!.length),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // 工单卡片列表
        ..._tickets!.map(_buildTicketItem),
      ],
    );
  }

  Widget _buildTicketItem(TicketModel ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleTicketTap(ticket),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.subject, // Use subject as main title
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1, // Limit to one line for consistency
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDateTime(ticket.createdAt),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Status display
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getStatusColor(ticket),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getStatusText(ticket.status),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: _getStatusColor(ticket),
                            ),
                          ),
                        ],
                      ),
                      // Close button (if status is 0)
                      if (ticket.status == 0) ...[
                        const SizedBox(height: 4), // Add some spacing
                        OutlinedButton.icon(
                          onPressed: () => _handleCloseTicket(ticket),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Smaller padding
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(Icons.close, size: 12), // Smaller icon
                          label: Text(
                            appLocalizations.closeTicketButton,
                            style: const TextStyle(fontSize: 10), // Smaller font size
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
