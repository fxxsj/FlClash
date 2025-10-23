import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/views/invite/components/invite_details_dialog.dart';
import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/widgets/widgets.dart';

/// 发放记录页面（移动端使用）
class InviteDetailsPage extends ConsumerWidget {
  const InviteDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonScaffold(
      title: appLocalizations.distributionRecord,
      centerTitle: true,
      leading: IconButton(
        icon: const BackButtonIcon(),
        onPressed: () => Navigator.pop(context),
      ),
      automaticallyImplyLeading: false,
      body: const InviteDetailsPageContent(),
    );
  }
}