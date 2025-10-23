// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  static String m0(error) => "変更失敗: ${error}";

  static String m1(error) => "コミッション移転失敗：${error}";

  static String m2(error) => "設定の復号化に失敗しました: ${error}";

  static String m3(subject) => "チケット \"${subject}\" を閉じてもよろしいですか？";

  static String m4(error) => "コピー失敗: ${error}";

  static String m5(label) => "選択された${label}を削除してもよろしいですか？";

  static String m6(label) => "現在の${label}を削除してもよろしいですか？";

  static String m7(label) => "${label}は空欄にできません";

  static String m8(label) => "現在の${label}は既に存在しています";

  static String m9(date, days) => "${date}に期限切れ、あと${days}日";

  static String m10(error) => "招待コード生成失敗: ${error}";

  static String m11(error) => "設定の読み込みに失敗しました: ${error}";

  static String m12(label) => "現在${label}はありません";

  static String m13(label) => "${label}は数字でなければなりません";

  static String m14(online, limit) => "オンラインデバイス ${online}/${limit}";

  static String m15(error) => "リンクを開くのに失敗しました: ${error}";

  static String m16(count) => "合計 ${count} 件の注文";

  static String m17(error) => "支払いに失敗しました: ${error}";

  static String m18(label) => "${label} は 1024 から 49151 の間でなければなりません";

  static String m19(price) => "月平均 ¥${price}";

  static String m20(date) => "${date}に公開";

  static String m21(resetDay) => "トラフィックは${resetDay}日後にリセットされます";

  static String m22(count) => "${count} 項目が選択されています";

  static String m23(code) => "サーバーエラー: ${code}";

  static String m24(error) => "チケットのクローズに失敗しました: ${error}";

  static String m25(count) => "合計 ${count} 件の注文";

  static String m26(count) => "合計 ${count} 件のチケット";

  static String m27(used, total) => "使用量 ${used} / 合計 ${total}";

  static String m28(appTitle) => "移転された残高は${appTitle}の消費のみに使用";

  static String m29(label) => "${label}はURLである必要があります";

  static String m30(error) => "出金申請失敗：${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("について"),
    "accessControl": MessageLookupByLibrary.simpleMessage("アクセス制御"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "選択したアプリのみVPNを許可",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "アプリケーションのプロキシアクセスを設定",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "選択したアプリをVPNから除外",
    ),
    "account": MessageLookupByLibrary.simpleMessage("アカウント"),
    "action": MessageLookupByLibrary.simpleMessage("アクション"),
    "action_mode": MessageLookupByLibrary.simpleMessage("モード切替"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("システムプロキシ"),
    "action_start": MessageLookupByLibrary.simpleMessage("開始/停止"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("表示/非表示"),
    "add": MessageLookupByLibrary.simpleMessage("追加"),
    "addRule": MessageLookupByLibrary.simpleMessage("ルールを追加"),
    "addedOriginRules": MessageLookupByLibrary.simpleMessage("元のルールに追加"),
    "address": MessageLookupByLibrary.simpleMessage("アドレス"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("WebDAVサーバーアドレス"),
    "addressTip": MessageLookupByLibrary.simpleMessage("有効なWebDAVアドレスを入力"),
    "adminAutoLaunch": MessageLookupByLibrary.simpleMessage("管理者自動起動"),
    "adminAutoLaunchDesc": MessageLookupByLibrary.simpleMessage("管理者モードで起動"),
    "ago": MessageLookupByLibrary.simpleMessage("前"),
    "agree": MessageLookupByLibrary.simpleMessage("同意"),
    "alipay": MessageLookupByLibrary.simpleMessage("アリペイ"),
    "allApps": MessageLookupByLibrary.simpleMessage("全アプリ"),
    "allCommissionBalanceWillBeApplied": MessageLookupByLibrary.simpleMessage(
      "全てのコミッション残高が出金申請されます",
    ),
    "allowBypass": MessageLookupByLibrary.simpleMessage("アプリがVPNをバイパスすることを許可"),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "有効化すると一部アプリがVPNをバイパス",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("LANを許可"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage("LAN経由でのプロキシアクセスを許可"),
    "app": MessageLookupByLibrary.simpleMessage("アプリ"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage("アプリアクセス制御"),
    "appDesc": MessageLookupByLibrary.simpleMessage("アプリ関連設定の処理"),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "ClashMetaベースのマルチプラットフォームプロキシクライアント",
    ),
    "appFeatures": MessageLookupByLibrary.simpleMessage(
      "シンプルで使いやすく、オープンソースで広告なし",
    ),
    "appUrlNotConfigured": MessageLookupByLibrary.simpleMessage(
      "アプリURLが設定されていません",
    ),
    "application": MessageLookupByLibrary.simpleMessage("アプリケーション"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage("アプリ関連設定を変更"),
    "applicationFailed": MessageLookupByLibrary.simpleMessage("申請に失敗しました"),
    "applicationSection": MessageLookupByLibrary.simpleMessage("アプリケーション"),
    "applyWithdrawal": MessageLookupByLibrary.simpleMessage("出金申請"),
    "asn": MessageLookupByLibrary.simpleMessage("自律システム番号"),
    "auto": MessageLookupByLibrary.simpleMessage("自動"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage("自動更新チェック"),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "起動時に更新を自動チェック",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage("接続を自動閉じる"),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "ノード変更後に接続を自動閉じる",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("自動起動"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage("システムの自動起動に従う"),
    "autoRun": MessageLookupByLibrary.simpleMessage("自動実行"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage("アプリ起動時に自動実行"),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage("オートセットシステムDNS"),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("自動更新"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage("自動更新間隔（分）"),
    "availableCommission": MessageLookupByLibrary.simpleMessage("利用可能な報酬"),
    "availableWithdrawalAmount": MessageLookupByLibrary.simpleMessage("出金可能金額"),
    "back": MessageLookupByLibrary.simpleMessage("戻る"),
    "backup": MessageLookupByLibrary.simpleMessage("バックアップ"),
    "backupAndRecovery": MessageLookupByLibrary.simpleMessage("バックアップと復元"),
    "backupAndRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVまたはファイルでデータを同期",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("バックアップ成功"),
    "balance": MessageLookupByLibrary.simpleMessage("残高"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("基本設定"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage("基本設定をグローバルに変更"),
    "bind": MessageLookupByLibrary.simpleMessage("バインド"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("ブラックリストモード"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("バイパスドメイン"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage("システムプロキシ有効時のみ適用"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "キャッシュが破損しています。クリアしますか？",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "cancelFilterSystemApp": MessageLookupByLibrary.simpleMessage(
      "システムアプリの除外を解除",
    ),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("注文キャンセル"),
    "cancelOrderConfirmTip": MessageLookupByLibrary.simpleMessage(
      "すでに支払いを行った場合、注文をキャンセルすると支払いが失敗する可能性があります。注文をキャンセルしますか？",
    ),
    "cancelOrderFailed": MessageLookupByLibrary.simpleMessage(
      "注文のキャンセルに失敗しました",
    ),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("全選択解除"),
    "cannotOpenTelegramLink": MessageLookupByLibrary.simpleMessage(
      "Telegramリンクを開けません",
    ),
    "changeFailedMsg": MessageLookupByLibrary.simpleMessage("変更に失敗しました"),
    "changePassword": MessageLookupByLibrary.simpleMessage("パスワード変更"),
    "changePasswordFailed": m0,
    "checkError": MessageLookupByLibrary.simpleMessage("確認エラー"),
    "checkOrderStatusFailed": MessageLookupByLibrary.simpleMessage(
      "注文状況の確認に失敗しました",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("更新を確認"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage("アプリは最新版です"),
    "checking": MessageLookupByLibrary.simpleMessage("確認中..."),
    "checkout": MessageLookupByLibrary.simpleMessage("チェックアウト"),
    "clearData": MessageLookupByLibrary.simpleMessage("データを消去"),
    "clickToPay": MessageLookupByLibrary.simpleMessage("支払いをクリック"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("クリップボードにエクスポート"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("クリップボードからインポート"),
    "close": MessageLookupByLibrary.simpleMessage("閉じる"),
    "closeOrder": MessageLookupByLibrary.simpleMessage("注文を閉じる"),
    "closeTicket": MessageLookupByLibrary.simpleMessage("チケットを閉じる"),
    "closeTicketButton": MessageLookupByLibrary.simpleMessage("閉じる"),
    "closeTicketFailed": MessageLookupByLibrary.simpleMessage(
      "チケットの閉じるに失敗しました",
    ),
    "color": MessageLookupByLibrary.simpleMessage("カラー"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("カラースキーム"),
    "columns": MessageLookupByLibrary.simpleMessage("列"),
    "commissionDistribution": MessageLookupByLibrary.simpleMessage("報酬配布"),
    "commissionRate": MessageLookupByLibrary.simpleMessage("報酬率"),
    "commissionTransferFailed": m1,
    "commissionTransferFailed2": MessageLookupByLibrary.simpleMessage(
      "コミッション転送に失敗しました",
    ),
    "commissionTransferPageTitle": MessageLookupByLibrary.simpleMessage(
      "コミッション振替",
    ),
    "commissionTransferSuccess": MessageLookupByLibrary.simpleMessage(
      "コミッション移転成功",
    ),
    "commissionTransferSuccessMsg": MessageLookupByLibrary.simpleMessage(
      "コミッション振替が成功しました",
    ),
    "commissionWithdrawal": MessageLookupByLibrary.simpleMessage("報酬出金"),
    "compatible": MessageLookupByLibrary.simpleMessage("互換モード"),
    "compatibleDesc": MessageLookupByLibrary.simpleMessage(
      "有効化すると一部機能を失いますが、Clashの完全サポートを獲得",
    ),
    "complete": MessageLookupByLibrary.simpleMessage("完了"),
    "completeBtnText": MessageLookupByLibrary.simpleMessage("完了"),
    "configDecryptFailed": m2,
    "confirm": MessageLookupByLibrary.simpleMessage("確認"),
    "confirmCloseTicket": m3,
    "confirmLogout": MessageLookupByLibrary.simpleMessage("ログアウト確認"),
    "confirmLogoutMessage": MessageLookupByLibrary.simpleMessage(
      "ログアウトしてもよろしいですか？",
    ),
    "confirmNewPasswordAgain": MessageLookupByLibrary.simpleMessage(
      "新しいパスワードを再確認",
    ),
    "confirmNewPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "新しいパスワードを再確認",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage("パスワードを確認"),
    "confirmPayment": MessageLookupByLibrary.simpleMessage("支払い確認"),
    "confirmTransfer": MessageLookupByLibrary.simpleMessage("確認"),
    "connectionTools": MessageLookupByLibrary.simpleMessage("接続ツール"),
    "connections": MessageLookupByLibrary.simpleMessage("接続"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage("現在の接続データを表示"),
    "connectivity": MessageLookupByLibrary.simpleMessage("接続性："),
    "contactMe": MessageLookupByLibrary.simpleMessage("連絡する"),
    "content": MessageLookupByLibrary.simpleMessage("内容"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("コンテンツテーマ"),
    "copy": MessageLookupByLibrary.simpleMessage("コピー"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage("環境変数をコピー"),
    "copyFailed": m4,
    "copyLink": MessageLookupByLibrary.simpleMessage("リンクをコピー"),
    "copyLinkButton": MessageLookupByLibrary.simpleMessage("リンクをコピー"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("コピー成功"),
    "core": MessageLookupByLibrary.simpleMessage("コア"),
    "coreInfo": MessageLookupByLibrary.simpleMessage("コア情報"),
    "country": MessageLookupByLibrary.simpleMessage("国"),
    "couponCode": MessageLookupByLibrary.simpleMessage("クーポンコード"),
    "couponCodeHint": MessageLookupByLibrary.simpleMessage("クーポンコードを入力（任意）"),
    "couponValid": MessageLookupByLibrary.simpleMessage("有効なクーポンコード"),
    "couponVerifySuccess": MessageLookupByLibrary.simpleMessage("クーポン確認成功"),
    "crashTest": MessageLookupByLibrary.simpleMessage("クラッシュテスト"),
    "create": MessageLookupByLibrary.simpleMessage("作成"),
    "createOrder": MessageLookupByLibrary.simpleMessage("注文作成"),
    "createOrderFailed": MessageLookupByLibrary.simpleMessage("注文の作成に失敗しました"),
    "createTicket": MessageLookupByLibrary.simpleMessage("チケット作成"),
    "createTicketFailed": MessageLookupByLibrary.simpleMessage(
      "チケットの作成に失敗しました",
    ),
    "createdAt": MessageLookupByLibrary.simpleMessage("作成日時"),
    "currentAvailableWithdrawalAmount": MessageLookupByLibrary.simpleMessage(
      "現在の出金可能金額",
    ),
    "currentCommissionBalance": MessageLookupByLibrary.simpleMessage(
      "現在のコミッション残高",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("現在のパスワード"),
    "currentPasswordLabel": MessageLookupByLibrary.simpleMessage("現在のパスワード"),
    "currentRemainingCommission": MessageLookupByLibrary.simpleMessage(
      "現在の残り報酬",
    ),
    "currentVersion": MessageLookupByLibrary.simpleMessage("現在のバージョン"),
    "currentVersionLabel": MessageLookupByLibrary.simpleMessage("現在のバージョン"),
    "customerSupport": MessageLookupByLibrary.simpleMessage("カスタマーサポート"),
    "customerSupport2": MessageLookupByLibrary.simpleMessage("カスタマーサポート"),
    "cut": MessageLookupByLibrary.simpleMessage("切り取り"),
    "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
    "dashboard": MessageLookupByLibrary.simpleMessage("ダッシュボード"),
    "days": MessageLookupByLibrary.simpleMessage("日"),
    "defaultNameserver": MessageLookupByLibrary.simpleMessage("デフォルトネームサーバー"),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "DNSサーバーの解決用",
    ),
    "defaultSort": MessageLookupByLibrary.simpleMessage("デフォルト順"),
    "defaultText": MessageLookupByLibrary.simpleMessage("デフォルト"),
    "delay": MessageLookupByLibrary.simpleMessage("遅延"),
    "delaySort": MessageLookupByLibrary.simpleMessage("遅延順"),
    "delete": MessageLookupByLibrary.simpleMessage("削除"),
    "deleteMultipTip": m5,
    "deleteTip": m6,
    "deposit": MessageLookupByLibrary.simpleMessage("入金"),
    "depositOrder": MessageLookupByLibrary.simpleMessage("入金注文"),
    "desc": MessageLookupByLibrary.simpleMessage(
      "ClashMetaベースのマルチプラットフォームプロキシクライアント。シンプルで使いやすく、オープンソースで広告なし。",
    ),
    "detectionTip": MessageLookupByLibrary.simpleMessage("サードパーティAPIに依存（参考値）"),
    "developerMode": MessageLookupByLibrary.simpleMessage("デベロッパーモード"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "デベロッパーモードが有効になりました。",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("ダイレクト"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("免責事項"),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "本ソフトウェアは学習交流や科学研究などの非営利目的でのみ使用されます。商用利用は厳禁です。いかなる商用活動も本ソフトウェアとは無関係です。",
    ),
    "discount": MessageLookupByLibrary.simpleMessage("割引"),
    "discountAmount": MessageLookupByLibrary.simpleMessage("割引金額"),
    "discountedPrice": MessageLookupByLibrary.simpleMessage("割引価格"),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage("新バージョンを発見"),
    "discovery": MessageLookupByLibrary.simpleMessage("新しいバージョンを発見"),
    "distributionRecord": MessageLookupByLibrary.simpleMessage("配布記録"),
    "distributionRecordInDevelopment": MessageLookupByLibrary.simpleMessage(
      "配布記録機能は開発中です",
    ),
    "dns": MessageLookupByLibrary.simpleMessage("ドメイン名解決"),
    "dnsDesc": MessageLookupByLibrary.simpleMessage("DNS関連設定の更新"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNSモード"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage("通過させますか？"),
    "domain": MessageLookupByLibrary.simpleMessage("ドメイン"),
    "download": MessageLookupByLibrary.simpleMessage("ダウンロード"),
    "edit": MessageLookupByLibrary.simpleMessage("編集"),
    "editRules": MessageLookupByLibrary.simpleMessage("ルール編集"),
    "emailCodeHint": MessageLookupByLibrary.simpleMessage("確認コードを入力"),
    "emailHint": MessageLookupByLibrary.simpleMessage("メールアドレスを入力"),
    "emailSuffixError": MessageLookupByLibrary.simpleMessage(
      "このメールドメインは許可されていません",
    ),
    "emptyTip": m7,
    "en": MessageLookupByLibrary.simpleMessage("英語"),
    "enableOverride": MessageLookupByLibrary.simpleMessage("上書きを有効化"),
    "enterMessage": MessageLookupByLibrary.simpleMessage("メッセージを入力"),
    "entries": MessageLookupByLibrary.simpleMessage(" エントリ"),
    "error": MessageLookupByLibrary.simpleMessage("エラー"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("エラーが発生しました"),
    "exclude": MessageLookupByLibrary.simpleMessage("最近のタスクから非表示"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "アプリがバックグラウンド時に最近のタスクから非表示",
    ),
    "existsTip": m8,
    "exit": MessageLookupByLibrary.simpleMessage("終了"),
    "expand": MessageLookupByLibrary.simpleMessage("標準"),
    "expirationInfo": m9,
    "expirationTime": MessageLookupByLibrary.simpleMessage("有効期限"),
    "expireTime": MessageLookupByLibrary.simpleMessage("有効期限"),
    "expired": MessageLookupByLibrary.simpleMessage("期限切れ"),
    "expiryEmailReminder": MessageLookupByLibrary.simpleMessage("有効期限メール通知"),
    "expiryEmailReminderDisabled": MessageLookupByLibrary.simpleMessage(
      "有効期限メール通知が無効になりました",
    ),
    "expiryEmailReminderEnabled": MessageLookupByLibrary.simpleMessage(
      "有効期限メール通知が有効になりました",
    ),
    "exportFile": MessageLookupByLibrary.simpleMessage("ファイルをエクスポート"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("ログをエクスポート"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("エクスポート成功"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("エクスプレッシブ"),
    "externalController": MessageLookupByLibrary.simpleMessage("外部コントローラー"),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとClashコアをポート9090で制御可能",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("外部リンク"),
    "externalResources": MessageLookupByLibrary.simpleMessage("外部リソース"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeipフィルター"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip範囲"),
    "fallback": MessageLookupByLibrary.simpleMessage("フォールバック"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage("通常はオフショアDNSを使用"),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("フォールバックフィルター"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("ハイファイデリティー"),
    "file": MessageLookupByLibrary.simpleMessage("ファイル"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("プロファイルを直接アップロード"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "ファイルが変更されました。保存しますか？",
    ),
    "filterSystemApp": MessageLookupByLibrary.simpleMessage("システムアプリを除外"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("プロセス検出"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとパフォーマンスが若干低下します",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("フォントファミリー"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("パスワードを忘れた方"),
    "fourColumns": MessageLookupByLibrary.simpleMessage("4列"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("フルーツサラダ"),
    "general": MessageLookupByLibrary.simpleMessage("一般"),
    "generalDesc": MessageLookupByLibrary.simpleMessage("一般設定を変更"),
    "generateInviteCode": MessageLookupByLibrary.simpleMessage("コード生成"),
    "generateInviteCodeButton": MessageLookupByLibrary.simpleMessage("招待コード生成"),
    "generateInviteCodeFailed": m10,
    "geoData": MessageLookupByLibrary.simpleMessage("地域データ"),
    "geoIp": MessageLookupByLibrary.simpleMessage("地理IP"),
    "geoSite": MessageLookupByLibrary.simpleMessage("地理サイト"),
    "geodataLoader": MessageLookupByLibrary.simpleMessage("Geo低メモリモード"),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとGeo低メモリローダーを使用",
    ),
    "geoip": MessageLookupByLibrary.simpleMessage("地理IP"),
    "geoipCode": MessageLookupByLibrary.simpleMessage("GeoIPコード"),
    "geosite": MessageLookupByLibrary.simpleMessage("地理サイト"),
    "getConfigInfoFailed": MessageLookupByLibrary.simpleMessage(
      "設定情報の取得に失敗しました。後でもう一度お試しください",
    ),
    "getNoticeListFailed": MessageLookupByLibrary.simpleMessage(
      "お知らせリストの取得に失敗しました",
    ),
    "getOrderDetailFailed": MessageLookupByLibrary.simpleMessage(
      "注文詳細の取得に失敗しました",
    ),
    "getOrderListFailed": MessageLookupByLibrary.simpleMessage(
      "注文リストの取得に失敗しました",
    ),
    "getOriginRules": MessageLookupByLibrary.simpleMessage("元のルールを取得"),
    "getPaymentLinkFailed": MessageLookupByLibrary.simpleMessage(
      "支払いリンクの取得に失敗しました",
    ),
    "getPaymentMethodsFailed": MessageLookupByLibrary.simpleMessage(
      "支払い方法の取得に失敗しました",
    ),
    "getPlansFailed": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションプランの取得に失敗しました。更新してもう一度お試しください",
    ),
    "getQuickLoginLinkFailed": MessageLookupByLibrary.simpleMessage(
      "クイックログインリンクの取得に失敗しました",
    ),
    "getStatisticsFailed": MessageLookupByLibrary.simpleMessage(
      "統計情報の取得に失敗しました",
    ),
    "getSubscribeInfoFailed": MessageLookupByLibrary.simpleMessage(
      "サブスクリプション情報の取得に失敗しました",
    ),
    "getTicketDetailFailed": MessageLookupByLibrary.simpleMessage(
      "チケット詳細の取得に失敗しました",
    ),
    "getTicketListFailed": MessageLookupByLibrary.simpleMessage(
      "チケットリストの取得に失敗しました",
    ),
    "getUnpaidOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "未払い注文の取得に失敗しました",
    ),
    "getUnpaidOrdersFailedMsg": MessageLookupByLibrary.simpleMessage(
      "未払い注文の取得に失敗しました",
    ),
    "getUserConfigFailed": MessageLookupByLibrary.simpleMessage(
      "ユーザー設定の取得に失敗しました",
    ),
    "getUserInfoFailed": MessageLookupByLibrary.simpleMessage(
      "ユーザー情報の取得に失敗しました。更新してもう一度お試しください",
    ),
    "global": MessageLookupByLibrary.simpleMessage("グローバル"),
    "go": MessageLookupByLibrary.simpleMessage("移動"),
    "goDownload": MessageLookupByLibrary.simpleMessage("ダウンロードへ"),
    "goToPay": MessageLookupByLibrary.simpleMessage("支払いへ"),
    "halfYearlyPlan": MessageLookupByLibrary.simpleMessage("半年"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage("変更をキャッシュしますか？"),
    "hasNoAccount": MessageLookupByLibrary.simpleMessage("アカウントをお持ちでない方"),
    "haveCoupon": MessageLookupByLibrary.simpleMessage("クーポンをお持ちですか？"),
    "hosts": MessageLookupByLibrary.simpleMessage("ホストファイル"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("ホストを追加"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("ホットキー競合"),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("ホットキー管理"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "キーボードでアプリを制御",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("時間"),
    "icon": MessageLookupByLibrary.simpleMessage("アイコン"),
    "iconConfiguration": MessageLookupByLibrary.simpleMessage("アイコン設定"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("アイコンスタイル"),
    "import": MessageLookupByLibrary.simpleMessage("インポート"),
    "importFailed": MessageLookupByLibrary.simpleMessage("サブスクリプションインポート失敗"),
    "importFile": MessageLookupByLibrary.simpleMessage("ファイルからインポート"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "importSuccess": MessageLookupByLibrary.simpleMessage("サブスクリプションインポート成功"),
    "importUrl": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "importantReminder": MessageLookupByLibrary.simpleMessage("重要な注意事項"),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("長期有効"),
    "init": MessageLookupByLibrary.simpleMessage("初期化"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage("正しいホットキーを入力"),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage("インテリジェント選択"),
    "internet": MessageLookupByLibrary.simpleMessage("インターネット"),
    "interval": MessageLookupByLibrary.simpleMessage("インターバル"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("イントラネットIP"),
    "invalidConfigDataStructure": MessageLookupByLibrary.simpleMessage(
      "無効な設定データ構造",
    ),
    "invalidCoupon": MessageLookupByLibrary.simpleMessage("無効なクーポンです"),
    "invalidResponseDataFormat": MessageLookupByLibrary.simpleMessage(
      "無効なレスポンスデータ形式",
    ),
    "inviteCodeGenerateSuccess": MessageLookupByLibrary.simpleMessage(
      "招待コード生成成功",
    ),
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage("招待コードを入力（任意）"),
    "inviteCodeManagement": MessageLookupByLibrary.simpleMessage("招待コード管理"),
    "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
      "招待コードを入力してください",
    ),
    "inviteFriends": MessageLookupByLibrary.simpleMessage("友達を招待"),
    "inviteFriends2": MessageLookupByLibrary.simpleMessage("友達を招待"),
    "inviteLink": MessageLookupByLibrary.simpleMessage("招待リンク"),
    "inviteLinkCopied": MessageLookupByLibrary.simpleMessage(
      "招待リンクをコピーしました。友達を招待しましょう！",
    ),
    "inviteLinkCopiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "招待リンクをクリップボードにコピーしました",
    ),
    "invitedUsers": MessageLookupByLibrary.simpleMessage("招待したユーザー"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6": MessageLookupByLibrary.simpleMessage("IPv6プロトコル"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage("有効化するとIPv6トラフィックを受信可能"),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage("IPv6インバウンドを許可"),
    "ja": MessageLookupByLibrary.simpleMessage("日本語"),
    "joinGroup": MessageLookupByLibrary.simpleMessage("参加"),
    "just": MessageLookupByLibrary.simpleMessage("たった今"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "TCPキープアライブ間隔",
    ),
    "key": MessageLookupByLibrary.simpleMessage("キー"),
    "language": MessageLookupByLibrary.simpleMessage("言語"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("最終更新"),
    "layout": MessageLookupByLibrary.simpleMessage("レイアウト"),
    "light": MessageLookupByLibrary.simpleMessage("ライト"),
    "list": MessageLookupByLibrary.simpleMessage("リスト"),
    "listen": MessageLookupByLibrary.simpleMessage("リスン"),
    "loadConfigFailed": m11,
    "loadFailed": MessageLookupByLibrary.simpleMessage("読み込み失敗"),
    "loadFailedMsg": MessageLookupByLibrary.simpleMessage("読み込みに失敗しました"),
    "loadingConfig": MessageLookupByLibrary.simpleMessage("設定を読み込み中..."),
    "local": MessageLookupByLibrary.simpleMessage("ローカル"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage("ローカルにデータをバックアップ"),
    "localRecoveryDesc": MessageLookupByLibrary.simpleMessage("ファイルからデータを復元"),
    "logLevel": MessageLookupByLibrary.simpleMessage("ログレベル"),
    "logcat": MessageLookupByLibrary.simpleMessage("ログキャット"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage("無効化するとログエントリを非表示"),
    "login": MessageLookupByLibrary.simpleMessage("ログイン"),
    "loginError": MessageLookupByLibrary.simpleMessage("ログイン失敗"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("ログインに失敗しました"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("ログイン成功"),
    "loginToViewPersonalInfo": MessageLookupByLibrary.simpleMessage(
      "ログインして個人情報を表示",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "logoutButton": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "logoutUser": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "logs": MessageLookupByLibrary.simpleMessage("ログ"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("ログキャプチャ記録"),
    "logsTest": MessageLookupByLibrary.simpleMessage("ログテスト"),
    "loopback": MessageLookupByLibrary.simpleMessage("ループバック解除ツール"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage("UWPループバック解除用"),
    "loose": MessageLookupByLibrary.simpleMessage("疎"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("メモリ情報"),
    "messageTest": MessageLookupByLibrary.simpleMessage("メッセージテスト"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("これはメッセージです。"),
    "min": MessageLookupByLibrary.simpleMessage("最小化"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("終了時に最小化"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "システムの終了イベントを変更",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("分"),
    "mixedPort": MessageLookupByLibrary.simpleMessage("混合ポート"),
    "mmdb": MessageLookupByLibrary.simpleMessage("メモリデータベース"),
    "mode": MessageLookupByLibrary.simpleMessage("モード"),
    "modifyPassword": MessageLookupByLibrary.simpleMessage("パスワード変更"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("モノクローム"),
    "monthlyPlan": MessageLookupByLibrary.simpleMessage("月額"),
    "months": MessageLookupByLibrary.simpleMessage("月"),
    "more": MessageLookupByLibrary.simpleMessage("詳細"),
    "moreActions": MessageLookupByLibrary.simpleMessage("その他の操作"),
    "mostPopular": MessageLookupByLibrary.simpleMessage("最も人気"),
    "myAccount": MessageLookupByLibrary.simpleMessage("マイアカウント"),
    "myCenter": MessageLookupByLibrary.simpleMessage("マイ"),
    "myCommission": MessageLookupByLibrary.simpleMessage("マイ報酬"),
    "myInvite": MessageLookupByLibrary.simpleMessage("マイ招待"),
    "myOrders": MessageLookupByLibrary.simpleMessage("注文履歴"),
    "myOrders2": MessageLookupByLibrary.simpleMessage("注文履歴"),
    "name": MessageLookupByLibrary.simpleMessage("名前"),
    "nameSort": MessageLookupByLibrary.simpleMessage("名前順"),
    "nameserver": MessageLookupByLibrary.simpleMessage("ネームサーバー"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage("ドメイン解決用"),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage("ネームサーバーポリシー"),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "対応するネームサーバーポリシーを指定",
    ),
    "network": MessageLookupByLibrary.simpleMessage("ネットワーク"),
    "networkDesc": MessageLookupByLibrary.simpleMessage("ネットワーク関連設定の変更"),
    "networkDetection": MessageLookupByLibrary.simpleMessage("ネットワーク検出"),
    "networkSection": MessageLookupByLibrary.simpleMessage("ネットワーク"),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("ネットワーク速度"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("ニュートラル"),
    "newPassword": MessageLookupByLibrary.simpleMessage("新しいパスワード"),
    "newPasswordHint": MessageLookupByLibrary.simpleMessage("新しいパスワードを入力"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("新しいパスワード"),
    "newPasswordLengthRequirement": MessageLookupByLibrary.simpleMessage(
      "新しいパスワードは8-20文字必要です",
    ),
    "next": MessageLookupByLibrary.simpleMessage("次へ"),
    "noData": MessageLookupByLibrary.simpleMessage("データなし"),
    "noDistributionRecord": MessageLookupByLibrary.simpleMessage("配布記録がありません"),
    "noDistributionRecordDescription": MessageLookupByLibrary.simpleMessage(
      "まだ報酬配布記録を受け取っていません",
    ),
    "noHotKey": MessageLookupByLibrary.simpleMessage("ホットキーなし"),
    "noIcon": MessageLookupByLibrary.simpleMessage("なし"),
    "noInfo": MessageLookupByLibrary.simpleMessage("情報なし"),
    "noInviteCode": MessageLookupByLibrary.simpleMessage("招待コードなし"),
    "noMoreInfoDesc": MessageLookupByLibrary.simpleMessage("追加情報なし"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("ネットワークなし"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("ネットワークなしアプリ"),
    "noNotices": MessageLookupByLibrary.simpleMessage("お知らせなし"),
    "noOrders": MessageLookupByLibrary.simpleMessage("注文なし"),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage("まだ注文がありません"),
    "noPaymentMethods": MessageLookupByLibrary.simpleMessage(
      "利用可能な支払い方法がありません",
    ),
    "noPlans": MessageLookupByLibrary.simpleMessage("利用可能なプランなし"),
    "noProxy": MessageLookupByLibrary.simpleMessage("プロキシなし"),
    "noProxyDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルを作成するか、有効なプロファイルを追加してください",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("IPを解決しない"),
    "noSubscribeUrl": MessageLookupByLibrary.simpleMessage("サブスクリプションURLなし"),
    "noTickets": MessageLookupByLibrary.simpleMessage("チケットなし"),
    "noTicketsYet": MessageLookupByLibrary.simpleMessage("まだチケットがありません"),
    "nodes": MessageLookupByLibrary.simpleMessage("ノード"),
    "none": MessageLookupByLibrary.simpleMessage("なし"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "現在のプロキシグループは選択できません",
    ),
    "notices": MessageLookupByLibrary.simpleMessage("お知らせ"),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルがありません。追加してください",
    ),
    "nullTip": m12,
    "numberTip": m13,
    "officialWebsite": MessageLookupByLibrary.simpleMessage("公式ウェブサイト"),
    "oneClickBlock": MessageLookupByLibrary.simpleMessage("ワンクリックブロック"),
    "oneColumn": MessageLookupByLibrary.simpleMessage("1列"),
    "onetimePlan": MessageLookupByLibrary.simpleMessage("一回限り"),
    "onlineDevices": MessageLookupByLibrary.simpleMessage("オンラインデバイス"),
    "onlineStatus": m14,
    "onlyIcon": MessageLookupByLibrary.simpleMessage("アイコンのみ"),
    "onlyOtherApps": MessageLookupByLibrary.simpleMessage("サードパーティアプリのみ"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage("プロキシのみ統計"),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとプロキシトラフィックのみ統計",
    ),
    "openLinkFailed": m15,
    "options": MessageLookupByLibrary.simpleMessage("オプション"),
    "orderAmount": MessageLookupByLibrary.simpleMessage("金額"),
    "orderCancelledDueToTimeout": MessageLookupByLibrary.simpleMessage(
      "注文は支払いタイムアウトによりキャンセルされました。",
    ),
    "orderCompletedTip": MessageLookupByLibrary.simpleMessage(
      "注文は支払い済みで有効化されています。",
    ),
    "orderCount": m16,
    "orderCreatedAt": MessageLookupByLibrary.simpleMessage("作成日時"),
    "orderDetails": MessageLookupByLibrary.simpleMessage("注文詳細"),
    "orderDiscount": MessageLookupByLibrary.simpleMessage("割引"),
    "orderInfo": MessageLookupByLibrary.simpleMessage("注文情報"),
    "orderListTitle": MessageLookupByLibrary.simpleMessage("マイオーダー"),
    "orderNumber": MessageLookupByLibrary.simpleMessage("注文番号"),
    "orderStatusCancelled": MessageLookupByLibrary.simpleMessage("キャンセル済"),
    "orderStatusCompleted": MessageLookupByLibrary.simpleMessage("完了"),
    "orderStatusDeducted": MessageLookupByLibrary.simpleMessage("控除済"),
    "orderStatusProcessing": MessageLookupByLibrary.simpleMessage("処理中"),
    "orderStatusUnpaid": MessageLookupByLibrary.simpleMessage("未払い"),
    "orderTotal": MessageLookupByLibrary.simpleMessage("注文合計"),
    "orderType": MessageLookupByLibrary.simpleMessage("注文タイプ"),
    "orderTypeNew": MessageLookupByLibrary.simpleMessage("新規"),
    "orderTypeRenew": MessageLookupByLibrary.simpleMessage("更新"),
    "orderTypeResetTraffic": MessageLookupByLibrary.simpleMessage("トラフィックリセット"),
    "orderTypeUpgrade": MessageLookupByLibrary.simpleMessage("アップグレード"),
    "other": MessageLookupByLibrary.simpleMessage("その他"),
    "otherContributors": MessageLookupByLibrary.simpleMessage("その他の貢献者"),
    "otherSettings": MessageLookupByLibrary.simpleMessage("その他の設定"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("アウトバウンドモード"),
    "override": MessageLookupByLibrary.simpleMessage("上書き"),
    "overrideDesc": MessageLookupByLibrary.simpleMessage("プロキシ関連設定を上書き"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("DNS上書き"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとプロファイルのDNS設定を上書き",
    ),
    "overrideInvalidTip": MessageLookupByLibrary.simpleMessage(
      "スクリプトモードでは有効になりません",
    ),
    "overrideOriginRules": MessageLookupByLibrary.simpleMessage("元のルールを上書き"),
    "palette": MessageLookupByLibrary.simpleMessage("パレット"),
    "password": MessageLookupByLibrary.simpleMessage("パスワード"),
    "passwordChangeSuccess": MessageLookupByLibrary.simpleMessage("パスワード変更成功"),
    "passwordChangeSuccessMsg": MessageLookupByLibrary.simpleMessage(
      "パスワード変更成功",
    ),
    "passwordHint": MessageLookupByLibrary.simpleMessage("パスワードを入力"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage("パスワードが一致しません"),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage("パスワードが一致しません"),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage("パスワードは8文字以上必要です"),
    "paste": MessageLookupByLibrary.simpleMessage("貼り付け"),
    "paymentFailed": m17,
    "paymentMethod": MessageLookupByLibrary.simpleMessage("支払い方法"),
    "paypalAccount": MessageLookupByLibrary.simpleMessage("Paypalアカウント"),
    "pendingCommission": MessageLookupByLibrary.simpleMessage("確認中の報酬"),
    "permanentSubscription": MessageLookupByLibrary.simpleMessage(
      "永久サブスクリプション",
    ),
    "personalizationSection": MessageLookupByLibrary.simpleMessage("個人設定"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "WebDAVをバインドしてください",
    ),
    "pleaseConfirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "新しいパスワードを再度入力してください",
    ),
    "pleaseConfirmNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "新しいパスワードを再度入力してください",
    ),
    "pleaseEnterAlipayAccount": MessageLookupByLibrary.simpleMessage(
      "Alipayアカウントを入力してください",
    ),
    "pleaseEnterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "現在のパスワードを入力してください",
    ),
    "pleaseEnterCurrentPasswordHint": MessageLookupByLibrary.simpleMessage(
      "現在のパスワードを入力してください",
    ),
    "pleaseEnterNewPassword": MessageLookupByLibrary.simpleMessage(
      "新しいパスワードを入力してください",
    ),
    "pleaseEnterNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "新しいパスワードを入力してください",
    ),
    "pleaseEnterPaypalAccount": MessageLookupByLibrary.simpleMessage(
      "Paypalアカウントを入力してください",
    ),
    "pleaseEnterReplyContent": MessageLookupByLibrary.simpleMessage(
      "返信内容を入力してください",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "スクリプト名を入力してください",
    ),
    "pleaseEnterTransferAmount": MessageLookupByLibrary.simpleMessage(
      "残高に移転する金額を入力してください",
    ),
    "pleaseEnterTransferAmountHint": MessageLookupByLibrary.simpleMessage(
      "振替金額を入力してください",
    ),
    "pleaseEnterUsdtWalletAddress": MessageLookupByLibrary.simpleMessage(
      "USDTウォレットアドレスを入力してください",
    ),
    "pleaseEnterValidAmount": MessageLookupByLibrary.simpleMessage(
      "有効な金額を入力してください",
    ),
    "pleaseEnterWithdrawalAccount": MessageLookupByLibrary.simpleMessage(
      "出金アカウントを入力してください",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "管理者パスワードを入力",
    ),
    "pleaseLogin": MessageLookupByLibrary.simpleMessage("ログインしてください"),
    "pleaseLogin2": MessageLookupByLibrary.simpleMessage("先にログインしてください"),
    "pleaseSelectWithdrawalMethod": MessageLookupByLibrary.simpleMessage(
      "出金方法を選択してください",
    ),
    "pleaseUploadFile": MessageLookupByLibrary.simpleMessage(
      "ファイルをアップロードしてください",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "有効なQRコードをアップロードしてください",
    ),
    "popupNotification": MessageLookupByLibrary.simpleMessage("ポップアップ"),
    "port": MessageLookupByLibrary.simpleMessage("ポート"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage("別のポートを入力してください"),
    "portTip": m18,
    "preferH3": MessageLookupByLibrary.simpleMessage("HTTP3優先"),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage("DOHのHTTP/3を優先使用"),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("キーボードを押してください"),
    "preview": MessageLookupByLibrary.simpleMessage("プレビュー"),
    "pricePerMonth": m19,
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("プライバシーポリシー"),
    "privacyPolicyInDevelopment": MessageLookupByLibrary.simpleMessage(
      "プライバシーポリシーページ開発中",
    ),
    "productInfo": MessageLookupByLibrary.simpleMessage("商品情報"),
    "productName": MessageLookupByLibrary.simpleMessage("商品名"),
    "productTraffic": MessageLookupByLibrary.simpleMessage("商品トラフィック"),
    "profile": MessageLookupByLibrary.simpleMessage("プロファイル"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("有効な間隔形式を入力してください"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("自動更新間隔を入力してください"),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "プロファイルが変更されました。自動更新を無効化しますか？",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイル名を入力してください",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイル解析エラー",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "有効なプロファイルURLを入力してください",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルURLを入力してください",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("プロファイル一覧"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("プロファイルの並び替え"),
    "project": MessageLookupByLibrary.simpleMessage("プロジェクト"),
    "providers": MessageLookupByLibrary.simpleMessage("プロバイダー"),
    "proxies": MessageLookupByLibrary.simpleMessage("プロキシ"),
    "proxiesSetting": MessageLookupByLibrary.simpleMessage("プロキシ設定"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループ"),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("プロキシネームサーバー"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "プロキシノード解決用ドメイン",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("プロキシポート"),
    "proxyPortDesc": MessageLookupByLibrary.simpleMessage("Clashのリスニングポートを設定"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("プロキシプロバイダー"),
    "publishedAt": m20,
    "purchase": MessageLookupByLibrary.simpleMessage("購入"),
    "purchasePlan": MessageLookupByLibrary.simpleMessage("プラン購入"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("純黒モード"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QRコード"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage("QRコードをスキャンしてプロファイルを取得"),
    "quarterlyPlan": MessageLookupByLibrary.simpleMessage("四半期"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("レインボー"),
    "recovery": MessageLookupByLibrary.simpleMessage("復元"),
    "recoveryAll": MessageLookupByLibrary.simpleMessage("全データ復元"),
    "recoveryProfiles": MessageLookupByLibrary.simpleMessage("プロファイルのみ復元"),
    "recoveryStrategy": MessageLookupByLibrary.simpleMessage("リカバリー戦略"),
    "recoveryStrategy_compatible": MessageLookupByLibrary.simpleMessage("互換性"),
    "recoveryStrategy_override": MessageLookupByLibrary.simpleMessage(
      "オーバーライド",
    ),
    "recoverySuccess": MessageLookupByLibrary.simpleMessage("復元成功"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redirポート"),
    "redo": MessageLookupByLibrary.simpleMessage("やり直す"),
    "refresh": MessageLookupByLibrary.simpleMessage("更新"),
    "regExp": MessageLookupByLibrary.simpleMessage("正規表現"),
    "register": MessageLookupByLibrary.simpleMessage("登録"),
    "registerButton": MessageLookupByLibrary.simpleMessage("登録"),
    "registerError": MessageLookupByLibrary.simpleMessage("登録失敗"),
    "registerFailed": MessageLookupByLibrary.simpleMessage("登録に失敗しました"),
    "registerSuccess": MessageLookupByLibrary.simpleMessage("登録成功"),
    "registerTitle": MessageLookupByLibrary.simpleMessage("アカウント登録"),
    "registeredUsersCount": MessageLookupByLibrary.simpleMessage("登録ユーザー数"),
    "remote": MessageLookupByLibrary.simpleMessage("リモート"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVにデータをバックアップ",
    ),
    "remoteRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVからデータを復元",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("削除"),
    "rename": MessageLookupByLibrary.simpleMessage("リネーム"),
    "reply": MessageLookupByLibrary.simpleMessage("返信"),
    "replyTicketFailed": MessageLookupByLibrary.simpleMessage(
      "チケットへの返信に失敗しました",
    ),
    "requests": MessageLookupByLibrary.simpleMessage("リクエスト"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage("最近のリクエスト記録を表示"),
    "reset": MessageLookupByLibrary.simpleMessage("リセット"),
    "resetInfo": m21,
    "resetPassword": MessageLookupByLibrary.simpleMessage("パスワードリセット"),
    "resetPasswordButton": MessageLookupByLibrary.simpleMessage("リセット確認"),
    "resetPasswordError": MessageLookupByLibrary.simpleMessage("リセット失敗"),
    "resetPasswordFailed": MessageLookupByLibrary.simpleMessage(
      "パスワードリセットに失敗しました",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage("リセットメール送信成功"),
    "resetTip": MessageLookupByLibrary.simpleMessage("リセットを確定"),
    "resetTraffic": MessageLookupByLibrary.simpleMessage("トラフィックリセット"),
    "resources": MessageLookupByLibrary.simpleMessage("リソース"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage("外部リソース関連情報"),
    "respectRules": MessageLookupByLibrary.simpleMessage("ルール尊重"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS接続がルールに従う（proxy-server-nameserverの設定が必要）",
    ),
    "responseFormatError": MessageLookupByLibrary.simpleMessage("レスポンス形式エラー"),
    "retry": MessageLookupByLibrary.simpleMessage("再試行"),
    "retryBtnText": MessageLookupByLibrary.simpleMessage("再試行"),
    "retryButton": MessageLookupByLibrary.simpleMessage("再試行"),
    "routeAddress": MessageLookupByLibrary.simpleMessage("ルートアドレス"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage("ルートアドレスを設定"),
    "routeMode": MessageLookupByLibrary.simpleMessage("ルートモード"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "プライベートルートをバイパス",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("設定を使用"),
    "ru": MessageLookupByLibrary.simpleMessage("ロシア語"),
    "rule": MessageLookupByLibrary.simpleMessage("ルール"),
    "ruleName": MessageLookupByLibrary.simpleMessage("ルール名"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("ルールプロバイダー"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("ルール対象"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("変更を保存しますか？"),
    "saveTip": MessageLookupByLibrary.simpleMessage("保存してもよろしいですか？"),
    "script": MessageLookupByLibrary.simpleMessage("スクリプト"),
    "search": MessageLookupByLibrary.simpleMessage("検索"),
    "seconds": MessageLookupByLibrary.simpleMessage("秒"),
    "selectAll": MessageLookupByLibrary.simpleMessage("すべて選択"),
    "selectNode": MessageLookupByLibrary.simpleMessage("ノード選択"),
    "selectPaymentMethod": MessageLookupByLibrary.simpleMessage("支払い方法選択"),
    "selectPlan": MessageLookupByLibrary.simpleMessage("選択"),
    "selected": MessageLookupByLibrary.simpleMessage("選択済み"),
    "selectedCountTitle": m22,
    "send": MessageLookupByLibrary.simpleMessage("送信"),
    "sendCode": MessageLookupByLibrary.simpleMessage("コード送信"),
    "sendCodeError": MessageLookupByLibrary.simpleMessage("コード送信失敗"),
    "sendCodeSuccess": MessageLookupByLibrary.simpleMessage("コード送信成功"),
    "sendVerificationCodeFailed": MessageLookupByLibrary.simpleMessage(
      "認証コードの送信に失敗しました",
    ),
    "serverError": m23,
    "setDirectConnection": MessageLookupByLibrary.simpleMessage("直接接続設定"),
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "settingsFailed": MessageLookupByLibrary.simpleMessage("設定に失敗しました"),
    "show": MessageLookupByLibrary.simpleMessage("表示"),
    "shrink": MessageLookupByLibrary.simpleMessage("縮小"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("バックグラウンド起動"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage("バックグラウンドで起動"),
    "size": MessageLookupByLibrary.simpleMessage("サイズ"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socksポート"),
    "sort": MessageLookupByLibrary.simpleMessage("並び替え"),
    "source": MessageLookupByLibrary.simpleMessage("ソース"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("送信元IP"),
    "stackMode": MessageLookupByLibrary.simpleMessage("スタックモード"),
    "standard": MessageLookupByLibrary.simpleMessage("標準"),
    "start": MessageLookupByLibrary.simpleMessage("開始"),
    "startVpn": MessageLookupByLibrary.simpleMessage("VPNを開始中..."),
    "status": MessageLookupByLibrary.simpleMessage("ステータス"),
    "statusDesc": MessageLookupByLibrary.simpleMessage("無効時はシステムDNSを使用"),
    "stop": MessageLookupByLibrary.simpleMessage("停止"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("VPNを停止中..."),
    "style": MessageLookupByLibrary.simpleMessage("スタイル"),
    "subRule": MessageLookupByLibrary.simpleMessage("サブルール"),
    "submit": MessageLookupByLibrary.simpleMessage("送信"),
    "submitBtnText": MessageLookupByLibrary.simpleMessage("提出"),
    "subscribe": MessageLookupByLibrary.simpleMessage("定期購読"),
    "sync": MessageLookupByLibrary.simpleMessage("同期"),
    "system": MessageLookupByLibrary.simpleMessage("システム"),
    "systemApp": MessageLookupByLibrary.simpleMessage("システムアプリ"),
    "systemFont": MessageLookupByLibrary.simpleMessage("システムフォント"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("システムプロキシ"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "HTTPプロキシをVpnServiceに接続",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("タブ"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("タブアニメーション"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage("モバイル表示でのみ有効"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP並列処理"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage("TCP並列処理を許可"),
    "telegram": MessageLookupByLibrary.simpleMessage("テレグラム"),
    "telegramGroup": MessageLookupByLibrary.simpleMessage("Telegramグループ"),
    "testUrl": MessageLookupByLibrary.simpleMessage("URLテスト"),
    "textScale": MessageLookupByLibrary.simpleMessage("テキストスケーリング"),
    "theme": MessageLookupByLibrary.simpleMessage("テーマ"),
    "themeColor": MessageLookupByLibrary.simpleMessage("テーマカラー"),
    "themeDesc": MessageLookupByLibrary.simpleMessage("ダークモードの設定、色の調整"),
    "themeMode": MessageLookupByLibrary.simpleMessage("テーマモード"),
    "threeColumns": MessageLookupByLibrary.simpleMessage("3列"),
    "threeYearlyPlan": MessageLookupByLibrary.simpleMessage("3年間"),
    "ticketCloseFailed": m24,
    "ticketClosedSuccess": MessageLookupByLibrary.simpleMessage(
      "チケットが正常に閉じられました",
    ),
    "ticketDetails": MessageLookupByLibrary.simpleMessage("チケット詳細"),
    "ticketLevel": MessageLookupByLibrary.simpleMessage("優先度"),
    "ticketLevelHigh": MessageLookupByLibrary.simpleMessage("高"),
    "ticketLevelLow": MessageLookupByLibrary.simpleMessage("低"),
    "ticketLevelMedium": MessageLookupByLibrary.simpleMessage("中"),
    "ticketNotFound": MessageLookupByLibrary.simpleMessage("チケットが見つかりません"),
    "ticketPriorityHigh": MessageLookupByLibrary.simpleMessage("高優先度"),
    "ticketPriorityLow": MessageLookupByLibrary.simpleMessage("低優先度"),
    "ticketPriorityMedium": MessageLookupByLibrary.simpleMessage("中優先度"),
    "ticketPriorityUrgent": MessageLookupByLibrary.simpleMessage("緊急"),
    "ticketStatusClosed": MessageLookupByLibrary.simpleMessage("クローズ済"),
    "ticketStatusOpen": MessageLookupByLibrary.simpleMessage("処理中"),
    "ticketSubject": MessageLookupByLibrary.simpleMessage("件名"),
    "tight": MessageLookupByLibrary.simpleMessage("密"),
    "time": MessageLookupByLibrary.simpleMessage("時間"),
    "tip": MessageLookupByLibrary.simpleMessage("ヒント"),
    "toggle": MessageLookupByLibrary.simpleMessage("トグル"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("トーンスポット"),
    "tools": MessageLookupByLibrary.simpleMessage("ツール"),
    "tools2": MessageLookupByLibrary.simpleMessage("ツール"),
    "toolsEntryHidden": MessageLookupByLibrary.simpleMessage("ツール入口を非表示にしました"),
    "toolsEntryShown": MessageLookupByLibrary.simpleMessage("ツール入口が表示されました"),
    "total": MessageLookupByLibrary.simpleMessage("合計"),
    "totalCommissionEarned": MessageLookupByLibrary.simpleMessage("累計獲得報酬"),
    "totalOrdersCount": m25,
    "totalTicketsCount": m26,
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxyポート"),
    "trafficEmailReminder": MessageLookupByLibrary.simpleMessage("トラフィックメール通知"),
    "trafficEmailReminderDisabled": MessageLookupByLibrary.simpleMessage(
      "トラフィックメール通知が無効になりました",
    ),
    "trafficEmailReminderEnabled": MessageLookupByLibrary.simpleMessage(
      "トラフィックメール通知が有効になりました",
    ),
    "trafficStats": m27,
    "trafficUsage": MessageLookupByLibrary.simpleMessage("トラフィック使用量"),
    "transfer": MessageLookupByLibrary.simpleMessage("移転"),
    "transferAllAmount": MessageLookupByLibrary.simpleMessage("全額振替"),
    "transferAmount": MessageLookupByLibrary.simpleMessage("移転金額"),
    "transferAmountCannotExceedCommissionBalance":
        MessageLookupByLibrary.simpleMessage("移転金額はコミッション残高を超えることはできません"),
    "transferAmountExceedsBalance": MessageLookupByLibrary.simpleMessage(
      "振替金額はコミッション残高を超えることはできません",
    ),
    "transferAmountValidError": MessageLookupByLibrary.simpleMessage(
      "有効な金額を入力してください",
    ),
    "transferCommissionToBalance": MessageLookupByLibrary.simpleMessage(
      "コミッションを残高に移転",
    ),
    "transferFailedMsg": MessageLookupByLibrary.simpleMessage("振替に失敗しました"),
    "transferredBalanceOnlyForAppConsumption": m28,
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage("管理者モードでのみ有効"),
    "twoColumns": MessageLookupByLibrary.simpleMessage("2列"),
    "twoYearlyPlan": MessageLookupByLibrary.simpleMessage("2年間"),
    "typePeriod": MessageLookupByLibrary.simpleMessage("タイプ/期間"),
    "ua": MessageLookupByLibrary.simpleMessage("ユーザーエージェント"),
    "unableToUpdateCurrentProfileDesc": MessageLookupByLibrary.simpleMessage(
      "現在のプロファイルを更新できません",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("元に戻す"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("統一遅延"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "ハンドシェイクなどの余分な遅延を削除",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("不明"),
    "unnamed": MessageLookupByLibrary.simpleMessage("無題"),
    "unpaidOrderTip": MessageLookupByLibrary.simpleMessage("未払いの注文があります"),
    "update": MessageLookupByLibrary.simpleMessage("更新"),
    "updateSuccess": MessageLookupByLibrary.simpleMessage("サブスクリプション更新成功"),
    "updateUserInfoFailed": MessageLookupByLibrary.simpleMessage(
      "ユーザー情報の更新に失敗しました。後でもう一度お試しください",
    ),
    "upload": MessageLookupByLibrary.simpleMessage("アップロード"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("URL経由でプロファイルを取得"),
    "urlTip": m29,
    "usdtWalletAddress": MessageLookupByLibrary.simpleMessage("USDTウォレットアドレス"),
    "useHosts": MessageLookupByLibrary.simpleMessage("ホストを使用"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("システムホストを使用"),
    "userAgreement": MessageLookupByLibrary.simpleMessage("利用規約"),
    "userAgreementInDevelopment": MessageLookupByLibrary.simpleMessage(
      "利用規約ページ開発中",
    ),
    "userCenter": MessageLookupByLibrary.simpleMessage("ユーザーセンター"),
    "userInfo": MessageLookupByLibrary.simpleMessage("ユーザー情報"),
    "userStats": MessageLookupByLibrary.simpleMessage("ユーザー統計"),
    "value": MessageLookupByLibrary.simpleMessage("値"),
    "verify": MessageLookupByLibrary.simpleMessage("確認"),
    "verifyCouponFailed": MessageLookupByLibrary.simpleMessage(
      "クーポンの認証に失敗しました",
    ),
    "verifyingCoupon": MessageLookupByLibrary.simpleMessage("クーポンを確認中..."),
    "versionInfo": MessageLookupByLibrary.simpleMessage("バージョン情報"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("ビブラント"),
    "view": MessageLookupByLibrary.simpleMessage("表示"),
    "viewDetails": MessageLookupByLibrary.simpleMessage("詳細を見る"),
    "viewTicketDetails": MessageLookupByLibrary.simpleMessage("詳細を見る"),
    "vpn": MessageLookupByLibrary.simpleMessage("仮想プライベートネットワーク"),
    "vpnDesc": MessageLookupByLibrary.simpleMessage("VPN関連設定の変更"),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "VpnService経由で全システムトラフィックをルーティング",
    ),
    "vpnSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "HTTPプロキシをVpnServiceに接続",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage("変更はVPN再起動後に有効"),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage("WebDAV設定"),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("ホワイトリストモード"),
    "withdrawApplyFailed": m30,
    "withdrawApplySuccess": MessageLookupByLibrary.simpleMessage("出金申請成功"),
    "withdrawalAccount": MessageLookupByLibrary.simpleMessage("出金アカウント"),
    "withdrawalAccountLabel": MessageLookupByLibrary.simpleMessage("出金アカウント"),
    "withdrawalApplication": MessageLookupByLibrary.simpleMessage("出金申請"),
    "withdrawalApplicationFailed": MessageLookupByLibrary.simpleMessage(
      "出金申請に失敗しました",
    ),
    "withdrawalApplicationSubmitted": MessageLookupByLibrary.simpleMessage(
      "出金申請が提出されました。審査をお待ちください",
    ),
    "withdrawalFunctionClosed": MessageLookupByLibrary.simpleMessage(
      "出金機能が閉じられています",
    ),
    "withdrawalFunctionDisabled": MessageLookupByLibrary.simpleMessage(
      "出金機能が無効になっています",
    ),
    "withdrawalInstructions": MessageLookupByLibrary.simpleMessage("出金説明"),
    "withdrawalInstructionsText": MessageLookupByLibrary.simpleMessage(
      "• 出金申請の提出後、手動審査が必要です\n• 承認後、資金があなたのアカウントに転送されます\n• 出金アカウント情報が正確であることを確認してください",
    ),
    "withdrawalMethod": MessageLookupByLibrary.simpleMessage("出金方法"),
    "withdrawalMethodLabel": MessageLookupByLibrary.simpleMessage("出金方法"),
    "withdrawalRequestFailed": MessageLookupByLibrary.simpleMessage(
      "出金申請が失敗しました",
    ),
    "withdrawalRequestSubmitted": MessageLookupByLibrary.simpleMessage(
      "出金申請が提出されました。審査をお待ちください",
    ),
    "withdrawalSystemTemporarilyClosed": MessageLookupByLibrary.simpleMessage(
      "システムが一時的に出金機能を閉じています",
    ),
    "yearlyPlan": MessageLookupByLibrary.simpleMessage("年間"),
    "years": MessageLookupByLibrary.simpleMessage("年"),
    "zeroCommissionBalanceTransfer": MessageLookupByLibrary.simpleMessage(
      "報酬残高がゼロのため移転できません",
    ),
    "zeroCommissionBalanceWithdraw": MessageLookupByLibrary.simpleMessage(
      "報酬残高がゼロのため出金できません",
    ),
    "zh_CN": MessageLookupByLibrary.simpleMessage("簡体字中国語"),
    "zoom": MessageLookupByLibrary.simpleMessage("ズーム"),
  };
}
