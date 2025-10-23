import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/models/invite_detail.dart';
import 'package:fl_clash/board/api/api_exception.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/common/app_localizations.dart';

/// 邀请详情记录状态
final inviteDetailsProvider = StateNotifierProvider<InviteDetailsNotifier, AsyncValue<List<InviteDetailModel>>>((ref) {
  return InviteDetailsNotifier(ref);
});

class InviteDetailsNotifier extends StateNotifier<AsyncValue<List<InviteDetailModel>>> {
  final Ref ref;

  InviteDetailsNotifier(this.ref) : super(const AsyncValue.loading());

  /// 加载邀请详情记录
  Future<void> loadInviteDetails() async {
    try {
      state = const AsyncValue.loading();
      final api = ref.read(v2boardApiProvider);
      final details = await api.getInviteDetails();
      state = AsyncValue.data(details);
    } on ApiException catch (e) {
      state = AsyncValue.error(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncValue.error('加载邀请详情记录失败: $e', StackTrace.current);
    }
  }
}

// 桌面端发放记录弹窗包装器
class InviteDetailsSheetWidget extends StatelessWidget {
  const InviteDetailsSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: 900,
        height: 700,
        constraints: const BoxConstraints(
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
                      Icons.receipt_long_outlined,
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
                          appLocalizations.distributionRecord,
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
                  // 关闭对话框按钮
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
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
                child: const InviteDetailsPageContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 将发放记录页面的内容逻辑提取为独立组件
class InviteDetailsPageContent extends ConsumerStatefulWidget {
  const InviteDetailsPageContent({super.key});

  @override
  ConsumerState<InviteDetailsPageContent> createState() => _InviteDetailsPageContentState();
}

class _InviteDetailsPageContentState extends ConsumerState<InviteDetailsPageContent> {
  @override
  void initState() {
    super.initState();
    // 页面初始化时加载数据
    Future.microtask(() => ref.read(inviteDetailsProvider.notifier).loadInviteDetails());
  }

  @override
  Widget build(BuildContext context) {
    final detailsState = ref.watch(inviteDetailsProvider);

    return detailsState.when(
      data: (details) => _buildContent(context, details),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _buildErrorWidget(context, error.toString()),
    );
  }

  Widget _buildContent(BuildContext context, List<InviteDetailModel> details) {
    return RefreshIndicator(
      onRefresh: () => ref.read(inviteDetailsProvider.notifier).loadInviteDetails(),
      child: details.isEmpty
          ? _buildEmptyWidget(context)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: details.length,
              itemBuilder: (context, index) {
                final detail = details[index];
                return _buildDetailItem(context, detail);
              },
            ),
    );
  }

  Widget _buildDetailItem(BuildContext context, InviteDetailModel detail) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.commissionDistribution,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    detail.formattedTime,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              detail.formattedAmount,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.green.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              appLocalizations.noDistributionRecord,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              appLocalizations.noDistributionRecordDescription,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                appLocalizations.loadFailed,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.outline,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(inviteDetailsProvider.notifier).loadInviteDetails(),
                child: Text(appLocalizations.retryButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}