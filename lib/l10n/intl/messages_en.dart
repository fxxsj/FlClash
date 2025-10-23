// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(error) => "Change failed: ${error}";

  static String m1(error) => "Commission transfer failed: ${error}";

  static String m2(error) => "Failed to decrypt configuration: ${error}";

  static String m3(subject) =>
      "Are you sure you want to close ticket \"${subject}\"?";

  static String m4(error) => "Copy failed: ${error}";

  static String m5(label) =>
      "Are you sure you want to delete the selected ${label}?";

  static String m6(label) =>
      "Are you sure you want to delete the current ${label}?";

  static String m7(label) => "${label} cannot be empty";

  static String m8(label) => "Current ${label} already exists";

  static String m9(date, days) => "Expires on ${date}, ${days} days left.";

  static String m10(error) => "Failed to generate invite code: ${error}";

  static String m11(error) => "Failed to load configuration: ${error}";

  static String m12(label) => "No ${label} at the moment";

  static String m13(label) => "${label} must be a number";

  static String m14(online, limit) => "Online devices ${online}/${limit}";

  static String m15(error) => "Failed to open link: ${error}";

  static String m16(count) => "${count} orders in total";

  static String m17(error) => "Payment failed: ${error}";

  static String m18(label) => "${label} must be between 1024 and 49151";

  static String m19(price) => "Monthly avg ¥${price}";

  static String m20(date) => "Published on ${date}";

  static String m21(resetDay) => "Traffic will reset in ${resetDay} days";

  static String m22(count) => "${count} items have been selected";

  static String m23(code) => "Server error: ${code}";

  static String m24(error) => "Failed to close ticket: ${error}";

  static String m25(count) => "Total ${count} orders";

  static String m26(count) => "Total ${count} tickets";

  static String m27(used, total) => "Used ${used} / Total ${total} ";

  static String m28(appTitle) =>
      "Transferred balance only for ${appTitle} consumption";

  static String m29(label) => "${label} must be a url";

  static String m30(error) => "Withdrawal application failed: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "accessControl": MessageLookupByLibrary.simpleMessage("AccessControl"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Only allow selected app to enter VPN",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Configure application access proxy",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "The selected application will be excluded from VPN",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "action": MessageLookupByLibrary.simpleMessage("Action"),
    "action_mode": MessageLookupByLibrary.simpleMessage("Switch mode"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "action_start": MessageLookupByLibrary.simpleMessage("Start/Stop"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("Show/Hide"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addRule": MessageLookupByLibrary.simpleMessage("Add rule"),
    "addedOriginRules": MessageLookupByLibrary.simpleMessage(
      "Attach on the original rules",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "addressHelp": MessageLookupByLibrary.simpleMessage(
      "WebDAV server address",
    ),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid WebDAV address",
    ),
    "adminAutoLaunch": MessageLookupByLibrary.simpleMessage(
      "Admin auto launch",
    ),
    "adminAutoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Boot up by using admin mode",
    ),
    "ago": MessageLookupByLibrary.simpleMessage(" Ago"),
    "agree": MessageLookupByLibrary.simpleMessage("Agree"),
    "alipay": MessageLookupByLibrary.simpleMessage("Alipay"),
    "allApps": MessageLookupByLibrary.simpleMessage("All apps"),
    "allCommissionBalanceWillBeApplied": MessageLookupByLibrary.simpleMessage(
      "All commission balance will be applied for withdrawal",
    ),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Allow applications to bypass VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Some apps can bypass VPN when turned on",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("AllowLan"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Allow access proxy through the LAN",
    ),
    "app": MessageLookupByLibrary.simpleMessage("App"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "App access control",
    ),
    "appDesc": MessageLookupByLibrary.simpleMessage(
      "Processing app related settings",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Multi-platform proxy client based on ClashMeta",
    ),
    "appFeatures": MessageLookupByLibrary.simpleMessage(
      "Simple, easy to use, open-source and ad-free",
    ),
    "appUrlNotConfigured": MessageLookupByLibrary.simpleMessage(
      "App URL not configured",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Application"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Modify application related settings",
    ),
    "applicationFailed": MessageLookupByLibrary.simpleMessage(
      "Application failed",
    ),
    "applicationSection": MessageLookupByLibrary.simpleMessage("Application"),
    "applyWithdrawal": MessageLookupByLibrary.simpleMessage(
      "Apply for Withdrawal",
    ),
    "asn": MessageLookupByLibrary.simpleMessage("ASN"),
    "auto": MessageLookupByLibrary.simpleMessage("Auto"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage(
      "Auto check updates",
    ),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "Auto check for updates when the app starts",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Auto close connections",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Auto close connections after change node",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Auto launch"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Follow the system self startup",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("AutoRun"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Auto run when the application is opened",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Auto set system DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Auto update"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Auto update interval (minutes)",
    ),
    "availableCommission": MessageLookupByLibrary.simpleMessage(
      "Available Commission",
    ),
    "availableWithdrawalAmount": MessageLookupByLibrary.simpleMessage(
      "Available withdrawal amount",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "backupAndRecovery": MessageLookupByLibrary.simpleMessage(
      "Backup and Recovery",
    ),
    "backupAndRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Sync data via WebDAV or file",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("Backup success"),
    "balance": MessageLookupByLibrary.simpleMessage("Balance"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Basic configuration"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the basic configuration globally",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Bind"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("Blacklist mode"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Bypass domain"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Only takes effect when the system proxy is enabled",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "The cache is corrupt. Do you want to clear it?",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelFilterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Cancel filter system app",
    ),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("Cancel Order"),
    "cancelOrderConfirmTip": MessageLookupByLibrary.simpleMessage(
      "If you have already paid, canceling the order may cause the payment to fail. Are you sure you want to cancel the order?",
    ),
    "cancelOrderFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to cancel order",
    ),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Cancel select all",
    ),
    "cannotOpenTelegramLink": MessageLookupByLibrary.simpleMessage(
      "Unable to open Telegram link",
    ),
    "changeFailedMsg": MessageLookupByLibrary.simpleMessage("Change failed"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "changePasswordFailed": m0,
    "checkError": MessageLookupByLibrary.simpleMessage("Check error"),
    "checkOrderStatusFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to check order status",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Check for updates"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "The current application is already the latest version",
    ),
    "checking": MessageLookupByLibrary.simpleMessage("Checking..."),
    "checkout": MessageLookupByLibrary.simpleMessage("Checkout"),
    "clearData": MessageLookupByLibrary.simpleMessage("Clear Data"),
    "clickToPay": MessageLookupByLibrary.simpleMessage("Click to Pay"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("Export clipboard"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("Clipboard import"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "closeOrder": MessageLookupByLibrary.simpleMessage("Close Order"),
    "closeTicket": MessageLookupByLibrary.simpleMessage("Close Ticket"),
    "closeTicketButton": MessageLookupByLibrary.simpleMessage("Close"),
    "closeTicketFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to close ticket",
    ),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Color schemes"),
    "columns": MessageLookupByLibrary.simpleMessage("Columns"),
    "commissionDistribution": MessageLookupByLibrary.simpleMessage(
      "Commission distribution",
    ),
    "commissionRate": MessageLookupByLibrary.simpleMessage("Commission Rate"),
    "commissionTransferFailed": m1,
    "commissionTransferFailed2": MessageLookupByLibrary.simpleMessage(
      "Commission transfer failed",
    ),
    "commissionTransferPageTitle": MessageLookupByLibrary.simpleMessage(
      "Transfer Commission",
    ),
    "commissionTransferSuccess": MessageLookupByLibrary.simpleMessage(
      "Commission transfer successful",
    ),
    "commissionTransferSuccessMsg": MessageLookupByLibrary.simpleMessage(
      "Commission transfer successful",
    ),
    "commissionWithdrawal": MessageLookupByLibrary.simpleMessage(
      "Commission Withdrawal",
    ),
    "compatible": MessageLookupByLibrary.simpleMessage("Compatibility mode"),
    "compatibleDesc": MessageLookupByLibrary.simpleMessage(
      "Opening it will lose part of its application ability and gain the support of full amount of Clash.",
    ),
    "complete": MessageLookupByLibrary.simpleMessage("Complete"),
    "completeBtnText": MessageLookupByLibrary.simpleMessage("Complete"),
    "configDecryptFailed": m2,
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmCloseTicket": m3,
    "confirmLogout": MessageLookupByLibrary.simpleMessage("Confirm Logout"),
    "confirmLogoutMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to logout?",
    ),
    "confirmNewPasswordAgain": MessageLookupByLibrary.simpleMessage(
      "Confirm New Password Again",
    ),
    "confirmNewPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm New Password Again",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Please confirm password",
    ),
    "confirmPayment": MessageLookupByLibrary.simpleMessage("Confirm Payment"),
    "confirmTransfer": MessageLookupByLibrary.simpleMessage("Confirm"),
    "connectionTools": MessageLookupByLibrary.simpleMessage("Connection Tools"),
    "connections": MessageLookupByLibrary.simpleMessage("Connections"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "View current connections data",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Connectivity："),
    "contactMe": MessageLookupByLibrary.simpleMessage("Contact me"),
    "content": MessageLookupByLibrary.simpleMessage("Content"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Content"),
    "copy": MessageLookupByLibrary.simpleMessage("Copy"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Copying environment variables",
    ),
    "copyFailed": m4,
    "copyLink": MessageLookupByLibrary.simpleMessage("Copy link"),
    "copyLinkButton": MessageLookupByLibrary.simpleMessage("Copy Link"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Copy success"),
    "core": MessageLookupByLibrary.simpleMessage("Core"),
    "coreInfo": MessageLookupByLibrary.simpleMessage("Core info"),
    "country": MessageLookupByLibrary.simpleMessage("Country"),
    "couponCode": MessageLookupByLibrary.simpleMessage("Coupon Code"),
    "couponCodeHint": MessageLookupByLibrary.simpleMessage(
      "Enter coupon code (optional)",
    ),
    "couponValid": MessageLookupByLibrary.simpleMessage("Coupon code valid"),
    "couponVerifySuccess": MessageLookupByLibrary.simpleMessage(
      "Coupon verified successfully",
    ),
    "crashTest": MessageLookupByLibrary.simpleMessage("Crash test"),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "createOrder": MessageLookupByLibrary.simpleMessage("Create Order"),
    "createOrderFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to create order",
    ),
    "createTicket": MessageLookupByLibrary.simpleMessage("Create Ticket"),
    "createTicketFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to create ticket",
    ),
    "createdAt": MessageLookupByLibrary.simpleMessage("Created At"),
    "currentAvailableWithdrawalAmount": MessageLookupByLibrary.simpleMessage(
      "Current available withdrawal amount",
    ),
    "currentCommissionBalance": MessageLookupByLibrary.simpleMessage(
      "Current commission balance",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Current Password"),
    "currentPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Current Password",
    ),
    "currentRemainingCommission": MessageLookupByLibrary.simpleMessage(
      "Current Remaining Commission",
    ),
    "currentVersion": MessageLookupByLibrary.simpleMessage("Current Version"),
    "currentVersionLabel": MessageLookupByLibrary.simpleMessage(
      "Current Version",
    ),
    "customerSupport": MessageLookupByLibrary.simpleMessage("Customer Support"),
    "customerSupport2": MessageLookupByLibrary.simpleMessage(
      "Customer Support",
    ),
    "cut": MessageLookupByLibrary.simpleMessage("Cut"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "days": MessageLookupByLibrary.simpleMessage("Days"),
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Default nameserver",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "For resolving DNS server",
    ),
    "defaultSort": MessageLookupByLibrary.simpleMessage("Sort by default"),
    "defaultText": MessageLookupByLibrary.simpleMessage("Default"),
    "delay": MessageLookupByLibrary.simpleMessage("Delay"),
    "delaySort": MessageLookupByLibrary.simpleMessage("Sort by delay"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteMultipTip": m5,
    "deleteTip": m6,
    "deposit": MessageLookupByLibrary.simpleMessage("Deposit"),
    "depositOrder": MessageLookupByLibrary.simpleMessage("Deposit Order"),
    "desc": MessageLookupByLibrary.simpleMessage(
      "A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.",
    ),
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Relying on third-party api is for reference only",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Developer mode"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Developer mode is enabled.",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Direct"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Disclaimer"),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "This software is only used for non-commercial purposes such as learning exchanges and scientific research. It is strictly prohibited to use this software for commercial purposes. Any commercial activity, if any, has nothing to do with this software.",
    ),
    "discount": MessageLookupByLibrary.simpleMessage("Discount"),
    "discountAmount": MessageLookupByLibrary.simpleMessage("Discount Amount"),
    "discountedPrice": MessageLookupByLibrary.simpleMessage("Discounted Price"),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage(
      "Discover the new version",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Discovery a new version",
    ),
    "distributionRecord": MessageLookupByLibrary.simpleMessage(
      "Distribution Record",
    ),
    "distributionRecordInDevelopment": MessageLookupByLibrary.simpleMessage(
      "Distribution record feature in development",
    ),
    "dns": MessageLookupByLibrary.simpleMessage("DNS"),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Update DNS related settings",
    ),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNS mode"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Do you want to pass",
    ),
    "domain": MessageLookupByLibrary.simpleMessage("Domain"),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editRules": MessageLookupByLibrary.simpleMessage("Edit Rules"),
    "emailCodeHint": MessageLookupByLibrary.simpleMessage(
      "Please enter verification code",
    ),
    "emailHint": MessageLookupByLibrary.simpleMessage("Please enter email"),
    "emailSuffixError": MessageLookupByLibrary.simpleMessage(
      "Email suffix is not allowed",
    ),
    "emptyTip": m7,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enableOverride": MessageLookupByLibrary.simpleMessage("Enable override"),
    "enterMessage": MessageLookupByLibrary.simpleMessage("Enter message"),
    "entries": MessageLookupByLibrary.simpleMessage(" entries"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("An error occurred"),
    "exclude": MessageLookupByLibrary.simpleMessage("Hidden from recent tasks"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "When the app is in the background, the app is hidden from the recent task",
    ),
    "existsTip": m8,
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "expand": MessageLookupByLibrary.simpleMessage("Standard"),
    "expirationInfo": m9,
    "expirationTime": MessageLookupByLibrary.simpleMessage("Expiration time"),
    "expireTime": MessageLookupByLibrary.simpleMessage("Expire time"),
    "expired": MessageLookupByLibrary.simpleMessage("Expired"),
    "expiryEmailReminder": MessageLookupByLibrary.simpleMessage(
      "Expiry Email Reminder",
    ),
    "expiryEmailReminderDisabled": MessageLookupByLibrary.simpleMessage(
      "Expiry email reminder disabled",
    ),
    "expiryEmailReminderEnabled": MessageLookupByLibrary.simpleMessage(
      "Expiry email reminder enabled",
    ),
    "exportFile": MessageLookupByLibrary.simpleMessage("Export file"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Export logs"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Export Success"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Expressive"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "ExternalController",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Once enabled, the Clash kernel can be controlled on port 9090",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("External link"),
    "externalResources": MessageLookupByLibrary.simpleMessage(
      "External resources",
    ),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeip filter"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip range"),
    "fallback": MessageLookupByLibrary.simpleMessage("Fallback"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Generally use offshore DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Fallback filter"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Fidelity"),
    "file": MessageLookupByLibrary.simpleMessage("File"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("Directly upload profile"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "The file has been modified. Do you want to save the changes?",
    ),
    "filterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Filter system app",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Find process"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "There is a certain performance loss after opening",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("FontFamily"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "fourColumns": MessageLookupByLibrary.simpleMessage("Four columns"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("FruitSalad"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "generalDesc": MessageLookupByLibrary.simpleMessage(
      "Modify general settings",
    ),
    "generateInviteCode": MessageLookupByLibrary.simpleMessage("Generate Code"),
    "generateInviteCodeButton": MessageLookupByLibrary.simpleMessage(
      "Generate Invite Code",
    ),
    "generateInviteCodeFailed": m10,
    "geoData": MessageLookupByLibrary.simpleMessage("GeoData"),
    "geoIp": MessageLookupByLibrary.simpleMessage("GeoIp"),
    "geoSite": MessageLookupByLibrary.simpleMessage("GeoSite"),
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo Low Memory Mode",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Enabling will use the Geo low memory loader",
    ),
    "geoip": MessageLookupByLibrary.simpleMessage("Geoip"),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Geoip code"),
    "geosite": MessageLookupByLibrary.simpleMessage("Geosite"),
    "getConfigInfoFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get configuration information, please try again later",
    ),
    "getNoticeListFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get notice list",
    ),
    "getOrderDetailFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get order details",
    ),
    "getOrderListFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get order list",
    ),
    "getOriginRules": MessageLookupByLibrary.simpleMessage(
      "Get original rules",
    ),
    "getPaymentLinkFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get payment link",
    ),
    "getPaymentMethodsFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get payment methods",
    ),
    "getPlansFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get subscription plans, please refresh and try again",
    ),
    "getQuickLoginLinkFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get quick login link",
    ),
    "getStatisticsFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get statistics",
    ),
    "getSubscribeInfoFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get subscription information",
    ),
    "getTicketDetailFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get ticket details",
    ),
    "getTicketListFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get ticket list",
    ),
    "getUnpaidOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get unpaid orders",
    ),
    "getUnpaidOrdersFailedMsg": MessageLookupByLibrary.simpleMessage(
      "Failed to get unpaid orders",
    ),
    "getUserConfigFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get user configuration",
    ),
    "getUserInfoFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to get user information, please refresh and try again",
    ),
    "global": MessageLookupByLibrary.simpleMessage("Global"),
    "go": MessageLookupByLibrary.simpleMessage("Go"),
    "goDownload": MessageLookupByLibrary.simpleMessage("Go to download"),
    "goToPay": MessageLookupByLibrary.simpleMessage("Go to pay"),
    "halfYearlyPlan": MessageLookupByLibrary.simpleMessage("Half Yearly"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Do you want to cache the changes?",
    ),
    "hasNoAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "haveCoupon": MessageLookupByLibrary.simpleMessage("Have a coupon?"),
    "hosts": MessageLookupByLibrary.simpleMessage("Hosts"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Add Hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("Hotkey conflict"),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Hotkey Management",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Use keyboard to control applications",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Hours"),
    "icon": MessageLookupByLibrary.simpleMessage("Icon"),
    "iconConfiguration": MessageLookupByLibrary.simpleMessage(
      "Icon configuration",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Icon style"),
    "import": MessageLookupByLibrary.simpleMessage("Import"),
    "importFailed": MessageLookupByLibrary.simpleMessage(
      "Subscription import failed",
    ),
    "importFile": MessageLookupByLibrary.simpleMessage("Import from file"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "importSuccess": MessageLookupByLibrary.simpleMessage(
      "Subscription import success",
    ),
    "importUrl": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "importantReminder": MessageLookupByLibrary.simpleMessage(
      "Important Reminder",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Long term effective"),
    "init": MessageLookupByLibrary.simpleMessage("Init"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Please enter the correct hotkey",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Intelligent selection",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Internet"),
    "interval": MessageLookupByLibrary.simpleMessage("Interval"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Intranet IP"),
    "invalidConfigDataStructure": MessageLookupByLibrary.simpleMessage(
      "Invalid configuration data structure",
    ),
    "invalidCoupon": MessageLookupByLibrary.simpleMessage("Invalid coupon"),
    "invalidResponseDataFormat": MessageLookupByLibrary.simpleMessage(
      "Invalid response data format",
    ),
    "inviteCodeGenerateSuccess": MessageLookupByLibrary.simpleMessage(
      "Invite code generated successfully",
    ),
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage(
      "Enter invite code (optional)",
    ),
    "inviteCodeManagement": MessageLookupByLibrary.simpleMessage(
      "Invite Code Management",
    ),
    "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter invite code",
    ),
    "inviteFriends": MessageLookupByLibrary.simpleMessage("Invite Friends"),
    "inviteFriends2": MessageLookupByLibrary.simpleMessage("Invite Friends"),
    "inviteLink": MessageLookupByLibrary.simpleMessage("Invite Link"),
    "inviteLinkCopied": MessageLookupByLibrary.simpleMessage(
      "Your invite link has been copied, go invite your friends!",
    ),
    "inviteLinkCopiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "Invite link copied to clipboard",
    ),
    "invitedUsers": MessageLookupByLibrary.simpleMessage("Invited Users"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("Ipcidr"),
    "ipv6": MessageLookupByLibrary.simpleMessage("IPv6"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "When turned on it will be able to receive IPv6 traffic",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Allow IPv6 inbound",
    ),
    "ja": MessageLookupByLibrary.simpleMessage("Japanese"),
    "joinGroup": MessageLookupByLibrary.simpleMessage("Join"),
    "just": MessageLookupByLibrary.simpleMessage("Just"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Tcp keep alive interval",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Key"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Last Updated"),
    "layout": MessageLookupByLibrary.simpleMessage("Layout"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "list": MessageLookupByLibrary.simpleMessage("List"),
    "listen": MessageLookupByLibrary.simpleMessage("Listen"),
    "loadConfigFailed": m11,
    "loadFailed": MessageLookupByLibrary.simpleMessage("Load Failed"),
    "loadFailedMsg": MessageLookupByLibrary.simpleMessage("Load failed"),
    "loadingConfig": MessageLookupByLibrary.simpleMessage(
      "Loading configuration...",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to local",
    ),
    "localRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Recovery data from file",
    ),
    "logLevel": MessageLookupByLibrary.simpleMessage("LogLevel"),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Disabling will hide the log entry",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginError": MessageLookupByLibrary.simpleMessage("Login failed"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("Login failed"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("Login success"),
    "loginToViewPersonalInfo": MessageLookupByLibrary.simpleMessage(
      "Login to view personal information",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutButton": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutUser": MessageLookupByLibrary.simpleMessage("Logout"),
    "logs": MessageLookupByLibrary.simpleMessage("Logs"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Log capture records"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Logs test"),
    "loopback": MessageLookupByLibrary.simpleMessage("Loopback unlock tool"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Used for UWP loopback unlocking",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Loose"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Memory info"),
    "messageTest": MessageLookupByLibrary.simpleMessage("Message test"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage(
      "This is a message.",
    ),
    "min": MessageLookupByLibrary.simpleMessage("Min"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("Minimize on exit"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the default system exit event",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("Minutes"),
    "mixedPort": MessageLookupByLibrary.simpleMessage("Mixed Port"),
    "mmdb": MessageLookupByLibrary.simpleMessage("MMDB"),
    "mode": MessageLookupByLibrary.simpleMessage("Mode"),
    "modifyPassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Monochrome"),
    "monthlyPlan": MessageLookupByLibrary.simpleMessage("Monthly"),
    "months": MessageLookupByLibrary.simpleMessage("Months"),
    "more": MessageLookupByLibrary.simpleMessage("More"),
    "moreActions": MessageLookupByLibrary.simpleMessage("More Actions"),
    "mostPopular": MessageLookupByLibrary.simpleMessage("Most Popular"),
    "myAccount": MessageLookupByLibrary.simpleMessage("My account"),
    "myCenter": MessageLookupByLibrary.simpleMessage("My"),
    "myCommission": MessageLookupByLibrary.simpleMessage("My Commission"),
    "myInvite": MessageLookupByLibrary.simpleMessage("My Invite"),
    "myOrders": MessageLookupByLibrary.simpleMessage("My Orders"),
    "myOrders2": MessageLookupByLibrary.simpleMessage("My Orders"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "nameSort": MessageLookupByLibrary.simpleMessage("Sort by name"),
    "nameserver": MessageLookupByLibrary.simpleMessage("Nameserver"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "For resolving domain",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Nameserver policy",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Specify the corresponding nameserver policy",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Network"),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Modify network-related settings",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Network detection",
    ),
    "networkSection": MessageLookupByLibrary.simpleMessage("Network"),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Network speed"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Neutral"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "newPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Please enter new password",
    ),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("New Password"),
    "newPasswordLengthRequirement": MessageLookupByLibrary.simpleMessage(
      "New password length requires 8-20 characters",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noData": MessageLookupByLibrary.simpleMessage("No data"),
    "noDistributionRecord": MessageLookupByLibrary.simpleMessage(
      "No distribution records",
    ),
    "noDistributionRecordDescription": MessageLookupByLibrary.simpleMessage(
      "You haven\'t received any commission distributions yet",
    ),
    "noHotKey": MessageLookupByLibrary.simpleMessage("No HotKey"),
    "noIcon": MessageLookupByLibrary.simpleMessage("None"),
    "noInfo": MessageLookupByLibrary.simpleMessage("No info"),
    "noInviteCode": MessageLookupByLibrary.simpleMessage("No Invite Code"),
    "noMoreInfoDesc": MessageLookupByLibrary.simpleMessage("No more info"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("No network"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("No network APP"),
    "noNotices": MessageLookupByLibrary.simpleMessage("No notices"),
    "noOrders": MessageLookupByLibrary.simpleMessage("No Orders"),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage(
      "You don\'t have any orders yet",
    ),
    "noPaymentMethods": MessageLookupByLibrary.simpleMessage(
      "No payment methods available",
    ),
    "noPlans": MessageLookupByLibrary.simpleMessage("No Plans Available"),
    "noProxy": MessageLookupByLibrary.simpleMessage("No proxy"),
    "noProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Please create a profile or add a valid profile",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("No resolve IP"),
    "noSubscribeUrl": MessageLookupByLibrary.simpleMessage("No subscribe url"),
    "noTickets": MessageLookupByLibrary.simpleMessage("No tickets"),
    "noTicketsYet": MessageLookupByLibrary.simpleMessage(
      "You don\'t have any tickets yet",
    ),
    "nodes": MessageLookupByLibrary.simpleMessage("Nodes"),
    "none": MessageLookupByLibrary.simpleMessage("none"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "The current proxy group cannot be selected.",
    ),
    "notices": MessageLookupByLibrary.simpleMessage("Notices"),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "No profile, Please add a profile",
    ),
    "nullTip": m12,
    "numberTip": m13,
    "officialWebsite": MessageLookupByLibrary.simpleMessage("Official website"),
    "oneClickBlock": MessageLookupByLibrary.simpleMessage("One-click Block"),
    "oneColumn": MessageLookupByLibrary.simpleMessage("One column"),
    "onetimePlan": MessageLookupByLibrary.simpleMessage("One Time"),
    "onlineDevices": MessageLookupByLibrary.simpleMessage("Online devices"),
    "onlineStatus": m14,
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Icon"),
    "onlyOtherApps": MessageLookupByLibrary.simpleMessage(
      "Only third-party apps",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Only statistics proxy",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "When turned on, only statistics proxy traffic",
    ),
    "openLinkFailed": m15,
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "orderAmount": MessageLookupByLibrary.simpleMessage("Amount"),
    "orderCancelledDueToTimeout": MessageLookupByLibrary.simpleMessage(
      "Order was cancelled due to payment timeout.",
    ),
    "orderCompletedTip": MessageLookupByLibrary.simpleMessage(
      "Order has been paid and activated.",
    ),
    "orderCount": m16,
    "orderCreatedAt": MessageLookupByLibrary.simpleMessage("Created At"),
    "orderDetails": MessageLookupByLibrary.simpleMessage("Order Details"),
    "orderDiscount": MessageLookupByLibrary.simpleMessage("Discount"),
    "orderInfo": MessageLookupByLibrary.simpleMessage("Order Information"),
    "orderListTitle": MessageLookupByLibrary.simpleMessage("My Orders"),
    "orderNumber": MessageLookupByLibrary.simpleMessage("Order No"),
    "orderStatusCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "orderStatusCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "orderStatusDeducted": MessageLookupByLibrary.simpleMessage("Deducted"),
    "orderStatusProcessing": MessageLookupByLibrary.simpleMessage("Processing"),
    "orderStatusUnpaid": MessageLookupByLibrary.simpleMessage("Unpaid"),
    "orderTotal": MessageLookupByLibrary.simpleMessage("Order Total"),
    "orderType": MessageLookupByLibrary.simpleMessage("Order Type"),
    "orderTypeNew": MessageLookupByLibrary.simpleMessage("New"),
    "orderTypeRenew": MessageLookupByLibrary.simpleMessage("Renew"),
    "orderTypeResetTraffic": MessageLookupByLibrary.simpleMessage(
      "Reset Traffic",
    ),
    "orderTypeUpgrade": MessageLookupByLibrary.simpleMessage("Upgrade"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "otherContributors": MessageLookupByLibrary.simpleMessage(
      "Other contributors",
    ),
    "otherSettings": MessageLookupByLibrary.simpleMessage("Other Settings"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Outbound mode"),
    "override": MessageLookupByLibrary.simpleMessage("Override"),
    "overrideDesc": MessageLookupByLibrary.simpleMessage(
      "Override Proxy related config",
    ),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Override Dns"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Turning it on will override the DNS options in the profile",
    ),
    "overrideInvalidTip": MessageLookupByLibrary.simpleMessage(
      "Does not take effect in script mode",
    ),
    "overrideOriginRules": MessageLookupByLibrary.simpleMessage(
      "Override the original rule",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Palette"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordChangeSuccess": MessageLookupByLibrary.simpleMessage(
      "Password changed successfully",
    ),
    "passwordChangeSuccessMsg": MessageLookupByLibrary.simpleMessage(
      "Password changed successfully",
    ),
    "passwordHint": MessageLookupByLibrary.simpleMessage(
      "Please enter password",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password length cannot be less than 8",
    ),
    "paste": MessageLookupByLibrary.simpleMessage("Paste"),
    "paymentFailed": m17,
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment Method"),
    "paypalAccount": MessageLookupByLibrary.simpleMessage("Paypal Account"),
    "pendingCommission": MessageLookupByLibrary.simpleMessage(
      "Pending Commission",
    ),
    "permanentSubscription": MessageLookupByLibrary.simpleMessage(
      "Permanent Subscription",
    ),
    "personalizationSection": MessageLookupByLibrary.simpleMessage(
      "Personalization",
    ),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Please bind WebDAV",
    ),
    "pleaseConfirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Please confirm new password again",
    ),
    "pleaseConfirmNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Please confirm new password again",
    ),
    "pleaseEnterAlipayAccount": MessageLookupByLibrary.simpleMessage(
      "Please enter Alipay account",
    ),
    "pleaseEnterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter current password",
    ),
    "pleaseEnterCurrentPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Please enter current password",
    ),
    "pleaseEnterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter new password",
    ),
    "pleaseEnterNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Please enter new password",
    ),
    "pleaseEnterPaypalAccount": MessageLookupByLibrary.simpleMessage(
      "Please enter Paypal account",
    ),
    "pleaseEnterReplyContent": MessageLookupByLibrary.simpleMessage(
      "Please enter reply content",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Please enter a script name",
    ),
    "pleaseEnterTransferAmount": MessageLookupByLibrary.simpleMessage(
      "Please enter amount to transfer",
    ),
    "pleaseEnterTransferAmountHint": MessageLookupByLibrary.simpleMessage(
      "Please enter transfer amount",
    ),
    "pleaseEnterUsdtWalletAddress": MessageLookupByLibrary.simpleMessage(
      "Please enter USDT wallet address",
    ),
    "pleaseEnterValidAmount": MessageLookupByLibrary.simpleMessage(
      "Please enter valid amount",
    ),
    "pleaseEnterWithdrawalAccount": MessageLookupByLibrary.simpleMessage(
      "Please enter withdrawal account",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter the admin password",
    ),
    "pleaseLogin": MessageLookupByLibrary.simpleMessage("Please login"),
    "pleaseLogin2": MessageLookupByLibrary.simpleMessage("Please login first"),
    "pleaseSelectWithdrawalMethod": MessageLookupByLibrary.simpleMessage(
      "Please select withdrawal method",
    ),
    "pleaseUploadFile": MessageLookupByLibrary.simpleMessage(
      "Please upload file",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Please upload a valid QR code",
    ),
    "popupNotification": MessageLookupByLibrary.simpleMessage("Popup"),
    "port": MessageLookupByLibrary.simpleMessage("Port"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Please enter a different port",
    ),
    "portTip": m18,
    "preferH3": MessageLookupByLibrary.simpleMessage("PreferH3"),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Prioritize the use of DOH\'s http/3",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Please press the keyboard.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Preview"),
    "pricePerMonth": m19,
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privacyPolicyInDevelopment": MessageLookupByLibrary.simpleMessage(
      "Privacy policy page in development",
    ),
    "productInfo": MessageLookupByLibrary.simpleMessage("Product Information"),
    "productName": MessageLookupByLibrary.simpleMessage("Product Name"),
    "productTraffic": MessageLookupByLibrary.simpleMessage("Product Traffic"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Please input a valid interval time format",
        ),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Please enter the auto update interval time",
        ),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "The profile has been modified. Do you want to disable auto update?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile name",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "profile parse error",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input a valid profile URL",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile URL",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiles"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Profiles sort"),
    "project": MessageLookupByLibrary.simpleMessage("Project"),
    "providers": MessageLookupByLibrary.simpleMessage("Providers"),
    "proxies": MessageLookupByLibrary.simpleMessage("Proxies"),
    "proxiesSetting": MessageLookupByLibrary.simpleMessage("Proxies setting"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Proxy group"),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("Proxy nameserver"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Domain for resolving proxy nodes",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("ProxyPort"),
    "proxyPortDesc": MessageLookupByLibrary.simpleMessage(
      "Set the Clash listening port",
    ),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Proxy providers"),
    "publishedAt": m20,
    "purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
    "purchasePlan": MessageLookupByLibrary.simpleMessage("Purchase Plan"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Pure black mode"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR code"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Scan QR code to obtain profile",
    ),
    "quarterlyPlan": MessageLookupByLibrary.simpleMessage("Quarterly"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Rainbow"),
    "recovery": MessageLookupByLibrary.simpleMessage("Recovery"),
    "recoveryAll": MessageLookupByLibrary.simpleMessage("Recovery all data"),
    "recoveryProfiles": MessageLookupByLibrary.simpleMessage(
      "Only recovery profiles",
    ),
    "recoveryStrategy": MessageLookupByLibrary.simpleMessage(
      "Recovery strategy",
    ),
    "recoveryStrategy_compatible": MessageLookupByLibrary.simpleMessage(
      "Compatible",
    ),
    "recoveryStrategy_override": MessageLookupByLibrary.simpleMessage(
      "Override",
    ),
    "recoverySuccess": MessageLookupByLibrary.simpleMessage("Recovery success"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir Port"),
    "redo": MessageLookupByLibrary.simpleMessage("redo"),
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "regExp": MessageLookupByLibrary.simpleMessage("RegExp"),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registerButton": MessageLookupByLibrary.simpleMessage("Register"),
    "registerError": MessageLookupByLibrary.simpleMessage(
      "Registration failed",
    ),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Registration failed",
    ),
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "Registration successful",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Register Account"),
    "registeredUsersCount": MessageLookupByLibrary.simpleMessage(
      "Registered Users Count",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Remote"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to WebDAV",
    ),
    "remoteRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Recovery data from WebDAV",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "rename": MessageLookupByLibrary.simpleMessage("Rename"),
    "reply": MessageLookupByLibrary.simpleMessage("Reply"),
    "replyTicketFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to reply to ticket",
    ),
    "requests": MessageLookupByLibrary.simpleMessage("Requests"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "View recently request records",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetInfo": m21,
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "resetPasswordButton": MessageLookupByLibrary.simpleMessage(
      "Confirm Reset",
    ),
    "resetPasswordError": MessageLookupByLibrary.simpleMessage("Reset failed"),
    "resetPasswordFailed": MessageLookupByLibrary.simpleMessage(
      "Reset password failed",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Reset email sent successfully",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage("Make sure to reset"),
    "resetTraffic": MessageLookupByLibrary.simpleMessage("Reset Traffic"),
    "resources": MessageLookupByLibrary.simpleMessage("Resources"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "External resource related info",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Respect rules"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS connection following rules, need to configure proxy-server-nameserver",
    ),
    "responseFormatError": MessageLookupByLibrary.simpleMessage(
      "Response format error",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "retryBtnText": MessageLookupByLibrary.simpleMessage("Retry"),
    "retryButton": MessageLookupByLibrary.simpleMessage("Retry"),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Route address"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Config listen route address",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Route mode"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Bypass private route address",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("Use config"),
    "ru": MessageLookupByLibrary.simpleMessage("Russian"),
    "rule": MessageLookupByLibrary.simpleMessage("Rule"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Rule name"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Rule providers"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Rule target"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Do you want to save the changes?",
    ),
    "saveTip": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to save?",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Script"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "seconds": MessageLookupByLibrary.simpleMessage("Seconds"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
    "selectNode": MessageLookupByLibrary.simpleMessage("Select Node"),
    "selectPaymentMethod": MessageLookupByLibrary.simpleMessage(
      "Select Payment Method",
    ),
    "selectPlan": MessageLookupByLibrary.simpleMessage("Select"),
    "selected": MessageLookupByLibrary.simpleMessage("Selected"),
    "selectedCountTitle": m22,
    "send": MessageLookupByLibrary.simpleMessage("Send"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Send Code"),
    "sendCodeError": MessageLookupByLibrary.simpleMessage("Send code failed"),
    "sendCodeSuccess": MessageLookupByLibrary.simpleMessage(
      "Send code success",
    ),
    "sendVerificationCodeFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to send verification code",
    ),
    "serverError": m23,
    "setDirectConnection": MessageLookupByLibrary.simpleMessage(
      "Set Direct Connection",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsFailed": MessageLookupByLibrary.simpleMessage("Settings failed"),
    "show": MessageLookupByLibrary.simpleMessage("Show"),
    "shrink": MessageLookupByLibrary.simpleMessage("Shrink"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("SilentLaunch"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Start in the background",
    ),
    "size": MessageLookupByLibrary.simpleMessage("Size"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socks Port"),
    "sort": MessageLookupByLibrary.simpleMessage("Sort"),
    "source": MessageLookupByLibrary.simpleMessage("Source"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("Source IP"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Stack mode"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "start": MessageLookupByLibrary.simpleMessage("Start"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Starting VPN..."),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "System DNS will be used when turned off",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Stop"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Stopping VPN..."),
    "style": MessageLookupByLibrary.simpleMessage("Style"),
    "subRule": MessageLookupByLibrary.simpleMessage("Sub rule"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "submitBtnText": MessageLookupByLibrary.simpleMessage("Submit"),
    "subscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
    "sync": MessageLookupByLibrary.simpleMessage("Sync"),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "systemApp": MessageLookupByLibrary.simpleMessage("System APP"),
    "systemFont": MessageLookupByLibrary.simpleMessage("System font"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Attach HTTP proxy to VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Tab"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Tab animation"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Effective only in mobile view",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP concurrent"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Enabling it will allow TCP concurrency",
    ),
    "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
    "telegramGroup": MessageLookupByLibrary.simpleMessage("Telegram Group"),
    "testUrl": MessageLookupByLibrary.simpleMessage("Test url"),
    "textScale": MessageLookupByLibrary.simpleMessage("Text Scaling"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Theme color"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Set dark mode,adjust the color",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Theme mode"),
    "threeColumns": MessageLookupByLibrary.simpleMessage("Three columns"),
    "threeYearlyPlan": MessageLookupByLibrary.simpleMessage("3 Years"),
    "ticketCloseFailed": m24,
    "ticketClosedSuccess": MessageLookupByLibrary.simpleMessage(
      "Ticket closed successfully",
    ),
    "ticketDetails": MessageLookupByLibrary.simpleMessage("Ticket Details"),
    "ticketLevel": MessageLookupByLibrary.simpleMessage("Priority"),
    "ticketLevelHigh": MessageLookupByLibrary.simpleMessage("High"),
    "ticketLevelLow": MessageLookupByLibrary.simpleMessage("Low"),
    "ticketLevelMedium": MessageLookupByLibrary.simpleMessage("Medium"),
    "ticketNotFound": MessageLookupByLibrary.simpleMessage("Ticket not found"),
    "ticketPriorityHigh": MessageLookupByLibrary.simpleMessage("High Priority"),
    "ticketPriorityLow": MessageLookupByLibrary.simpleMessage("Low Priority"),
    "ticketPriorityMedium": MessageLookupByLibrary.simpleMessage(
      "Medium Priority",
    ),
    "ticketPriorityUrgent": MessageLookupByLibrary.simpleMessage("Urgent"),
    "ticketStatusClosed": MessageLookupByLibrary.simpleMessage("Closed"),
    "ticketStatusOpen": MessageLookupByLibrary.simpleMessage("Processing"),
    "ticketSubject": MessageLookupByLibrary.simpleMessage("Subject"),
    "tight": MessageLookupByLibrary.simpleMessage("Tight"),
    "time": MessageLookupByLibrary.simpleMessage("Time"),
    "tip": MessageLookupByLibrary.simpleMessage("tip"),
    "toggle": MessageLookupByLibrary.simpleMessage("Toggle"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("TonalSpot"),
    "tools": MessageLookupByLibrary.simpleMessage("Tools"),
    "tools2": MessageLookupByLibrary.simpleMessage("Tools"),
    "toolsEntryHidden": MessageLookupByLibrary.simpleMessage(
      "Tools entry hidden",
    ),
    "toolsEntryShown": MessageLookupByLibrary.simpleMessage(
      "Tools entry shown",
    ),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "totalCommissionEarned": MessageLookupByLibrary.simpleMessage(
      "Total Commission Earned",
    ),
    "totalOrdersCount": m25,
    "totalTicketsCount": m26,
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxy Port"),
    "trafficEmailReminder": MessageLookupByLibrary.simpleMessage(
      "Traffic Email Reminder",
    ),
    "trafficEmailReminderDisabled": MessageLookupByLibrary.simpleMessage(
      "Traffic email reminder disabled",
    ),
    "trafficEmailReminderEnabled": MessageLookupByLibrary.simpleMessage(
      "Traffic email reminder enabled",
    ),
    "trafficStats": m27,
    "trafficUsage": MessageLookupByLibrary.simpleMessage("Traffic usage"),
    "transfer": MessageLookupByLibrary.simpleMessage("Transfer"),
    "transferAllAmount": MessageLookupByLibrary.simpleMessage("Transfer All"),
    "transferAmount": MessageLookupByLibrary.simpleMessage("Transfer amount"),
    "transferAmountCannotExceedCommissionBalance":
        MessageLookupByLibrary.simpleMessage(
          "Transfer amount cannot exceed commission balance",
        ),
    "transferAmountExceedsBalance": MessageLookupByLibrary.simpleMessage(
      "Transfer amount cannot exceed commission balance",
    ),
    "transferAmountValidError": MessageLookupByLibrary.simpleMessage(
      "Please enter valid amount",
    ),
    "transferCommissionToBalance": MessageLookupByLibrary.simpleMessage(
      "Transfer commission to balance",
    ),
    "transferFailedMsg": MessageLookupByLibrary.simpleMessage(
      "Transfer failed",
    ),
    "transferredBalanceOnlyForAppConsumption": m28,
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "only effective in administrator mode",
    ),
    "twoColumns": MessageLookupByLibrary.simpleMessage("Two columns"),
    "twoYearlyPlan": MessageLookupByLibrary.simpleMessage("2 Years"),
    "typePeriod": MessageLookupByLibrary.simpleMessage("Type/Period"),
    "ua": MessageLookupByLibrary.simpleMessage("UA"),
    "unableToUpdateCurrentProfileDesc": MessageLookupByLibrary.simpleMessage(
      "unable to update current profile",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("undo"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Unified delay"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Remove extra delays such as handshaking",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Unnamed"),
    "unpaidOrderTip": MessageLookupByLibrary.simpleMessage(
      "You have unpaid orders",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updateSuccess": MessageLookupByLibrary.simpleMessage(
      "Subscription update success",
    ),
    "updateUserInfoFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to update user information, please try again later",
    ),
    "upload": MessageLookupByLibrary.simpleMessage("Upload"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Obtain profile through URL",
    ),
    "urlTip": m29,
    "usdtWalletAddress": MessageLookupByLibrary.simpleMessage(
      "USDT Wallet Address",
    ),
    "useHosts": MessageLookupByLibrary.simpleMessage("Use hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("Use system hosts"),
    "userAgreement": MessageLookupByLibrary.simpleMessage("User Agreement"),
    "userAgreementInDevelopment": MessageLookupByLibrary.simpleMessage(
      "User agreement page in development",
    ),
    "userCenter": MessageLookupByLibrary.simpleMessage("User center"),
    "userInfo": MessageLookupByLibrary.simpleMessage("User info"),
    "userStats": MessageLookupByLibrary.simpleMessage("User stats"),
    "value": MessageLookupByLibrary.simpleMessage("Value"),
    "verify": MessageLookupByLibrary.simpleMessage("Verify"),
    "verifyCouponFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to verify coupon",
    ),
    "verifyingCoupon": MessageLookupByLibrary.simpleMessage(
      "Verifying coupon...",
    ),
    "versionInfo": MessageLookupByLibrary.simpleMessage("Version Info"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Vibrant"),
    "view": MessageLookupByLibrary.simpleMessage("View"),
    "viewDetails": MessageLookupByLibrary.simpleMessage("View Details"),
    "viewTicketDetails": MessageLookupByLibrary.simpleMessage("View Details"),
    "vpn": MessageLookupByLibrary.simpleMessage("VPN"),
    "vpnDesc": MessageLookupByLibrary.simpleMessage(
      "Modify VPN related settings",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Auto routes all system traffic through VpnService",
    ),
    "vpnSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Attach HTTP proxy to VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Changes take effect after restarting the VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "WebDAV configuration",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("Whitelist mode"),
    "withdrawApplyFailed": m30,
    "withdrawApplySuccess": MessageLookupByLibrary.simpleMessage(
      "Withdrawal application successful",
    ),
    "withdrawalAccount": MessageLookupByLibrary.simpleMessage(
      "Withdrawal Account",
    ),
    "withdrawalAccountLabel": MessageLookupByLibrary.simpleMessage(
      "Withdrawal Account",
    ),
    "withdrawalApplication": MessageLookupByLibrary.simpleMessage(
      "Apply for Withdrawal",
    ),
    "withdrawalApplicationFailed": MessageLookupByLibrary.simpleMessage(
      "Withdrawal application failed",
    ),
    "withdrawalApplicationSubmitted": MessageLookupByLibrary.simpleMessage(
      "Withdrawal application submitted, please wait for review",
    ),
    "withdrawalFunctionClosed": MessageLookupByLibrary.simpleMessage(
      "Withdrawal function is closed",
    ),
    "withdrawalFunctionDisabled": MessageLookupByLibrary.simpleMessage(
      "Withdrawal function disabled",
    ),
    "withdrawalInstructions": MessageLookupByLibrary.simpleMessage(
      "Withdrawal Instructions",
    ),
    "withdrawalInstructionsText": MessageLookupByLibrary.simpleMessage(
      "• Withdrawal applications require manual review after submission\n• Funds will be transferred to your account after approval\n• Please ensure withdrawal account information is accurate",
    ),
    "withdrawalMethod": MessageLookupByLibrary.simpleMessage(
      "Withdrawal Method",
    ),
    "withdrawalMethodLabel": MessageLookupByLibrary.simpleMessage(
      "Withdrawal Method",
    ),
    "withdrawalRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Withdrawal request failed",
    ),
    "withdrawalRequestSubmitted": MessageLookupByLibrary.simpleMessage(
      "Withdrawal request submitted, awaiting review",
    ),
    "withdrawalSystemTemporarilyClosed": MessageLookupByLibrary.simpleMessage(
      "The system has temporarily closed the withdrawal function",
    ),
    "yearlyPlan": MessageLookupByLibrary.simpleMessage("Yearly"),
    "years": MessageLookupByLibrary.simpleMessage("Years"),
    "zeroCommissionBalanceTransfer": MessageLookupByLibrary.simpleMessage(
      "Commission balance is zero, cannot transfer",
    ),
    "zeroCommissionBalanceWithdraw": MessageLookupByLibrary.simpleMessage(
      "Commission balance is zero, cannot withdraw",
    ),
    "zh_CN": MessageLookupByLibrary.simpleMessage("Simplified Chinese"),
    "zoom": MessageLookupByLibrary.simpleMessage("Zoom"),
  };
}
