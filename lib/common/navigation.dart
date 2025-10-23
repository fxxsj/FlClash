import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/views/views.dart';
import 'package:flutter/material.dart';
import 'package:fl_clash/board/board.dart';

class Navigation {
  static Navigation? _instance;

  List<NavigationItem> getItems({
    bool openLogs = false,
    bool hasProxies = false,
  }) {
    return [
      const NavigationItem(
        icon: Icon(Icons.person),
        label: PageLabel.userCenter,
        view: UserCenterFragment(
          key: GlobalObjectKey(
            PageLabel.userCenter,
          ),
        ),
        modes: [NavigationItemMode.desktop, NavigationItemMode.mobile],
      ),
      const NavigationItem(
        icon: Icon(Icons.shopping_cart),
        label: PageLabel.purchase,
        view: PurchaseFragment(
          key: GlobalObjectKey(
            PageLabel.purchase,
          ),
        ),
        modes: [NavigationItemMode.desktop, NavigationItemMode.mobile],
      ),
      const NavigationItem(
        icon: Icon(Icons.shopping_bag),
        label: PageLabel.myOrders,
        view: OrderListPage(
          key: GlobalObjectKey(
            PageLabel.myOrders,
          ),
        ),
        modes: [NavigationItemMode.desktop],
      ),
      const NavigationItem(
        icon: Icon(Icons.card_giftcard),
        label: PageLabel.inviteFriends,
        view: InvitePage(
          key: GlobalObjectKey(
            PageLabel.inviteFriends,
          ),
        ),
        modes: [NavigationItemMode.desktop],
      ),
      const NavigationItem(
        icon: Icon(Icons.support),
        label: PageLabel.customerSupport,
        view: TicketSheet(
          key: GlobalObjectKey(
            PageLabel.customerSupport,
          ),
        ),
        modes: [NavigationItemMode.desktop],
      ),
      const NavigationItem(
        icon: Icon(Icons.account_circle),
        label: PageLabel.myCenter,
        view: MyCenterPage(
          key: GlobalObjectKey(
            PageLabel.myCenter,
          ),
        ),
        modes: [NavigationItemMode.desktop, NavigationItemMode.mobile],
      ),
      NavigationItem(
        icon: const Icon(Icons.article),
        label: PageLabel.proxies,
        view: const ProxiesView(
          key: GlobalObjectKey(
            PageLabel.proxies,
          ),
        ),
        modes: [],
      ),
      const NavigationItem(
        icon: Icon(Icons.ballot),
        label: PageLabel.connections,
        view: ConnectionsView(
          key: GlobalObjectKey(
            PageLabel.connections,
          ),
        ),
        description: "connectionsDesc",
        modes: [NavigationItemMode.more],
      ),
      const NavigationItem(
        icon: Icon(Icons.folder),
        label: PageLabel.profiles,
        view: ProfilesView(
          key: GlobalObjectKey(
            PageLabel.profiles,
          ),
        ),
        modes: [NavigationItemMode.more],
      ),
      const NavigationItem(
        icon: Icon(Icons.view_timeline),
        label: PageLabel.requests,
        view: RequestsView(
          key: GlobalObjectKey(
            PageLabel.requests,
          ),
        ),
        description: "requestsDesc",
        modes: [NavigationItemMode.more],
      ),
      const NavigationItem(
        icon: Icon(Icons.storage),
        label: PageLabel.resources,
        description: "resourcesDesc",
        view: ResourcesView(
          key: GlobalObjectKey(
            PageLabel.resources,
          ),
        ),
        modes: [NavigationItemMode.more],
      ),
      NavigationItem(
        icon: const Icon(Icons.adb),
        label: PageLabel.logs,
        view: const LogsView(
          key: GlobalObjectKey(
            PageLabel.logs,
          ),
        ),
        description: "logsDesc",
        modes: openLogs
            ? [NavigationItemMode.desktop, NavigationItemMode.more]
            : [],
      ),
    ];
  }

  Navigation._internal();

  factory Navigation() {
    _instance ??= Navigation._internal();
    return _instance!;
  }
}

final navigation = Navigation();
