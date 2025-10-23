// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Official website`
  String get officialWebsite {
    return Intl.message(
      'Official website',
      name: 'officialWebsite',
      desc: '',
      args: [],
    );
  }

  /// `Please login`
  String get pleaseLogin {
    return Intl.message(
      'Please login',
      name: 'pleaseLogin',
      desc: '',
      args: [],
    );
  }

  /// `User center`
  String get userCenter {
    return Intl.message('User center', name: 'userCenter', desc: '', args: []);
  }

  /// `My`
  String get myCenter {
    return Intl.message('My', name: 'myCenter', desc: '', args: []);
  }

  /// `User info`
  String get userInfo {
    return Intl.message('User info', name: 'userInfo', desc: '', args: []);
  }

  /// `User stats`
  String get userStats {
    return Intl.message('User stats', name: 'userStats', desc: '', args: []);
  }

  /// `Balance`
  String get balance {
    return Intl.message('Balance', name: 'balance', desc: '', args: []);
  }

  /// `Expire time`
  String get expireTime {
    return Intl.message('Expire time', name: 'expireTime', desc: '', args: []);
  }

  /// `Online devices`
  String get onlineDevices {
    return Intl.message(
      'Online devices',
      name: 'onlineDevices',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get emailHint {
    return Intl.message(
      'Please enter email',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get passwordHint {
    return Intl.message(
      'Please enter password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password`
  String get newPasswordHint {
    return Intl.message(
      'Please enter new password',
      name: 'newPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm password`
  String get confirmPasswordHint {
    return Intl.message(
      'Please confirm password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password length cannot be less than 8`
  String get passwordTooShort {
    return Intl.message(
      'Password length cannot be less than 8',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Please enter verification code`
  String get emailCodeHint {
    return Intl.message(
      'Please enter verification code',
      name: 'emailCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message('Send Code', name: 'sendCode', desc: '', args: []);
  }

  /// `Enter invite code (optional)`
  String get inviteCodeHint {
    return Intl.message(
      'Enter invite code (optional)',
      name: 'inviteCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Login success`
  String get loginSuccess {
    return Intl.message(
      'Login success',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get loginError {
    return Intl.message('Login failed', name: 'loginError', desc: '', args: []);
  }

  /// `Register Account`
  String get registerTitle {
    return Intl.message(
      'Register Account',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message('Register', name: 'registerButton', desc: '', args: []);
  }

  /// `Registration successful`
  String get registerSuccess {
    return Intl.message(
      'Registration successful',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get registerError {
    return Intl.message(
      'Registration failed',
      name: 'registerError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Reset`
  String get resetPasswordButton {
    return Intl.message(
      'Confirm Reset',
      name: 'resetPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Reset email sent successfully`
  String get resetPasswordSuccess {
    return Intl.message(
      'Reset email sent successfully',
      name: 'resetPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Reset failed`
  String get resetPasswordError {
    return Intl.message(
      'Reset failed',
      name: 'resetPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Send code success`
  String get sendCodeSuccess {
    return Intl.message(
      'Send code success',
      name: 'sendCodeSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Send code failed`
  String get sendCodeError {
    return Intl.message(
      'Send code failed',
      name: 'sendCodeError',
      desc: '',
      args: [],
    );
  }

  /// `Email suffix is not allowed`
  String get emailSuffixError {
    return Intl.message(
      'Email suffix is not allowed',
      name: 'emailSuffixError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter invite code`
  String get inviteCodeRequired {
    return Intl.message(
      'Please enter invite code',
      name: 'inviteCodeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Used {used} / Total {total} `
  String trafficStats(Object used, Object total) {
    return Intl.message(
      'Used $used / Total $total ',
      name: 'trafficStats',
      desc: '',
      args: [used, total],
    );
  }

  /// `Online devices {online}/{limit}`
  String onlineStatus(Object online, Object limit) {
    return Intl.message(
      'Online devices $online/$limit',
      name: 'onlineStatus',
      desc: '',
      args: [online, limit],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message('Subscribe', name: 'subscribe', desc: '', args: []);
  }

  /// `Purchase`
  String get purchase {
    return Intl.message('Purchase', name: 'purchase', desc: '', args: []);
  }

  /// `Expires on {date}, {days} days left.`
  String expirationInfo(Object date, Object days) {
    return Intl.message(
      'Expires on $date, $days days left.',
      name: 'expirationInfo',
      desc: '',
      args: [date, days],
    );
  }

  /// `Traffic will reset in {resetDay} days`
  String resetInfo(Object resetDay) {
    return Intl.message(
      'Traffic will reset in $resetDay days',
      name: 'resetInfo',
      desc: '',
      args: [resetDay],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `No Plans Available`
  String get noPlans {
    return Intl.message(
      'No Plans Available',
      name: 'noPlans',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthlyPlan {
    return Intl.message('Monthly', name: 'monthlyPlan', desc: '', args: []);
  }

  /// `Quarterly`
  String get quarterlyPlan {
    return Intl.message('Quarterly', name: 'quarterlyPlan', desc: '', args: []);
  }

  /// `Half Yearly`
  String get halfYearlyPlan {
    return Intl.message(
      'Half Yearly',
      name: 'halfYearlyPlan',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearlyPlan {
    return Intl.message('Yearly', name: 'yearlyPlan', desc: '', args: []);
  }

  /// `Purchase Plan`
  String get purchasePlan {
    return Intl.message(
      'Purchase Plan',
      name: 'purchasePlan',
      desc: '',
      args: [],
    );
  }

  /// `2 Years`
  String get twoYearlyPlan {
    return Intl.message('2 Years', name: 'twoYearlyPlan', desc: '', args: []);
  }

  /// `3 Years`
  String get threeYearlyPlan {
    return Intl.message('3 Years', name: 'threeYearlyPlan', desc: '', args: []);
  }

  /// `One Time`
  String get onetimePlan {
    return Intl.message('One Time', name: 'onetimePlan', desc: '', args: []);
  }

  /// `Reset Traffic`
  String get resetTraffic {
    return Intl.message(
      'Reset Traffic',
      name: 'resetTraffic',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Coupon Code`
  String get couponCode {
    return Intl.message('Coupon Code', name: 'couponCode', desc: '', args: []);
  }

  /// `Enter coupon code (optional)`
  String get couponCodeHint {
    return Intl.message(
      'Enter coupon code (optional)',
      name: 'couponCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Discounted Price`
  String get discountedPrice {
    return Intl.message(
      'Discounted Price',
      name: 'discountedPrice',
      desc: '',
      args: [],
    );
  }

  /// `Have a coupon?`
  String get haveCoupon {
    return Intl.message(
      'Have a coupon?',
      name: 'haveCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Coupon code valid`
  String get couponValid {
    return Intl.message(
      'Coupon code valid',
      name: 'couponValid',
      desc: '',
      args: [],
    );
  }

  /// `Create Order`
  String get createOrder {
    return Intl.message(
      'Create Order',
      name: 'createOrder',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message('My Orders', name: 'myOrders', desc: '', args: []);
  }

  /// `No Orders`
  String get noOrders {
    return Intl.message('No Orders', name: 'noOrders', desc: '', args: []);
  }

  /// `Created At`
  String get orderCreatedAt {
    return Intl.message(
      'Created At',
      name: 'orderCreatedAt',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get orderAmount {
    return Intl.message('Amount', name: 'orderAmount', desc: '', args: []);
  }

  /// `Discount`
  String get orderDiscount {
    return Intl.message('Discount', name: 'orderDiscount', desc: '', args: []);
  }

  /// `Order Total`
  String get orderTotal {
    return Intl.message('Order Total', name: 'orderTotal', desc: '', args: []);
  }

  /// `Click to Pay`
  String get clickToPay {
    return Intl.message('Click to Pay', name: 'clickToPay', desc: '', args: []);
  }

  /// `Payment failed: {error}`
  String paymentFailed(String error) {
    return Intl.message(
      'Payment failed: $error',
      name: 'paymentFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Unpaid`
  String get orderStatusUnpaid {
    return Intl.message(
      'Unpaid',
      name: 'orderStatusUnpaid',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get orderStatusProcessing {
    return Intl.message(
      'Processing',
      name: 'orderStatusProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get orderStatusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'orderStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get orderStatusCompleted {
    return Intl.message(
      'Completed',
      name: 'orderStatusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Order has been paid and activated.`
  String get orderCompletedTip {
    return Intl.message(
      'Order has been paid and activated.',
      name: 'orderCompletedTip',
      desc: '',
      args: [],
    );
  }

  /// `Deducted`
  String get orderStatusDeducted {
    return Intl.message(
      'Deducted',
      name: 'orderStatusDeducted',
      desc: '',
      args: [],
    );
  }

  /// `More Actions`
  String get moreActions {
    return Intl.message(
      'More Actions',
      name: 'moreActions',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Method`
  String get selectPaymentMethod {
    return Intl.message(
      'Select Payment Method',
      name: 'selectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Payment`
  String get confirmPayment {
    return Intl.message(
      'Confirm Payment',
      name: 'confirmPayment',
      desc: '',
      args: [],
    );
  }

  /// `No subscribe url`
  String get noSubscribeUrl {
    return Intl.message(
      'No subscribe url',
      name: 'noSubscribeUrl',
      desc: '',
      args: [],
    );
  }

  /// `Subscription import success`
  String get importSuccess {
    return Intl.message(
      'Subscription import success',
      name: 'importSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Subscription import failed`
  String get importFailed {
    return Intl.message(
      'Subscription import failed',
      name: 'importFailed',
      desc: '',
      args: [],
    );
  }

  /// `Subscription update success`
  String get updateSuccess {
    return Intl.message(
      'Subscription update success',
      name: 'updateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `My account`
  String get myAccount {
    return Intl.message('My account', name: 'myAccount', desc: '', args: []);
  }

  /// `Expired`
  String get expired {
    return Intl.message('Expired', name: 'expired', desc: '', args: []);
  }

  /// `Permanent Subscription`
  String get permanentSubscription {
    return Intl.message(
      'Permanent Subscription',
      name: 'permanentSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Notices`
  String get notices {
    return Intl.message('Notices', name: 'notices', desc: '', args: []);
  }

  /// `No notices`
  String get noNotices {
    return Intl.message('No notices', name: 'noNotices', desc: '', args: []);
  }

  /// `Published on {date}`
  String publishedAt(Object date) {
    return Intl.message(
      'Published on $date',
      name: 'publishedAt',
      desc: '',
      args: [date],
    );
  }

  /// `You have unpaid orders`
  String get unpaidOrderTip {
    return Intl.message(
      'You have unpaid orders',
      name: 'unpaidOrderTip',
      desc: '',
      args: [],
    );
  }

  /// `Go to pay`
  String get goToPay {
    return Intl.message('Go to pay', name: 'goToPay', desc: '', args: []);
  }

  /// `If you have already paid, canceling the order may cause the payment to fail. Are you sure you want to cancel the order?`
  String get cancelOrderConfirmTip {
    return Intl.message(
      'If you have already paid, canceling the order may cause the payment to fail. Are you sure you want to cancel the order?',
      name: 'cancelOrderConfirmTip',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load configuration: {error}`
  String loadConfigFailed(Object error) {
    return Intl.message(
      'Failed to load configuration: $error',
      name: 'loadConfigFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Server error: {code}`
  String serverError(Object code) {
    return Intl.message(
      'Server error: $code',
      name: 'serverError',
      desc: '',
      args: [code],
    );
  }

  /// `Failed to decrypt configuration: {error}`
  String configDecryptFailed(Object error) {
    return Intl.message(
      'Failed to decrypt configuration: $error',
      name: 'configDecryptFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Invite Friends`
  String get inviteFriends {
    return Intl.message(
      'Invite Friends',
      name: 'inviteFriends',
      desc: '',
      args: [],
    );
  }

  /// `Invited Users`
  String get invitedUsers {
    return Intl.message(
      'Invited Users',
      name: 'invitedUsers',
      desc: '',
      args: [],
    );
  }

  /// `Available Commission`
  String get availableCommission {
    return Intl.message(
      'Available Commission',
      name: 'availableCommission',
      desc: '',
      args: [],
    );
  }

  /// `Generate Code`
  String get generateInviteCode {
    return Intl.message(
      'Generate Code',
      name: 'generateInviteCode',
      desc: '',
      args: [],
    );
  }

  /// `Invite Link`
  String get inviteLink {
    return Intl.message('Invite Link', name: 'inviteLink', desc: '', args: []);
  }

  /// `Your invite link has been copied, go invite your friends!`
  String get inviteLinkCopied {
    return Intl.message(
      'Your invite link has been copied, go invite your friends!',
      name: 'inviteLinkCopied',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get ticketStatusOpen {
    return Intl.message(
      'Processing',
      name: 'ticketStatusOpen',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get ticketStatusClosed {
    return Intl.message(
      'Closed',
      name: 'ticketStatusClosed',
      desc: '',
      args: [],
    );
  }

  /// `No tickets`
  String get noTickets {
    return Intl.message('No tickets', name: 'noTickets', desc: '', args: []);
  }

  /// `Enter message`
  String get enterMessage {
    return Intl.message(
      'Enter message',
      name: 'enterMessage',
      desc: '',
      args: [],
    );
  }

  /// `Customer Support`
  String get customerSupport {
    return Intl.message(
      'Customer Support',
      name: 'customerSupport',
      desc: '',
      args: [],
    );
  }

  /// `Create Ticket`
  String get createTicket {
    return Intl.message(
      'Create Ticket',
      name: 'createTicket',
      desc: '',
      args: [],
    );
  }

  /// `Close Ticket`
  String get closeTicket {
    return Intl.message(
      'Close Ticket',
      name: 'closeTicket',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get ticketSubject {
    return Intl.message('Subject', name: 'ticketSubject', desc: '', args: []);
  }

  /// `Priority`
  String get ticketLevel {
    return Intl.message('Priority', name: 'ticketLevel', desc: '', args: []);
  }

  /// `Low`
  String get ticketLevelLow {
    return Intl.message('Low', name: 'ticketLevelLow', desc: '', args: []);
  }

  /// `Medium`
  String get ticketLevelMedium {
    return Intl.message(
      'Medium',
      name: 'ticketLevelMedium',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get ticketLevelHigh {
    return Intl.message('High', name: 'ticketLevelHigh', desc: '', args: []);
  }

  /// `Rule`
  String get rule {
    return Intl.message('Rule', name: 'rule', desc: '', args: []);
  }

  /// `Global`
  String get global {
    return Intl.message('Global', name: 'global', desc: '', args: []);
  }

  /// `Direct`
  String get direct {
    return Intl.message('Direct', name: 'direct', desc: '', args: []);
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Proxies`
  String get proxies {
    return Intl.message('Proxies', name: 'proxies', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Profiles`
  String get profiles {
    return Intl.message('Profiles', name: 'profiles', desc: '', args: []);
  }

  /// `Tools`
  String get tools {
    return Intl.message('Tools', name: 'tools', desc: '', args: []);
  }

  /// `Logs`
  String get logs {
    return Intl.message('Logs', name: 'logs', desc: '', args: []);
  }

  /// `Log capture records`
  String get logsDesc {
    return Intl.message(
      'Log capture records',
      name: 'logsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Resources`
  String get resources {
    return Intl.message('Resources', name: 'resources', desc: '', args: []);
  }

  /// `External resource related info`
  String get resourcesDesc {
    return Intl.message(
      'External resource related info',
      name: 'resourcesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Traffic usage`
  String get trafficUsage {
    return Intl.message(
      'Traffic usage',
      name: 'trafficUsage',
      desc: '',
      args: [],
    );
  }

  /// `Core info`
  String get coreInfo {
    return Intl.message('Core info', name: 'coreInfo', desc: '', args: []);
  }

  /// `Network speed`
  String get networkSpeed {
    return Intl.message(
      'Network speed',
      name: 'networkSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Outbound mode`
  String get outboundMode {
    return Intl.message(
      'Outbound mode',
      name: 'outboundMode',
      desc: '',
      args: [],
    );
  }

  /// `Network detection`
  String get networkDetection {
    return Intl.message(
      'Network detection',
      name: 'networkDetection',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message('Upload', name: 'upload', desc: '', args: []);
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
  }

  /// `No proxy`
  String get noProxy {
    return Intl.message('No proxy', name: 'noProxy', desc: '', args: []);
  }

  /// `Please create a profile or add a valid profile`
  String get noProxyDesc {
    return Intl.message(
      'Please create a profile or add a valid profile',
      name: 'noProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `No profile, Please add a profile`
  String get nullProfileDesc {
    return Intl.message(
      'No profile, Please add a profile',
      name: 'nullProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Default`
  String get defaultText {
    return Intl.message('Default', name: 'defaultText', desc: '', args: []);
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `English`
  String get en {
    return Intl.message('English', name: 'en', desc: '', args: []);
  }

  /// `Japanese`
  String get ja {
    return Intl.message('Japanese', name: 'ja', desc: '', args: []);
  }

  /// `Russian`
  String get ru {
    return Intl.message('Russian', name: 'ru', desc: '', args: []);
  }

  /// `Simplified Chinese`
  String get zh_CN {
    return Intl.message(
      'Simplified Chinese',
      name: 'zh_CN',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Set dark mode,adjust the color`
  String get themeDesc {
    return Intl.message(
      'Set dark mode,adjust the color',
      name: 'themeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Override`
  String get override {
    return Intl.message('Override', name: 'override', desc: '', args: []);
  }

  /// `Override Proxy related config`
  String get overrideDesc {
    return Intl.message(
      'Override Proxy related config',
      name: 'overrideDesc',
      desc: '',
      args: [],
    );
  }

  /// `AllowLan`
  String get allowLan {
    return Intl.message('AllowLan', name: 'allowLan', desc: '', args: []);
  }

  /// `Allow access proxy through the LAN`
  String get allowLanDesc {
    return Intl.message(
      'Allow access proxy through the LAN',
      name: 'allowLanDesc',
      desc: '',
      args: [],
    );
  }

  /// `TUN`
  String get tun {
    return Intl.message('TUN', name: 'tun', desc: '', args: []);
  }

  /// `only effective in administrator mode`
  String get tunDesc {
    return Intl.message(
      'only effective in administrator mode',
      name: 'tunDesc',
      desc: '',
      args: [],
    );
  }

  /// `Minimize on exit`
  String get minimizeOnExit {
    return Intl.message(
      'Minimize on exit',
      name: 'minimizeOnExit',
      desc: '',
      args: [],
    );
  }

  /// `Modify the default system exit event`
  String get minimizeOnExitDesc {
    return Intl.message(
      'Modify the default system exit event',
      name: 'minimizeOnExitDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto launch`
  String get autoLaunch {
    return Intl.message('Auto launch', name: 'autoLaunch', desc: '', args: []);
  }

  /// `Follow the system self startup`
  String get autoLaunchDesc {
    return Intl.message(
      'Follow the system self startup',
      name: 'autoLaunchDesc',
      desc: '',
      args: [],
    );
  }

  /// `SilentLaunch`
  String get silentLaunch {
    return Intl.message(
      'SilentLaunch',
      name: 'silentLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Start in the background`
  String get silentLaunchDesc {
    return Intl.message(
      'Start in the background',
      name: 'silentLaunchDesc',
      desc: '',
      args: [],
    );
  }

  /// `AutoRun`
  String get autoRun {
    return Intl.message('AutoRun', name: 'autoRun', desc: '', args: []);
  }

  /// `Auto run when the application is opened`
  String get autoRunDesc {
    return Intl.message(
      'Auto run when the application is opened',
      name: 'autoRunDesc',
      desc: '',
      args: [],
    );
  }

  /// `Logcat`
  String get logcat {
    return Intl.message('Logcat', name: 'logcat', desc: '', args: []);
  }

  /// `Disabling will hide the log entry`
  String get logcatDesc {
    return Intl.message(
      'Disabling will hide the log entry',
      name: 'logcatDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto check updates`
  String get autoCheckUpdate {
    return Intl.message(
      'Auto check updates',
      name: 'autoCheckUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Auto check for updates when the app starts`
  String get autoCheckUpdateDesc {
    return Intl.message(
      'Auto check for updates when the app starts',
      name: 'autoCheckUpdateDesc',
      desc: '',
      args: [],
    );
  }

  /// `AccessControl`
  String get accessControl {
    return Intl.message(
      'AccessControl',
      name: 'accessControl',
      desc: '',
      args: [],
    );
  }

  /// `Configure application access proxy`
  String get accessControlDesc {
    return Intl.message(
      'Configure application access proxy',
      name: 'accessControlDesc',
      desc: '',
      args: [],
    );
  }

  /// `Application`
  String get application {
    return Intl.message('Application', name: 'application', desc: '', args: []);
  }

  /// `Modify application related settings`
  String get applicationDesc {
    return Intl.message(
      'Modify application related settings',
      name: 'applicationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Years`
  String get years {
    return Intl.message('Years', name: 'years', desc: '', args: []);
  }

  /// `Months`
  String get months {
    return Intl.message('Months', name: 'months', desc: '', args: []);
  }

  /// `Hours`
  String get hours {
    return Intl.message('Hours', name: 'hours', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `Minutes`
  String get minutes {
    return Intl.message('Minutes', name: 'minutes', desc: '', args: []);
  }

  /// `Seconds`
  String get seconds {
    return Intl.message('Seconds', name: 'seconds', desc: '', args: []);
  }

  /// ` Ago`
  String get ago {
    return Intl.message(' Ago', name: 'ago', desc: '', args: []);
  }

  /// `Just`
  String get just {
    return Intl.message('Just', name: 'just', desc: '', args: []);
  }

  /// `QR code`
  String get qrcode {
    return Intl.message('QR code', name: 'qrcode', desc: '', args: []);
  }

  /// `Scan QR code to obtain profile`
  String get qrcodeDesc {
    return Intl.message(
      'Scan QR code to obtain profile',
      name: 'qrcodeDesc',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get url {
    return Intl.message('URL', name: 'url', desc: '', args: []);
  }

  /// `Obtain profile through URL`
  String get urlDesc {
    return Intl.message(
      'Obtain profile through URL',
      name: 'urlDesc',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get file {
    return Intl.message('File', name: 'file', desc: '', args: []);
  }

  /// `Directly upload profile`
  String get fileDesc {
    return Intl.message(
      'Directly upload profile',
      name: 'fileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Please input the profile name`
  String get profileNameNullValidationDesc {
    return Intl.message(
      'Please input the profile name',
      name: 'profileNameNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please input the profile URL`
  String get profileUrlNullValidationDesc {
    return Intl.message(
      'Please input the profile URL',
      name: 'profileUrlNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please input a valid profile URL`
  String get profileUrlInvalidValidationDesc {
    return Intl.message(
      'Please input a valid profile URL',
      name: 'profileUrlInvalidValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto update`
  String get autoUpdate {
    return Intl.message('Auto update', name: 'autoUpdate', desc: '', args: []);
  }

  /// `Auto update interval (minutes)`
  String get autoUpdateInterval {
    return Intl.message(
      'Auto update interval (minutes)',
      name: 'autoUpdateInterval',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the auto update interval time`
  String get profileAutoUpdateIntervalNullValidationDesc {
    return Intl.message(
      'Please enter the auto update interval time',
      name: 'profileAutoUpdateIntervalNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please input a valid interval time format`
  String get profileAutoUpdateIntervalInvalidValidationDesc {
    return Intl.message(
      'Please input a valid interval time format',
      name: 'profileAutoUpdateIntervalInvalidValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Theme mode`
  String get themeMode {
    return Intl.message('Theme mode', name: 'themeMode', desc: '', args: []);
  }

  /// `Theme color`
  String get themeColor {
    return Intl.message('Theme color', name: 'themeColor', desc: '', args: []);
  }

  /// `Preview`
  String get preview {
    return Intl.message('Preview', name: 'preview', desc: '', args: []);
  }

  /// `Auto`
  String get auto {
    return Intl.message('Auto', name: 'auto', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Import from URL`
  String get importFromURL {
    return Intl.message(
      'Import from URL',
      name: 'importFromURL',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Do you want to pass`
  String get doYouWantToPass {
    return Intl.message(
      'Do you want to pass',
      name: 'doYouWantToPass',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Sort by default`
  String get defaultSort {
    return Intl.message(
      'Sort by default',
      name: 'defaultSort',
      desc: '',
      args: [],
    );
  }

  /// `Sort by delay`
  String get delaySort {
    return Intl.message('Sort by delay', name: 'delaySort', desc: '', args: []);
  }

  /// `Sort by name`
  String get nameSort {
    return Intl.message('Sort by name', name: 'nameSort', desc: '', args: []);
  }

  /// `Please upload file`
  String get pleaseUploadFile {
    return Intl.message(
      'Please upload file',
      name: 'pleaseUploadFile',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a valid QR code`
  String get pleaseUploadValidQrcode {
    return Intl.message(
      'Please upload a valid QR code',
      name: 'pleaseUploadValidQrcode',
      desc: '',
      args: [],
    );
  }

  /// `Blacklist mode`
  String get blacklistMode {
    return Intl.message(
      'Blacklist mode',
      name: 'blacklistMode',
      desc: '',
      args: [],
    );
  }

  /// `Whitelist mode`
  String get whitelistMode {
    return Intl.message(
      'Whitelist mode',
      name: 'whitelistMode',
      desc: '',
      args: [],
    );
  }

  /// `Filter system app`
  String get filterSystemApp {
    return Intl.message(
      'Filter system app',
      name: 'filterSystemApp',
      desc: '',
      args: [],
    );
  }

  /// `Cancel filter system app`
  String get cancelFilterSystemApp {
    return Intl.message(
      'Cancel filter system app',
      name: 'cancelFilterSystemApp',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get selectAll {
    return Intl.message('Select all', name: 'selectAll', desc: '', args: []);
  }

  /// `Cancel select all`
  String get cancelSelectAll {
    return Intl.message(
      'Cancel select all',
      name: 'cancelSelectAll',
      desc: '',
      args: [],
    );
  }

  /// `App access control`
  String get appAccessControl {
    return Intl.message(
      'App access control',
      name: 'appAccessControl',
      desc: '',
      args: [],
    );
  }

  /// `Only allow selected app to enter VPN`
  String get accessControlAllowDesc {
    return Intl.message(
      'Only allow selected app to enter VPN',
      name: 'accessControlAllowDesc',
      desc: '',
      args: [],
    );
  }

  /// `The selected application will be excluded from VPN`
  String get accessControlNotAllowDesc {
    return Intl.message(
      'The selected application will be excluded from VPN',
      name: 'accessControlNotAllowDesc',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message('Selected', name: 'selected', desc: '', args: []);
  }

  /// `unable to update current profile`
  String get unableToUpdateCurrentProfileDesc {
    return Intl.message(
      'unable to update current profile',
      name: 'unableToUpdateCurrentProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `No more info`
  String get noMoreInfoDesc {
    return Intl.message(
      'No more info',
      name: 'noMoreInfoDesc',
      desc: '',
      args: [],
    );
  }

  /// `profile parse error`
  String get profileParseErrorDesc {
    return Intl.message(
      'profile parse error',
      name: 'profileParseErrorDesc',
      desc: '',
      args: [],
    );
  }

  /// `ProxyPort`
  String get proxyPort {
    return Intl.message('ProxyPort', name: 'proxyPort', desc: '', args: []);
  }

  /// `Set the Clash listening port`
  String get proxyPortDesc {
    return Intl.message(
      'Set the Clash listening port',
      name: 'proxyPortDesc',
      desc: '',
      args: [],
    );
  }

  /// `Port`
  String get port {
    return Intl.message('Port', name: 'port', desc: '', args: []);
  }

  /// `LogLevel`
  String get logLevel {
    return Intl.message('LogLevel', name: 'logLevel', desc: '', args: []);
  }

  /// `Show`
  String get show {
    return Intl.message('Show', name: 'show', desc: '', args: []);
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `System proxy`
  String get systemProxy {
    return Intl.message(
      'System proxy',
      name: 'systemProxy',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get project {
    return Intl.message('Project', name: 'project', desc: '', args: []);
  }

  /// `Core`
  String get core {
    return Intl.message('Core', name: 'core', desc: '', args: []);
  }

  /// `Tab animation`
  String get tabAnimation {
    return Intl.message(
      'Tab animation',
      name: 'tabAnimation',
      desc: '',
      args: [],
    );
  }

  /// `A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.`
  String get desc {
    return Intl.message(
      'A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Starting VPN...`
  String get startVpn {
    return Intl.message(
      'Starting VPN...',
      name: 'startVpn',
      desc: '',
      args: [],
    );
  }

  /// `Stopping VPN...`
  String get stopVpn {
    return Intl.message('Stopping VPN...', name: 'stopVpn', desc: '', args: []);
  }

  /// `Discovery a new version`
  String get discovery {
    return Intl.message(
      'Discovery a new version',
      name: 'discovery',
      desc: '',
      args: [],
    );
  }

  /// `Compatibility mode`
  String get compatible {
    return Intl.message(
      'Compatibility mode',
      name: 'compatible',
      desc: '',
      args: [],
    );
  }

  /// `Opening it will lose part of its application ability and gain the support of full amount of Clash.`
  String get compatibleDesc {
    return Intl.message(
      'Opening it will lose part of its application ability and gain the support of full amount of Clash.',
      name: 'compatibleDesc',
      desc: '',
      args: [],
    );
  }

  /// `The current proxy group cannot be selected.`
  String get notSelectedTip {
    return Intl.message(
      'The current proxy group cannot be selected.',
      name: 'notSelectedTip',
      desc: '',
      args: [],
    );
  }

  /// `tip`
  String get tip {
    return Intl.message('tip', name: 'tip', desc: '', args: []);
  }

  /// `Backup and Recovery`
  String get backupAndRecovery {
    return Intl.message(
      'Backup and Recovery',
      name: 'backupAndRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Sync data via WebDAV or file`
  String get backupAndRecoveryDesc {
    return Intl.message(
      'Sync data via WebDAV or file',
      name: 'backupAndRecoveryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Backup`
  String get backup {
    return Intl.message('Backup', name: 'backup', desc: '', args: []);
  }

  /// `Recovery`
  String get recovery {
    return Intl.message('Recovery', name: 'recovery', desc: '', args: []);
  }

  /// `Only recovery profiles`
  String get recoveryProfiles {
    return Intl.message(
      'Only recovery profiles',
      name: 'recoveryProfiles',
      desc: '',
      args: [],
    );
  }

  /// `Recovery all data`
  String get recoveryAll {
    return Intl.message(
      'Recovery all data',
      name: 'recoveryAll',
      desc: '',
      args: [],
    );
  }

  /// `Recovery success`
  String get recoverySuccess {
    return Intl.message(
      'Recovery success',
      name: 'recoverySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Backup success`
  String get backupSuccess {
    return Intl.message(
      'Backup success',
      name: 'backupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No info`
  String get noInfo {
    return Intl.message('No info', name: 'noInfo', desc: '', args: []);
  }

  /// `Please bind WebDAV`
  String get pleaseBindWebDAV {
    return Intl.message(
      'Please bind WebDAV',
      name: 'pleaseBindWebDAV',
      desc: '',
      args: [],
    );
  }

  /// `Bind`
  String get bind {
    return Intl.message('Bind', name: 'bind', desc: '', args: []);
  }

  /// `Connectivity：`
  String get connectivity {
    return Intl.message(
      'Connectivity：',
      name: 'connectivity',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV configuration`
  String get webDAVConfiguration {
    return Intl.message(
      'WebDAV configuration',
      name: 'webDAVConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `WebDAV server address`
  String get addressHelp {
    return Intl.message(
      'WebDAV server address',
      name: 'addressHelp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid WebDAV address`
  String get addressTip {
    return Intl.message(
      'Please enter a valid WebDAV address',
      name: 'addressTip',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Check for updates`
  String get checkUpdate {
    return Intl.message(
      'Check for updates',
      name: 'checkUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Discover the new version`
  String get discoverNewVersion {
    return Intl.message(
      'Discover the new version',
      name: 'discoverNewVersion',
      desc: '',
      args: [],
    );
  }

  /// `The current application is already the latest version`
  String get checkUpdateError {
    return Intl.message(
      'The current application is already the latest version',
      name: 'checkUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Go to download`
  String get goDownload {
    return Intl.message(
      'Go to download',
      name: 'goDownload',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `GeoData`
  String get geoData {
    return Intl.message('GeoData', name: 'geoData', desc: '', args: []);
  }

  /// `External resources`
  String get externalResources {
    return Intl.message(
      'External resources',
      name: 'externalResources',
      desc: '',
      args: [],
    );
  }

  /// `Checking...`
  String get checking {
    return Intl.message('Checking...', name: 'checking', desc: '', args: []);
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Check error`
  String get checkError {
    return Intl.message('Check error', name: 'checkError', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Allow applications to bypass VPN`
  String get allowBypass {
    return Intl.message(
      'Allow applications to bypass VPN',
      name: 'allowBypass',
      desc: '',
      args: [],
    );
  }

  /// `Some apps can bypass VPN when turned on`
  String get allowBypassDesc {
    return Intl.message(
      'Some apps can bypass VPN when turned on',
      name: 'allowBypassDesc',
      desc: '',
      args: [],
    );
  }

  /// `ExternalController`
  String get externalController {
    return Intl.message(
      'ExternalController',
      name: 'externalController',
      desc: '',
      args: [],
    );
  }

  /// `Once enabled, the Clash kernel can be controlled on port 9090`
  String get externalControllerDesc {
    return Intl.message(
      'Once enabled, the Clash kernel can be controlled on port 9090',
      name: 'externalControllerDesc',
      desc: '',
      args: [],
    );
  }

  /// `When turned on it will be able to receive IPv6 traffic`
  String get ipv6Desc {
    return Intl.message(
      'When turned on it will be able to receive IPv6 traffic',
      name: 'ipv6Desc',
      desc: '',
      args: [],
    );
  }

  /// `App`
  String get app {
    return Intl.message('App', name: 'app', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Attach HTTP proxy to VpnService`
  String get vpnSystemProxyDesc {
    return Intl.message(
      'Attach HTTP proxy to VpnService',
      name: 'vpnSystemProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Attach HTTP proxy to VpnService`
  String get systemProxyDesc {
    return Intl.message(
      'Attach HTTP proxy to VpnService',
      name: 'systemProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Unified delay`
  String get unifiedDelay {
    return Intl.message(
      'Unified delay',
      name: 'unifiedDelay',
      desc: '',
      args: [],
    );
  }

  /// `Remove extra delays such as handshaking`
  String get unifiedDelayDesc {
    return Intl.message(
      'Remove extra delays such as handshaking',
      name: 'unifiedDelayDesc',
      desc: '',
      args: [],
    );
  }

  /// `TCP concurrent`
  String get tcpConcurrent {
    return Intl.message(
      'TCP concurrent',
      name: 'tcpConcurrent',
      desc: '',
      args: [],
    );
  }

  /// `Enabling it will allow TCP concurrency`
  String get tcpConcurrentDesc {
    return Intl.message(
      'Enabling it will allow TCP concurrency',
      name: 'tcpConcurrentDesc',
      desc: '',
      args: [],
    );
  }

  /// `Geo Low Memory Mode`
  String get geodataLoader {
    return Intl.message(
      'Geo Low Memory Mode',
      name: 'geodataLoader',
      desc: '',
      args: [],
    );
  }

  /// `Enabling will use the Geo low memory loader`
  String get geodataLoaderDesc {
    return Intl.message(
      'Enabling will use the Geo low memory loader',
      name: 'geodataLoaderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message('Requests', name: 'requests', desc: '', args: []);
  }

  /// `View recently request records`
  String get requestsDesc {
    return Intl.message(
      'View recently request records',
      name: 'requestsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Find process`
  String get findProcessMode {
    return Intl.message(
      'Find process',
      name: 'findProcessMode',
      desc: '',
      args: [],
    );
  }

  /// `Init`
  String get init {
    return Intl.message('Init', name: 'init', desc: '', args: []);
  }

  /// `Long term effective`
  String get infiniteTime {
    return Intl.message(
      'Long term effective',
      name: 'infiniteTime',
      desc: '',
      args: [],
    );
  }

  /// `Expiration time`
  String get expirationTime {
    return Intl.message(
      'Expiration time',
      name: 'expirationTime',
      desc: '',
      args: [],
    );
  }

  /// `Connections`
  String get connections {
    return Intl.message('Connections', name: 'connections', desc: '', args: []);
  }

  /// `View current connections data`
  String get connectionsDesc {
    return Intl.message(
      'View current connections data',
      name: 'connectionsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Intranet IP`
  String get intranetIP {
    return Intl.message('Intranet IP', name: 'intranetIP', desc: '', args: []);
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `Cut`
  String get cut {
    return Intl.message('Cut', name: 'cut', desc: '', args: []);
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Paste`
  String get paste {
    return Intl.message('Paste', name: 'paste', desc: '', args: []);
  }

  /// `Test url`
  String get testUrl {
    return Intl.message('Test url', name: 'testUrl', desc: '', args: []);
  }

  /// `Sync`
  String get sync {
    return Intl.message('Sync', name: 'sync', desc: '', args: []);
  }

  /// `Hidden from recent tasks`
  String get exclude {
    return Intl.message(
      'Hidden from recent tasks',
      name: 'exclude',
      desc: '',
      args: [],
    );
  }

  /// `When the app is in the background, the app is hidden from the recent task`
  String get excludeDesc {
    return Intl.message(
      'When the app is in the background, the app is hidden from the recent task',
      name: 'excludeDesc',
      desc: '',
      args: [],
    );
  }

  /// `One column`
  String get oneColumn {
    return Intl.message('One column', name: 'oneColumn', desc: '', args: []);
  }

  /// `Two columns`
  String get twoColumns {
    return Intl.message('Two columns', name: 'twoColumns', desc: '', args: []);
  }

  /// `Three columns`
  String get threeColumns {
    return Intl.message(
      'Three columns',
      name: 'threeColumns',
      desc: '',
      args: [],
    );
  }

  /// `Four columns`
  String get fourColumns {
    return Intl.message(
      'Four columns',
      name: 'fourColumns',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get expand {
    return Intl.message('Standard', name: 'expand', desc: '', args: []);
  }

  /// `Shrink`
  String get shrink {
    return Intl.message('Shrink', name: 'shrink', desc: '', args: []);
  }

  /// `Min`
  String get min {
    return Intl.message('Min', name: 'min', desc: '', args: []);
  }

  /// `Tab`
  String get tab {
    return Intl.message('Tab', name: 'tab', desc: '', args: []);
  }

  /// `List`
  String get list {
    return Intl.message('List', name: 'list', desc: '', args: []);
  }

  /// `Delay`
  String get delay {
    return Intl.message('Delay', name: 'delay', desc: '', args: []);
  }

  /// `Style`
  String get style {
    return Intl.message('Style', name: 'style', desc: '', args: []);
  }

  /// `Size`
  String get size {
    return Intl.message('Size', name: 'size', desc: '', args: []);
  }

  /// `Sort`
  String get sort {
    return Intl.message('Sort', name: 'sort', desc: '', args: []);
  }

  /// `Columns`
  String get columns {
    return Intl.message('Columns', name: 'columns', desc: '', args: []);
  }

  /// `Proxies setting`
  String get proxiesSetting {
    return Intl.message(
      'Proxies setting',
      name: 'proxiesSetting',
      desc: '',
      args: [],
    );
  }

  /// `Proxy group`
  String get proxyGroup {
    return Intl.message('Proxy group', name: 'proxyGroup', desc: '', args: []);
  }

  /// `Go`
  String get go {
    return Intl.message('Go', name: 'go', desc: '', args: []);
  }

  /// `External link`
  String get externalLink {
    return Intl.message(
      'External link',
      name: 'externalLink',
      desc: '',
      args: [],
    );
  }

  /// `Other contributors`
  String get otherContributors {
    return Intl.message(
      'Other contributors',
      name: 'otherContributors',
      desc: '',
      args: [],
    );
  }

  /// `Auto close connections`
  String get autoCloseConnections {
    return Intl.message(
      'Auto close connections',
      name: 'autoCloseConnections',
      desc: '',
      args: [],
    );
  }

  /// `Auto close connections after change node`
  String get autoCloseConnectionsDesc {
    return Intl.message(
      'Auto close connections after change node',
      name: 'autoCloseConnectionsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Only statistics proxy`
  String get onlyStatisticsProxy {
    return Intl.message(
      'Only statistics proxy',
      name: 'onlyStatisticsProxy',
      desc: '',
      args: [],
    );
  }

  /// `When turned on, only statistics proxy traffic`
  String get onlyStatisticsProxyDesc {
    return Intl.message(
      'When turned on, only statistics proxy traffic',
      name: 'onlyStatisticsProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Pure black mode`
  String get pureBlackMode {
    return Intl.message(
      'Pure black mode',
      name: 'pureBlackMode',
      desc: '',
      args: [],
    );
  }

  /// `Tcp keep alive interval`
  String get keepAliveIntervalDesc {
    return Intl.message(
      'Tcp keep alive interval',
      name: 'keepAliveIntervalDesc',
      desc: '',
      args: [],
    );
  }

  /// ` entries`
  String get entries {
    return Intl.message(' entries', name: 'entries', desc: '', args: []);
  }

  /// `Local`
  String get local {
    return Intl.message('Local', name: 'local', desc: '', args: []);
  }

  /// `Remote`
  String get remote {
    return Intl.message('Remote', name: 'remote', desc: '', args: []);
  }

  /// `Backup local data to WebDAV`
  String get remoteBackupDesc {
    return Intl.message(
      'Backup local data to WebDAV',
      name: 'remoteBackupDesc',
      desc: '',
      args: [],
    );
  }

  /// `Recovery data from WebDAV`
  String get remoteRecoveryDesc {
    return Intl.message(
      'Recovery data from WebDAV',
      name: 'remoteRecoveryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Backup local data to local`
  String get localBackupDesc {
    return Intl.message(
      'Backup local data to local',
      name: 'localBackupDesc',
      desc: '',
      args: [],
    );
  }

  /// `Recovery data from file`
  String get localRecoveryDesc {
    return Intl.message(
      'Recovery data from file',
      name: 'localRecoveryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get mode {
    return Intl.message('Mode', name: 'mode', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Source`
  String get source {
    return Intl.message('Source', name: 'source', desc: '', args: []);
  }

  /// `All apps`
  String get allApps {
    return Intl.message('All apps', name: 'allApps', desc: '', args: []);
  }

  /// `Only third-party apps`
  String get onlyOtherApps {
    return Intl.message(
      'Only third-party apps',
      name: 'onlyOtherApps',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get action {
    return Intl.message('Action', name: 'action', desc: '', args: []);
  }

  /// `Intelligent selection`
  String get intelligentSelected {
    return Intl.message(
      'Intelligent selection',
      name: 'intelligentSelected',
      desc: '',
      args: [],
    );
  }

  /// `Clipboard import`
  String get clipboardImport {
    return Intl.message(
      'Clipboard import',
      name: 'clipboardImport',
      desc: '',
      args: [],
    );
  }

  /// `Export clipboard`
  String get clipboardExport {
    return Intl.message(
      'Export clipboard',
      name: 'clipboardExport',
      desc: '',
      args: [],
    );
  }

  /// `Layout`
  String get layout {
    return Intl.message('Layout', name: 'layout', desc: '', args: []);
  }

  /// `Tight`
  String get tight {
    return Intl.message('Tight', name: 'tight', desc: '', args: []);
  }

  /// `Standard`
  String get standard {
    return Intl.message('Standard', name: 'standard', desc: '', args: []);
  }

  /// `Loose`
  String get loose {
    return Intl.message('Loose', name: 'loose', desc: '', args: []);
  }

  /// `Profiles sort`
  String get profilesSort {
    return Intl.message(
      'Profiles sort',
      name: 'profilesSort',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Stop`
  String get stop {
    return Intl.message('Stop', name: 'stop', desc: '', args: []);
  }

  /// `Processing app related settings`
  String get appDesc {
    return Intl.message(
      'Processing app related settings',
      name: 'appDesc',
      desc: '',
      args: [],
    );
  }

  /// `Modify VPN related settings`
  String get vpnDesc {
    return Intl.message(
      'Modify VPN related settings',
      name: 'vpnDesc',
      desc: '',
      args: [],
    );
  }

  /// `Update DNS related settings`
  String get dnsDesc {
    return Intl.message(
      'Update DNS related settings',
      name: 'dnsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Key`
  String get key {
    return Intl.message('Key', name: 'key', desc: '', args: []);
  }

  /// `Value`
  String get value {
    return Intl.message('Value', name: 'value', desc: '', args: []);
  }

  /// `Add Hosts`
  String get hostsDesc {
    return Intl.message('Add Hosts', name: 'hostsDesc', desc: '', args: []);
  }

  /// `Changes take effect after restarting the VPN`
  String get vpnTip {
    return Intl.message(
      'Changes take effect after restarting the VPN',
      name: 'vpnTip',
      desc: '',
      args: [],
    );
  }

  /// `Auto routes all system traffic through VpnService`
  String get vpnEnableDesc {
    return Intl.message(
      'Auto routes all system traffic through VpnService',
      name: 'vpnEnableDesc',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message('Options', name: 'options', desc: '', args: []);
  }

  /// `Loopback unlock tool`
  String get loopback {
    return Intl.message(
      'Loopback unlock tool',
      name: 'loopback',
      desc: '',
      args: [],
    );
  }

  /// `Used for UWP loopback unlocking`
  String get loopbackDesc {
    return Intl.message(
      'Used for UWP loopback unlocking',
      name: 'loopbackDesc',
      desc: '',
      args: [],
    );
  }

  /// `Providers`
  String get providers {
    return Intl.message('Providers', name: 'providers', desc: '', args: []);
  }

  /// `Proxy providers`
  String get proxyProviders {
    return Intl.message(
      'Proxy providers',
      name: 'proxyProviders',
      desc: '',
      args: [],
    );
  }

  /// `Rule providers`
  String get ruleProviders {
    return Intl.message(
      'Rule providers',
      name: 'ruleProviders',
      desc: '',
      args: [],
    );
  }

  /// `Override Dns`
  String get overrideDns {
    return Intl.message(
      'Override Dns',
      name: 'overrideDns',
      desc: '',
      args: [],
    );
  }

  /// `Turning it on will override the DNS options in the profile`
  String get overrideDnsDesc {
    return Intl.message(
      'Turning it on will override the DNS options in the profile',
      name: 'overrideDnsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `System DNS will be used when turned off`
  String get statusDesc {
    return Intl.message(
      'System DNS will be used when turned off',
      name: 'statusDesc',
      desc: '',
      args: [],
    );
  }

  /// `Prioritize the use of DOH's http/3`
  String get preferH3Desc {
    return Intl.message(
      'Prioritize the use of DOH\'s http/3',
      name: 'preferH3Desc',
      desc: '',
      args: [],
    );
  }

  /// `Respect rules`
  String get respectRules {
    return Intl.message(
      'Respect rules',
      name: 'respectRules',
      desc: '',
      args: [],
    );
  }

  /// `DNS connection following rules, need to configure proxy-server-nameserver`
  String get respectRulesDesc {
    return Intl.message(
      'DNS connection following rules, need to configure proxy-server-nameserver',
      name: 'respectRulesDesc',
      desc: '',
      args: [],
    );
  }

  /// `DNS mode`
  String get dnsMode {
    return Intl.message('DNS mode', name: 'dnsMode', desc: '', args: []);
  }

  /// `Fakeip range`
  String get fakeipRange {
    return Intl.message(
      'Fakeip range',
      name: 'fakeipRange',
      desc: '',
      args: [],
    );
  }

  /// `Fakeip filter`
  String get fakeipFilter {
    return Intl.message(
      'Fakeip filter',
      name: 'fakeipFilter',
      desc: '',
      args: [],
    );
  }

  /// `Default nameserver`
  String get defaultNameserver {
    return Intl.message(
      'Default nameserver',
      name: 'defaultNameserver',
      desc: '',
      args: [],
    );
  }

  /// `For resolving DNS server`
  String get defaultNameserverDesc {
    return Intl.message(
      'For resolving DNS server',
      name: 'defaultNameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Nameserver`
  String get nameserver {
    return Intl.message('Nameserver', name: 'nameserver', desc: '', args: []);
  }

  /// `For resolving domain`
  String get nameserverDesc {
    return Intl.message(
      'For resolving domain',
      name: 'nameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Use hosts`
  String get useHosts {
    return Intl.message('Use hosts', name: 'useHosts', desc: '', args: []);
  }

  /// `Use system hosts`
  String get useSystemHosts {
    return Intl.message(
      'Use system hosts',
      name: 'useSystemHosts',
      desc: '',
      args: [],
    );
  }

  /// `Nameserver policy`
  String get nameserverPolicy {
    return Intl.message(
      'Nameserver policy',
      name: 'nameserverPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Specify the corresponding nameserver policy`
  String get nameserverPolicyDesc {
    return Intl.message(
      'Specify the corresponding nameserver policy',
      name: 'nameserverPolicyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Proxy nameserver`
  String get proxyNameserver {
    return Intl.message(
      'Proxy nameserver',
      name: 'proxyNameserver',
      desc: '',
      args: [],
    );
  }

  /// `Domain for resolving proxy nodes`
  String get proxyNameserverDesc {
    return Intl.message(
      'Domain for resolving proxy nodes',
      name: 'proxyNameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Fallback`
  String get fallback {
    return Intl.message('Fallback', name: 'fallback', desc: '', args: []);
  }

  /// `Generally use offshore DNS`
  String get fallbackDesc {
    return Intl.message(
      'Generally use offshore DNS',
      name: 'fallbackDesc',
      desc: '',
      args: [],
    );
  }

  /// `Fallback filter`
  String get fallbackFilter {
    return Intl.message(
      'Fallback filter',
      name: 'fallbackFilter',
      desc: '',
      args: [],
    );
  }

  /// `Geoip code`
  String get geoipCode {
    return Intl.message('Geoip code', name: 'geoipCode', desc: '', args: []);
  }

  /// `Ipcidr`
  String get ipcidr {
    return Intl.message('Ipcidr', name: 'ipcidr', desc: '', args: []);
  }

  /// `Domain`
  String get domain {
    return Intl.message('Domain', name: 'domain', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Show/Hide`
  String get action_view {
    return Intl.message('Show/Hide', name: 'action_view', desc: '', args: []);
  }

  /// `Start/Stop`
  String get action_start {
    return Intl.message('Start/Stop', name: 'action_start', desc: '', args: []);
  }

  /// `Switch mode`
  String get action_mode {
    return Intl.message('Switch mode', name: 'action_mode', desc: '', args: []);
  }

  /// `System proxy`
  String get action_proxy {
    return Intl.message(
      'System proxy',
      name: 'action_proxy',
      desc: '',
      args: [],
    );
  }

  /// `TUN`
  String get action_tun {
    return Intl.message('TUN', name: 'action_tun', desc: '', args: []);
  }

  /// `Disclaimer`
  String get disclaimer {
    return Intl.message('Disclaimer', name: 'disclaimer', desc: '', args: []);
  }

  /// `This software is only used for non-commercial purposes such as learning exchanges and scientific research. It is strictly prohibited to use this software for commercial purposes. Any commercial activity, if any, has nothing to do with this software.`
  String get disclaimerDesc {
    return Intl.message(
      'This software is only used for non-commercial purposes such as learning exchanges and scientific research. It is strictly prohibited to use this software for commercial purposes. Any commercial activity, if any, has nothing to do with this software.',
      name: 'disclaimerDesc',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message('Agree', name: 'agree', desc: '', args: []);
  }

  /// `Hotkey Management`
  String get hotkeyManagement {
    return Intl.message(
      'Hotkey Management',
      name: 'hotkeyManagement',
      desc: '',
      args: [],
    );
  }

  /// `Use keyboard to control applications`
  String get hotkeyManagementDesc {
    return Intl.message(
      'Use keyboard to control applications',
      name: 'hotkeyManagementDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please press the keyboard.`
  String get pressKeyboard {
    return Intl.message(
      'Please press the keyboard.',
      name: 'pressKeyboard',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the correct hotkey`
  String get inputCorrectHotkey {
    return Intl.message(
      'Please enter the correct hotkey',
      name: 'inputCorrectHotkey',
      desc: '',
      args: [],
    );
  }

  /// `Hotkey conflict`
  String get hotkeyConflict {
    return Intl.message(
      'Hotkey conflict',
      name: 'hotkeyConflict',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `No HotKey`
  String get noHotKey {
    return Intl.message('No HotKey', name: 'noHotKey', desc: '', args: []);
  }

  /// `No network`
  String get noNetwork {
    return Intl.message('No network', name: 'noNetwork', desc: '', args: []);
  }

  /// `Allow IPv6 inbound`
  String get ipv6InboundDesc {
    return Intl.message(
      'Allow IPv6 inbound',
      name: 'ipv6InboundDesc',
      desc: '',
      args: [],
    );
  }

  /// `Export logs`
  String get exportLogs {
    return Intl.message('Export logs', name: 'exportLogs', desc: '', args: []);
  }

  /// `Export Success`
  String get exportSuccess {
    return Intl.message(
      'Export Success',
      name: 'exportSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Icon style`
  String get iconStyle {
    return Intl.message('Icon style', name: 'iconStyle', desc: '', args: []);
  }

  /// `Icon`
  String get onlyIcon {
    return Intl.message('Icon', name: 'onlyIcon', desc: '', args: []);
  }

  /// `None`
  String get noIcon {
    return Intl.message('None', name: 'noIcon', desc: '', args: []);
  }

  /// `Stack mode`
  String get stackMode {
    return Intl.message('Stack mode', name: 'stackMode', desc: '', args: []);
  }

  /// `Network`
  String get network {
    return Intl.message('Network', name: 'network', desc: '', args: []);
  }

  /// `Modify network-related settings`
  String get networkDesc {
    return Intl.message(
      'Modify network-related settings',
      name: 'networkDesc',
      desc: '',
      args: [],
    );
  }

  /// `Bypass domain`
  String get bypassDomain {
    return Intl.message(
      'Bypass domain',
      name: 'bypassDomain',
      desc: '',
      args: [],
    );
  }

  /// `Only takes effect when the system proxy is enabled`
  String get bypassDomainDesc {
    return Intl.message(
      'Only takes effect when the system proxy is enabled',
      name: 'bypassDomainDesc',
      desc: '',
      args: [],
    );
  }

  /// `Make sure to reset`
  String get resetTip {
    return Intl.message(
      'Make sure to reset',
      name: 'resetTip',
      desc: '',
      args: [],
    );
  }

  /// `RegExp`
  String get regExp {
    return Intl.message('RegExp', name: 'regExp', desc: '', args: []);
  }

  /// `Icon`
  String get icon {
    return Intl.message('Icon', name: 'icon', desc: '', args: []);
  }

  /// `Icon configuration`
  String get iconConfiguration {
    return Intl.message(
      'Icon configuration',
      name: 'iconConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noData {
    return Intl.message('No data', name: 'noData', desc: '', args: []);
  }

  /// `Admin auto launch`
  String get adminAutoLaunch {
    return Intl.message(
      'Admin auto launch',
      name: 'adminAutoLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Boot up by using admin mode`
  String get adminAutoLaunchDesc {
    return Intl.message(
      'Boot up by using admin mode',
      name: 'adminAutoLaunchDesc',
      desc: '',
      args: [],
    );
  }

  /// `FontFamily`
  String get fontFamily {
    return Intl.message('FontFamily', name: 'fontFamily', desc: '', args: []);
  }

  /// `System font`
  String get systemFont {
    return Intl.message('System font', name: 'systemFont', desc: '', args: []);
  }

  /// `Toggle`
  String get toggle {
    return Intl.message('Toggle', name: 'toggle', desc: '', args: []);
  }

  /// `System`
  String get system {
    return Intl.message('System', name: 'system', desc: '', args: []);
  }

  /// `Route mode`
  String get routeMode {
    return Intl.message('Route mode', name: 'routeMode', desc: '', args: []);
  }

  /// `Bypass private route address`
  String get routeMode_bypassPrivate {
    return Intl.message(
      'Bypass private route address',
      name: 'routeMode_bypassPrivate',
      desc: '',
      args: [],
    );
  }

  /// `Use config`
  String get routeMode_config {
    return Intl.message(
      'Use config',
      name: 'routeMode_config',
      desc: '',
      args: [],
    );
  }

  /// `Route address`
  String get routeAddress {
    return Intl.message(
      'Route address',
      name: 'routeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Config listen route address`
  String get routeAddressDesc {
    return Intl.message(
      'Config listen route address',
      name: 'routeAddressDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the admin password`
  String get pleaseInputAdminPassword {
    return Intl.message(
      'Please enter the admin password',
      name: 'pleaseInputAdminPassword',
      desc: '',
      args: [],
    );
  }

  /// `Copying environment variables`
  String get copyEnvVar {
    return Intl.message(
      'Copying environment variables',
      name: 'copyEnvVar',
      desc: '',
      args: [],
    );
  }

  /// `Memory info`
  String get memoryInfo {
    return Intl.message('Memory info', name: 'memoryInfo', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `The file has been modified. Do you want to save the changes?`
  String get fileIsUpdate {
    return Intl.message(
      'The file has been modified. Do you want to save the changes?',
      name: 'fileIsUpdate',
      desc: '',
      args: [],
    );
  }

  /// `The profile has been modified. Do you want to disable auto update?`
  String get profileHasUpdate {
    return Intl.message(
      'The profile has been modified. Do you want to disable auto update?',
      name: 'profileHasUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cache the changes?`
  String get hasCacheChange {
    return Intl.message(
      'Do you want to cache the changes?',
      name: 'hasCacheChange',
      desc: '',
      args: [],
    );
  }

  /// `Copy success`
  String get copySuccess {
    return Intl.message(
      'Copy success',
      name: 'copySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Copy link`
  String get copyLink {
    return Intl.message('Copy link', name: 'copyLink', desc: '', args: []);
  }

  /// `Export file`
  String get exportFile {
    return Intl.message('Export file', name: 'exportFile', desc: '', args: []);
  }

  /// `The cache is corrupt. Do you want to clear it?`
  String get cacheCorrupt {
    return Intl.message(
      'The cache is corrupt. Do you want to clear it?',
      name: 'cacheCorrupt',
      desc: '',
      args: [],
    );
  }

  /// `Relying on third-party api is for reference only`
  String get detectionTip {
    return Intl.message(
      'Relying on third-party api is for reference only',
      name: 'detectionTip',
      desc: '',
      args: [],
    );
  }

  /// `Listen`
  String get listen {
    return Intl.message('Listen', name: 'listen', desc: '', args: []);
  }

  /// `undo`
  String get undo {
    return Intl.message('undo', name: 'undo', desc: '', args: []);
  }

  /// `redo`
  String get redo {
    return Intl.message('redo', name: 'redo', desc: '', args: []);
  }

  /// `none`
  String get none {
    return Intl.message('none', name: 'none', desc: '', args: []);
  }

  /// `Basic configuration`
  String get basicConfig {
    return Intl.message(
      'Basic configuration',
      name: 'basicConfig',
      desc: '',
      args: [],
    );
  }

  /// `Modify the basic configuration globally`
  String get basicConfigDesc {
    return Intl.message(
      'Modify the basic configuration globally',
      name: 'basicConfigDesc',
      desc: '',
      args: [],
    );
  }

  /// `{count} items have been selected`
  String selectedCountTitle(Object count) {
    return Intl.message(
      '$count items have been selected',
      name: 'selectedCountTitle',
      desc: '',
      args: [count],
    );
  }

  /// `Add rule`
  String get addRule {
    return Intl.message('Add rule', name: 'addRule', desc: '', args: []);
  }

  /// `Rule name`
  String get ruleName {
    return Intl.message('Rule name', name: 'ruleName', desc: '', args: []);
  }

  /// `Content`
  String get content {
    return Intl.message('Content', name: 'content', desc: '', args: []);
  }

  /// `Sub rule`
  String get subRule {
    return Intl.message('Sub rule', name: 'subRule', desc: '', args: []);
  }

  /// `Rule target`
  String get ruleTarget {
    return Intl.message('Rule target', name: 'ruleTarget', desc: '', args: []);
  }

  /// `Source IP`
  String get sourceIp {
    return Intl.message('Source IP', name: 'sourceIp', desc: '', args: []);
  }

  /// `No resolve IP`
  String get noResolve {
    return Intl.message('No resolve IP', name: 'noResolve', desc: '', args: []);
  }

  /// `Get original rules`
  String get getOriginRules {
    return Intl.message(
      'Get original rules',
      name: 'getOriginRules',
      desc: '',
      args: [],
    );
  }

  /// `Override the original rule`
  String get overrideOriginRules {
    return Intl.message(
      'Override the original rule',
      name: 'overrideOriginRules',
      desc: '',
      args: [],
    );
  }

  /// `Attach on the original rules`
  String get addedOriginRules {
    return Intl.message(
      'Attach on the original rules',
      name: 'addedOriginRules',
      desc: '',
      args: [],
    );
  }

  /// `Enable override`
  String get enableOverride {
    return Intl.message(
      'Enable override',
      name: 'enableOverride',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to save the changes?`
  String get saveChanges {
    return Intl.message(
      'Do you want to save the changes?',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Modify general settings`
  String get generalDesc {
    return Intl.message(
      'Modify general settings',
      name: 'generalDesc',
      desc: '',
      args: [],
    );
  }

  /// `There is a certain performance loss after opening`
  String get findProcessModeDesc {
    return Intl.message(
      'There is a certain performance loss after opening',
      name: 'findProcessModeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Effective only in mobile view`
  String get tabAnimationDesc {
    return Intl.message(
      'Effective only in mobile view',
      name: 'tabAnimationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to save?`
  String get saveTip {
    return Intl.message(
      'Are you sure you want to save?',
      name: 'saveTip',
      desc: '',
      args: [],
    );
  }

  /// `Color schemes`
  String get colorSchemes {
    return Intl.message(
      'Color schemes',
      name: 'colorSchemes',
      desc: '',
      args: [],
    );
  }

  /// `Palette`
  String get palette {
    return Intl.message('Palette', name: 'palette', desc: '', args: []);
  }

  /// `TonalSpot`
  String get tonalSpotScheme {
    return Intl.message(
      'TonalSpot',
      name: 'tonalSpotScheme',
      desc: '',
      args: [],
    );
  }

  /// `Fidelity`
  String get fidelityScheme {
    return Intl.message('Fidelity', name: 'fidelityScheme', desc: '', args: []);
  }

  /// `Monochrome`
  String get monochromeScheme {
    return Intl.message(
      'Monochrome',
      name: 'monochromeScheme',
      desc: '',
      args: [],
    );
  }

  /// `Neutral`
  String get neutralScheme {
    return Intl.message('Neutral', name: 'neutralScheme', desc: '', args: []);
  }

  /// `Vibrant`
  String get vibrantScheme {
    return Intl.message('Vibrant', name: 'vibrantScheme', desc: '', args: []);
  }

  /// `Expressive`
  String get expressiveScheme {
    return Intl.message(
      'Expressive',
      name: 'expressiveScheme',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get contentScheme {
    return Intl.message('Content', name: 'contentScheme', desc: '', args: []);
  }

  /// `Rainbow`
  String get rainbowScheme {
    return Intl.message('Rainbow', name: 'rainbowScheme', desc: '', args: []);
  }

  /// `FruitSalad`
  String get fruitSaladScheme {
    return Intl.message(
      'FruitSalad',
      name: 'fruitSaladScheme',
      desc: '',
      args: [],
    );
  }

  /// `Developer mode`
  String get developerMode {
    return Intl.message(
      'Developer mode',
      name: 'developerMode',
      desc: '',
      args: [],
    );
  }

  /// `Developer mode is enabled.`
  String get developerModeEnableTip {
    return Intl.message(
      'Developer mode is enabled.',
      name: 'developerModeEnableTip',
      desc: '',
      args: [],
    );
  }

  /// `Message test`
  String get messageTest {
    return Intl.message(
      'Message test',
      name: 'messageTest',
      desc: '',
      args: [],
    );
  }

  /// `This is a message.`
  String get messageTestTip {
    return Intl.message(
      'This is a message.',
      name: 'messageTestTip',
      desc: '',
      args: [],
    );
  }

  /// `Crash test`
  String get crashTest {
    return Intl.message('Crash test', name: 'crashTest', desc: '', args: []);
  }

  /// `Clear Data`
  String get clearData {
    return Intl.message('Clear Data', name: 'clearData', desc: '', args: []);
  }

  /// `Zoom`
  String get zoom {
    return Intl.message('Zoom', name: 'zoom', desc: '', args: []);
  }

  /// `Text Scaling`
  String get textScale {
    return Intl.message('Text Scaling', name: 'textScale', desc: '', args: []);
  }

  /// `Internet`
  String get internet {
    return Intl.message('Internet', name: 'internet', desc: '', args: []);
  }

  /// `System APP`
  String get systemApp {
    return Intl.message('System APP', name: 'systemApp', desc: '', args: []);
  }

  /// `No network APP`
  String get noNetworkApp {
    return Intl.message(
      'No network APP',
      name: 'noNetworkApp',
      desc: '',
      args: [],
    );
  }

  /// `Contact me`
  String get contactMe {
    return Intl.message('Contact me', name: 'contactMe', desc: '', args: []);
  }

  /// `Recovery strategy`
  String get recoveryStrategy {
    return Intl.message(
      'Recovery strategy',
      name: 'recoveryStrategy',
      desc: '',
      args: [],
    );
  }

  /// `Override`
  String get recoveryStrategy_override {
    return Intl.message(
      'Override',
      name: 'recoveryStrategy_override',
      desc: '',
      args: [],
    );
  }

  /// `Compatible`
  String get recoveryStrategy_compatible {
    return Intl.message(
      'Compatible',
      name: 'recoveryStrategy_compatible',
      desc: '',
      args: [],
    );
  }

  /// `Logs test`
  String get logsTest {
    return Intl.message('Logs test', name: 'logsTest', desc: '', args: []);
  }

  /// `{label} cannot be empty`
  String emptyTip(Object label) {
    return Intl.message(
      '$label cannot be empty',
      name: 'emptyTip',
      desc: '',
      args: [label],
    );
  }

  /// `{label} must be a url`
  String urlTip(Object label) {
    return Intl.message(
      '$label must be a url',
      name: 'urlTip',
      desc: '',
      args: [label],
    );
  }

  /// `{label} must be a number`
  String numberTip(Object label) {
    return Intl.message(
      '$label must be a number',
      name: 'numberTip',
      desc: '',
      args: [label],
    );
  }

  /// `Interval`
  String get interval {
    return Intl.message('Interval', name: 'interval', desc: '', args: []);
  }

  /// `Current {label} already exists`
  String existsTip(Object label) {
    return Intl.message(
      'Current $label already exists',
      name: 'existsTip',
      desc: '',
      args: [label],
    );
  }

  /// `Are you sure you want to delete the current {label}?`
  String deleteTip(Object label) {
    return Intl.message(
      'Are you sure you want to delete the current $label?',
      name: 'deleteTip',
      desc: '',
      args: [label],
    );
  }

  /// `Are you sure you want to delete the selected {label}?`
  String deleteMultipTip(Object label) {
    return Intl.message(
      'Are you sure you want to delete the selected $label?',
      name: 'deleteMultipTip',
      desc: '',
      args: [label],
    );
  }

  /// `No {label} at the moment`
  String nullTip(Object label) {
    return Intl.message(
      'No $label at the moment',
      name: 'nullTip',
      desc: '',
      args: [label],
    );
  }

  /// `Script`
  String get script {
    return Intl.message('Script', name: 'script', desc: '', args: []);
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Rename`
  String get rename {
    return Intl.message('Rename', name: 'rename', desc: '', args: []);
  }

  /// `Unnamed`
  String get unnamed {
    return Intl.message('Unnamed', name: 'unnamed', desc: '', args: []);
  }

  /// `Please enter a script name`
  String get pleaseEnterScriptName {
    return Intl.message(
      'Please enter a script name',
      name: 'pleaseEnterScriptName',
      desc: '',
      args: [],
    );
  }

  /// `Does not take effect in script mode`
  String get overrideInvalidTip {
    return Intl.message(
      'Does not take effect in script mode',
      name: 'overrideInvalidTip',
      desc: '',
      args: [],
    );
  }

  /// `Mixed Port`
  String get mixedPort {
    return Intl.message('Mixed Port', name: 'mixedPort', desc: '', args: []);
  }

  /// `Socks Port`
  String get socksPort {
    return Intl.message('Socks Port', name: 'socksPort', desc: '', args: []);
  }

  /// `Redir Port`
  String get redirPort {
    return Intl.message('Redir Port', name: 'redirPort', desc: '', args: []);
  }

  /// `Tproxy Port`
  String get tproxyPort {
    return Intl.message('Tproxy Port', name: 'tproxyPort', desc: '', args: []);
  }

  /// `{label} must be between 1024 and 49151`
  String portTip(Object label) {
    return Intl.message(
      '$label must be between 1024 and 49151',
      name: 'portTip',
      desc: '',
      args: [label],
    );
  }

  /// `Please enter a different port`
  String get portConflictTip {
    return Intl.message(
      'Please enter a different port',
      name: 'portConflictTip',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message('Import', name: 'import', desc: '', args: []);
  }

  /// `Import from file`
  String get importFile {
    return Intl.message(
      'Import from file',
      name: 'importFile',
      desc: '',
      args: [],
    );
  }

  /// `Import from URL`
  String get importUrl {
    return Intl.message(
      'Import from URL',
      name: 'importUrl',
      desc: '',
      args: [],
    );
  }

  /// `Auto set system DNS`
  String get autoSetSystemDns {
    return Intl.message(
      'Auto set system DNS',
      name: 'autoSetSystemDns',
      desc: '',
      args: [],
    );
  }

  /// `Connection Tools`
  String get connectionTools {
    return Intl.message(
      'Connection Tools',
      name: 'connectionTools',
      desc: '',
      args: [],
    );
  }

  /// `Edit Rules`
  String get editRules {
    return Intl.message('Edit Rules', name: 'editRules', desc: '', args: []);
  }

  /// `Set Direct Connection`
  String get setDirectConnection {
    return Intl.message(
      'Set Direct Connection',
      name: 'setDirectConnection',
      desc: '',
      args: [],
    );
  }

  /// `One-click Block`
  String get oneClickBlock {
    return Intl.message(
      'One-click Block',
      name: 'oneClickBlock',
      desc: '',
      args: [],
    );
  }

  /// `GeoIp`
  String get geoIp {
    return Intl.message('GeoIp', name: 'geoIp', desc: '', args: []);
  }

  /// `GeoSite`
  String get geoSite {
    return Intl.message('GeoSite', name: 'geoSite', desc: '', args: []);
  }

  /// `MMDB`
  String get mmdb {
    return Intl.message('MMDB', name: 'mmdb', desc: '', args: []);
  }

  /// `ASN`
  String get asn {
    return Intl.message('ASN', name: 'asn', desc: '', args: []);
  }

  /// `Telegram`
  String get telegram {
    return Intl.message('Telegram', name: 'telegram', desc: '', args: []);
  }

  /// `VPN`
  String get vpn {
    return Intl.message('VPN', name: 'vpn', desc: '', args: []);
  }

  /// `DNS`
  String get dns {
    return Intl.message('DNS', name: 'dns', desc: '', args: []);
  }

  /// `UA`
  String get ua {
    return Intl.message('UA', name: 'ua', desc: '', args: []);
  }

  /// `Hosts`
  String get hosts {
    return Intl.message('Hosts', name: 'hosts', desc: '', args: []);
  }

  /// `Geoip`
  String get geoip {
    return Intl.message('Geoip', name: 'geoip', desc: '', args: []);
  }

  /// `Geosite`
  String get geosite {
    return Intl.message('Geosite', name: 'geosite', desc: '', args: []);
  }

  /// `IPv6`
  String get ipv6 {
    return Intl.message('IPv6', name: 'ipv6', desc: '', args: []);
  }

  /// `PreferH3`
  String get preferH3 {
    return Intl.message('PreferH3', name: 'preferH3', desc: '', args: []);
  }

  /// `Apply for Withdrawal`
  String get withdrawalApplication {
    return Intl.message(
      'Apply for Withdrawal',
      name: 'withdrawalApplication',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Method`
  String get withdrawalMethod {
    return Intl.message(
      'Withdrawal Method',
      name: 'withdrawalMethod',
      desc: '',
      args: [],
    );
  }

  /// `Please select withdrawal method`
  String get pleaseSelectWithdrawalMethod {
    return Intl.message(
      'Please select withdrawal method',
      name: 'pleaseSelectWithdrawalMethod',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Account`
  String get withdrawalAccount {
    return Intl.message(
      'Withdrawal Account',
      name: 'withdrawalAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter withdrawal account`
  String get pleaseEnterWithdrawalAccount {
    return Intl.message(
      'Please enter withdrawal account',
      name: 'pleaseEnterWithdrawalAccount',
      desc: '',
      args: [],
    );
  }

  /// `Current available withdrawal amount`
  String get currentAvailableWithdrawalAmount {
    return Intl.message(
      'Current available withdrawal amount',
      name: 'currentAvailableWithdrawalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Alipay account`
  String get pleaseEnterAlipayAccount {
    return Intl.message(
      'Please enter Alipay account',
      name: 'pleaseEnterAlipayAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter USDT wallet address`
  String get pleaseEnterUsdtWalletAddress {
    return Intl.message(
      'Please enter USDT wallet address',
      name: 'pleaseEnterUsdtWalletAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Paypal account`
  String get pleaseEnterPaypalAccount {
    return Intl.message(
      'Please enter Paypal account',
      name: 'pleaseEnterPaypalAccount',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal request submitted, awaiting review`
  String get withdrawalRequestSubmitted {
    return Intl.message(
      'Withdrawal request submitted, awaiting review',
      name: 'withdrawalRequestSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal request failed`
  String get withdrawalRequestFailed {
    return Intl.message(
      'Withdrawal request failed',
      name: 'withdrawalRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Transfer commission to balance`
  String get transferCommissionToBalance {
    return Intl.message(
      'Transfer commission to balance',
      name: 'transferCommissionToBalance',
      desc: '',
      args: [],
    );
  }

  /// `Transferred balance only for {appTitle} consumption`
  String transferredBalanceOnlyForAppConsumption(Object appTitle) {
    return Intl.message(
      'Transferred balance only for $appTitle consumption',
      name: 'transferredBalanceOnlyForAppConsumption',
      desc: '',
      args: [appTitle],
    );
  }

  /// `Current commission balance`
  String get currentCommissionBalance {
    return Intl.message(
      'Current commission balance',
      name: 'currentCommissionBalance',
      desc: '',
      args: [],
    );
  }

  /// `Transfer amount`
  String get transferAmount {
    return Intl.message(
      'Transfer amount',
      name: 'transferAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter amount to transfer`
  String get pleaseEnterTransferAmount {
    return Intl.message(
      'Please enter amount to transfer',
      name: 'pleaseEnterTransferAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid amount`
  String get pleaseEnterValidAmount {
    return Intl.message(
      'Please enter valid amount',
      name: 'pleaseEnterValidAmount',
      desc: '',
      args: [],
    );
  }

  /// `Transfer amount cannot exceed commission balance`
  String get transferAmountCannotExceedCommissionBalance {
    return Intl.message(
      'Transfer amount cannot exceed commission balance',
      name: 'transferAmountCannotExceedCommissionBalance',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `An error occurred`
  String get errorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Ticket not found`
  String get ticketNotFound {
    return Intl.message(
      'Ticket not found',
      name: 'ticketNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Please enter reply content`
  String get pleaseEnterReplyContent {
    return Intl.message(
      'Please enter reply content',
      name: 'pleaseEnterReplyContent',
      desc: '',
      args: [],
    );
  }

  /// `Commission transfer successful`
  String get commissionTransferSuccess {
    return Intl.message(
      'Commission transfer successful',
      name: 'commissionTransferSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Commission transfer failed: {error}`
  String commissionTransferFailed(Object error) {
    return Intl.message(
      'Commission transfer failed: $error',
      name: 'commissionTransferFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Withdrawal application successful`
  String get withdrawApplySuccess {
    return Intl.message(
      'Withdrawal application successful',
      name: 'withdrawApplySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal application failed: {error}`
  String withdrawApplyFailed(Object error) {
    return Intl.message(
      'Withdrawal application failed: $error',
      name: 'withdrawApplyFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Reply`
  String get reply {
    return Intl.message('Reply', name: 'reply', desc: '', args: []);
  }

  /// `Please enter current password`
  String get pleaseEnterCurrentPassword {
    return Intl.message(
      'Please enter current password',
      name: 'pleaseEnterCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password`
  String get pleaseEnterNewPassword {
    return Intl.message(
      'Please enter new password',
      name: 'pleaseEnterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `New password length requires 8-20 characters`
  String get newPasswordLengthRequirement {
    return Intl.message(
      'New password length requires 8-20 characters',
      name: 'newPasswordLengthRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm new password again`
  String get pleaseConfirmNewPassword {
    return Intl.message(
      'Please confirm new password again',
      name: 'pleaseConfirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get passwordChangeSuccess {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangeSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Change failed: {error}`
  String changePasswordFailed(Object error) {
    return Intl.message(
      'Change failed: $error',
      name: 'changePasswordFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message('Complete', name: 'complete', desc: '', args: []);
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password Again`
  String get confirmNewPasswordAgain {
    return Intl.message(
      'Confirm New Password Again',
      name: 'confirmNewPasswordAgain',
      desc: '',
      args: [],
    );
  }

  /// `Please enter current password`
  String get pleaseEnterCurrentPasswordHint {
    return Intl.message(
      'Please enter current password',
      name: 'pleaseEnterCurrentPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password`
  String get pleaseEnterNewPasswordHint {
    return Intl.message(
      'Please enter new password',
      name: 'pleaseEnterNewPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm new password again`
  String get pleaseConfirmNewPasswordHint {
    return Intl.message(
      'Please confirm new password again',
      name: 'pleaseConfirmNewPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `My Invite`
  String get myInvite {
    return Intl.message('My Invite', name: 'myInvite', desc: '', args: []);
  }

  /// `Current Remaining Commission`
  String get currentRemainingCommission {
    return Intl.message(
      'Current Remaining Commission',
      name: 'currentRemainingCommission',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message('Transfer', name: 'transfer', desc: '', args: []);
  }

  /// `Commission Withdrawal`
  String get commissionWithdrawal {
    return Intl.message(
      'Commission Withdrawal',
      name: 'commissionWithdrawal',
      desc: '',
      args: [],
    );
  }

  /// `My Commission`
  String get myCommission {
    return Intl.message(
      'My Commission',
      name: 'myCommission',
      desc: '',
      args: [],
    );
  }

  /// `Distribution Record`
  String get distributionRecord {
    return Intl.message(
      'Distribution Record',
      name: 'distributionRecord',
      desc: '',
      args: [],
    );
  }

  /// `Registered Users Count`
  String get registeredUsersCount {
    return Intl.message(
      'Registered Users Count',
      name: 'registeredUsersCount',
      desc: '',
      args: [],
    );
  }

  /// `Commission Rate`
  String get commissionRate {
    return Intl.message(
      'Commission Rate',
      name: 'commissionRate',
      desc: '',
      args: [],
    );
  }

  /// `Pending Commission`
  String get pendingCommission {
    return Intl.message(
      'Pending Commission',
      name: 'pendingCommission',
      desc: '',
      args: [],
    );
  }

  /// `Total Commission Earned`
  String get totalCommissionEarned {
    return Intl.message(
      'Total Commission Earned',
      name: 'totalCommissionEarned',
      desc: '',
      args: [],
    );
  }

  /// `Invite Code Management`
  String get inviteCodeManagement {
    return Intl.message(
      'Invite Code Management',
      name: 'inviteCodeManagement',
      desc: '',
      args: [],
    );
  }

  /// `Generate Invite Code`
  String get generateInviteCodeButton {
    return Intl.message(
      'Generate Invite Code',
      name: 'generateInviteCodeButton',
      desc: '',
      args: [],
    );
  }

  /// `No Invite Code`
  String get noInviteCode {
    return Intl.message(
      'No Invite Code',
      name: 'noInviteCode',
      desc: '',
      args: [],
    );
  }

  /// `Copy Link`
  String get copyLinkButton {
    return Intl.message(
      'Copy Link',
      name: 'copyLinkButton',
      desc: '',
      args: [],
    );
  }

  /// `Load Failed`
  String get loadFailed {
    return Intl.message('Load Failed', name: 'loadFailed', desc: '', args: []);
  }

  /// `Retry`
  String get retryButton {
    return Intl.message('Retry', name: 'retryButton', desc: '', args: []);
  }

  /// `Commission balance is zero, cannot transfer`
  String get zeroCommissionBalanceTransfer {
    return Intl.message(
      'Commission balance is zero, cannot transfer',
      name: 'zeroCommissionBalanceTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Commission balance is zero, cannot withdraw`
  String get zeroCommissionBalanceWithdraw {
    return Intl.message(
      'Commission balance is zero, cannot withdraw',
      name: 'zeroCommissionBalanceWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Distribution record feature in development`
  String get distributionRecordInDevelopment {
    return Intl.message(
      'Distribution record feature in development',
      name: 'distributionRecordInDevelopment',
      desc: '',
      args: [],
    );
  }

  /// `Invite code generated successfully`
  String get inviteCodeGenerateSuccess {
    return Intl.message(
      'Invite code generated successfully',
      name: 'inviteCodeGenerateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to generate invite code: {error}`
  String generateInviteCodeFailed(Object error) {
    return Intl.message(
      'Failed to generate invite code: $error',
      name: 'generateInviteCodeFailed',
      desc: '',
      args: [error],
    );
  }

  /// `App URL not configured`
  String get appUrlNotConfigured {
    return Intl.message(
      'App URL not configured',
      name: 'appUrlNotConfigured',
      desc: '',
      args: [],
    );
  }

  /// `Invite link copied to clipboard`
  String get inviteLinkCopiedToClipboard {
    return Intl.message(
      'Invite link copied to clipboard',
      name: 'inviteLinkCopiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Copy failed: {error}`
  String copyFailed(Object error) {
    return Intl.message(
      'Copy failed: $error',
      name: 'copyFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Alipay`
  String get alipay {
    return Intl.message('Alipay', name: 'alipay', desc: '', args: []);
  }

  /// `Verifying coupon...`
  String get verifyingCoupon {
    return Intl.message(
      'Verifying coupon...',
      name: 'verifyingCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Coupon verified successfully`
  String get couponVerifySuccess {
    return Intl.message(
      'Coupon verified successfully',
      name: 'couponVerifySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Please login first`
  String get pleaseLogin2 {
    return Intl.message(
      'Please login first',
      name: 'pleaseLogin2',
      desc: '',
      args: [],
    );
  }

  /// `Login to view personal information`
  String get loginToViewPersonalInfo {
    return Intl.message(
      'Login to view personal information',
      name: 'loginToViewPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders2 {
    return Intl.message('My Orders', name: 'myOrders2', desc: '', args: []);
  }

  /// `Invite Friends`
  String get inviteFriends2 {
    return Intl.message(
      'Invite Friends',
      name: 'inviteFriends2',
      desc: '',
      args: [],
    );
  }

  /// `Customer Support`
  String get customerSupport2 {
    return Intl.message(
      'Customer Support',
      name: 'customerSupport2',
      desc: '',
      args: [],
    );
  }

  /// `Other Settings`
  String get otherSettings {
    return Intl.message(
      'Other Settings',
      name: 'otherSettings',
      desc: '',
      args: [],
    );
  }

  /// `Tools`
  String get tools2 {
    return Intl.message('Tools', name: 'tools2', desc: '', args: []);
  }

  /// `Logout`
  String get logoutUser {
    return Intl.message('Logout', name: 'logoutUser', desc: '', args: []);
  }

  /// `Tools entry shown`
  String get toolsEntryShown {
    return Intl.message(
      'Tools entry shown',
      name: 'toolsEntryShown',
      desc: '',
      args: [],
    );
  }

  /// `Tools entry hidden`
  String get toolsEntryHidden {
    return Intl.message(
      'Tools entry hidden',
      name: 'toolsEntryHidden',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get confirmLogout {
    return Intl.message(
      'Confirm Logout',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get confirmLogoutMessage {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'confirmLogoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutButton {
    return Intl.message('Logout', name: 'logoutButton', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get hasNoAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'hasNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Response format error`
  String get responseFormatError {
    return Intl.message(
      'Response format error',
      name: 'responseFormatError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid configuration data structure`
  String get invalidConfigDataStructure {
    return Intl.message(
      'Invalid configuration data structure',
      name: 'invalidConfigDataStructure',
      desc: '',
      args: [],
    );
  }

  /// `Invalid response data format`
  String get invalidResponseDataFormat {
    return Intl.message(
      'Invalid response data format',
      name: 'invalidResponseDataFormat',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get configuration information, please try again later`
  String get getConfigInfoFailed {
    return Intl.message(
      'Failed to get configuration information, please try again later',
      name: 'getConfigInfoFailed',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get loginFailed {
    return Intl.message(
      'Login failed',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get registerFailed {
    return Intl.message(
      'Registration failed',
      name: 'registerFailed',
      desc: '',
      args: [],
    );
  }

  /// `Reset password failed`
  String get resetPasswordFailed {
    return Intl.message(
      'Reset password failed',
      name: 'resetPasswordFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send verification code`
  String get sendVerificationCodeFailed {
    return Intl.message(
      'Failed to send verification code',
      name: 'sendVerificationCodeFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get user information, please refresh and try again`
  String get getUserInfoFailed {
    return Intl.message(
      'Failed to get user information, please refresh and try again',
      name: 'getUserInfoFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update user information, please try again later`
  String get updateUserInfoFailed {
    return Intl.message(
      'Failed to update user information, please try again later',
      name: 'updateUserInfoFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get subscription information`
  String get getSubscribeInfoFailed {
    return Intl.message(
      'Failed to get subscription information',
      name: 'getSubscribeInfoFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get statistics`
  String get getStatisticsFailed {
    return Intl.message(
      'Failed to get statistics',
      name: 'getStatisticsFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get subscription plans, please refresh and try again`
  String get getPlansFailed {
    return Intl.message(
      'Failed to get subscription plans, please refresh and try again',
      name: 'getPlansFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get order list`
  String get getOrderListFailed {
    return Intl.message(
      'Failed to get order list',
      name: 'getOrderListFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get unpaid orders`
  String get getUnpaidOrdersFailed {
    return Intl.message(
      'Failed to get unpaid orders',
      name: 'getUnpaidOrdersFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get order details`
  String get getOrderDetailFailed {
    return Intl.message(
      'Failed to get order details',
      name: 'getOrderDetailFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create order`
  String get createOrderFailed {
    return Intl.message(
      'Failed to create order',
      name: 'createOrderFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to cancel order`
  String get cancelOrderFailed {
    return Intl.message(
      'Failed to cancel order',
      name: 'cancelOrderFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get payment methods`
  String get getPaymentMethodsFailed {
    return Intl.message(
      'Failed to get payment methods',
      name: 'getPaymentMethodsFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get payment link`
  String get getPaymentLinkFailed {
    return Intl.message(
      'Failed to get payment link',
      name: 'getPaymentLinkFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to check order status`
  String get checkOrderStatusFailed {
    return Intl.message(
      'Failed to check order status',
      name: 'checkOrderStatusFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get notice list`
  String get getNoticeListFailed {
    return Intl.message(
      'Failed to get notice list',
      name: 'getNoticeListFailed',
      desc: '',
      args: [],
    );
  }

  /// `Invalid coupon`
  String get invalidCoupon {
    return Intl.message(
      'Invalid coupon',
      name: 'invalidCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Failed to verify coupon`
  String get verifyCouponFailed {
    return Intl.message(
      'Failed to verify coupon',
      name: 'verifyCouponFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get quick login link`
  String get getQuickLoginLinkFailed {
    return Intl.message(
      'Failed to get quick login link',
      name: 'getQuickLoginLinkFailed',
      desc: '',
      args: [],
    );
  }

  /// `Commission transfer failed`
  String get commissionTransferFailed2 {
    return Intl.message(
      'Commission transfer failed',
      name: 'commissionTransferFailed2',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal application failed`
  String get withdrawalApplicationFailed {
    return Intl.message(
      'Withdrawal application failed',
      name: 'withdrawalApplicationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get user configuration`
  String get getUserConfigFailed {
    return Intl.message(
      'Failed to get user configuration',
      name: 'getUserConfigFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get ticket list`
  String get getTicketListFailed {
    return Intl.message(
      'Failed to get ticket list',
      name: 'getTicketListFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get ticket details`
  String get getTicketDetailFailed {
    return Intl.message(
      'Failed to get ticket details',
      name: 'getTicketDetailFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to reply to ticket`
  String get replyTicketFailed {
    return Intl.message(
      'Failed to reply to ticket',
      name: 'replyTicketFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to close ticket`
  String get closeTicketFailed {
    return Intl.message(
      'Failed to close ticket',
      name: 'closeTicketFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create ticket`
  String get createTicketFailed {
    return Intl.message(
      'Failed to create ticket',
      name: 'createTicketFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get unpaid orders`
  String get getUnpaidOrdersFailedMsg {
    return Intl.message(
      'Failed to get unpaid orders',
      name: 'getUnpaidOrdersFailedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Popup`
  String get popupNotification {
    return Intl.message('Popup', name: 'popupNotification', desc: '', args: []);
  }

  /// `Password changed successfully`
  String get passwordChangeSuccessMsg {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangeSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `Change failed`
  String get changeFailedMsg {
    return Intl.message(
      'Change failed',
      name: 'changeFailedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get completeBtnText {
    return Intl.message(
      'Complete',
      name: 'completeBtnText',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPasswordLabel {
    return Intl.message(
      'Current Password',
      name: 'currentPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordLabel {
    return Intl.message(
      'New Password',
      name: 'newPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password Again`
  String get confirmNewPasswordLabel {
    return Intl.message(
      'Confirm New Password Again',
      name: 'confirmNewPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal function is closed`
  String get withdrawalFunctionClosed {
    return Intl.message(
      'Withdrawal function is closed',
      name: 'withdrawalFunctionClosed',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal application submitted, please wait for review`
  String get withdrawalApplicationSubmitted {
    return Intl.message(
      'Withdrawal application submitted, please wait for review',
      name: 'withdrawalApplicationSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Application failed`
  String get applicationFailed {
    return Intl.message(
      'Application failed',
      name: 'applicationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Apply for Withdrawal`
  String get applyWithdrawal {
    return Intl.message(
      'Apply for Withdrawal',
      name: 'applyWithdrawal',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submitBtnText {
    return Intl.message('Submit', name: 'submitBtnText', desc: '', args: []);
  }

  /// `Loading configuration...`
  String get loadingConfig {
    return Intl.message(
      'Loading configuration...',
      name: 'loadingConfig',
      desc: '',
      args: [],
    );
  }

  /// `Load failed`
  String get loadFailedMsg {
    return Intl.message(
      'Load failed',
      name: 'loadFailedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retryBtnText {
    return Intl.message('Retry', name: 'retryBtnText', desc: '', args: []);
  }

  /// `Withdrawal function disabled`
  String get withdrawalFunctionDisabled {
    return Intl.message(
      'Withdrawal function disabled',
      name: 'withdrawalFunctionDisabled',
      desc: '',
      args: [],
    );
  }

  /// `The system has temporarily closed the withdrawal function`
  String get withdrawalSystemTemporarilyClosed {
    return Intl.message(
      'The system has temporarily closed the withdrawal function',
      name: 'withdrawalSystemTemporarilyClosed',
      desc: '',
      args: [],
    );
  }

  /// `Available withdrawal amount`
  String get availableWithdrawalAmount {
    return Intl.message(
      'Available withdrawal amount',
      name: 'availableWithdrawalAmount',
      desc: '',
      args: [],
    );
  }

  /// `All commission balance will be applied for withdrawal`
  String get allCommissionBalanceWillBeApplied {
    return Intl.message(
      'All commission balance will be applied for withdrawal',
      name: 'allCommissionBalanceWillBeApplied',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Method`
  String get withdrawalMethodLabel {
    return Intl.message(
      'Withdrawal Method',
      name: 'withdrawalMethodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Account`
  String get withdrawalAccountLabel {
    return Intl.message(
      'Withdrawal Account',
      name: 'withdrawalAccountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Instructions`
  String get withdrawalInstructions {
    return Intl.message(
      'Withdrawal Instructions',
      name: 'withdrawalInstructions',
      desc: '',
      args: [],
    );
  }

  /// `• Withdrawal applications require manual review after submission\n• Funds will be transferred to your account after approval\n• Please ensure withdrawal account information is accurate`
  String get withdrawalInstructionsText {
    return Intl.message(
      '• Withdrawal applications require manual review after submission\n• Funds will be transferred to your account after approval\n• Please ensure withdrawal account information is accurate',
      name: 'withdrawalInstructionsText',
      desc: '',
      args: [],
    );
  }

  /// `USDT Wallet Address`
  String get usdtWalletAddress {
    return Intl.message(
      'USDT Wallet Address',
      name: 'usdtWalletAddress',
      desc: '',
      args: [],
    );
  }

  /// `Paypal Account`
  String get paypalAccount {
    return Intl.message(
      'Paypal Account',
      name: 'paypalAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter transfer amount`
  String get pleaseEnterTransferAmountHint {
    return Intl.message(
      'Please enter transfer amount',
      name: 'pleaseEnterTransferAmountHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid amount`
  String get transferAmountValidError {
    return Intl.message(
      'Please enter valid amount',
      name: 'transferAmountValidError',
      desc: '',
      args: [],
    );
  }

  /// `Transfer amount cannot exceed commission balance`
  String get transferAmountExceedsBalance {
    return Intl.message(
      'Transfer amount cannot exceed commission balance',
      name: 'transferAmountExceedsBalance',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Commission`
  String get commissionTransferPageTitle {
    return Intl.message(
      'Transfer Commission',
      name: 'commissionTransferPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmTransfer {
    return Intl.message('Confirm', name: 'confirmTransfer', desc: '', args: []);
  }

  /// `Important Reminder`
  String get importantReminder {
    return Intl.message(
      'Important Reminder',
      name: 'importantReminder',
      desc: '',
      args: [],
    );
  }

  /// `Transfer All`
  String get transferAllAmount {
    return Intl.message(
      'Transfer All',
      name: 'transferAllAmount',
      desc: '',
      args: [],
    );
  }

  /// `Commission transfer successful`
  String get commissionTransferSuccessMsg {
    return Intl.message(
      'Commission transfer successful',
      name: 'commissionTransferSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `Transfer failed`
  String get transferFailedMsg {
    return Intl.message(
      'Transfer failed',
      name: 'transferFailedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Network`
  String get networkSection {
    return Intl.message('Network', name: 'networkSection', desc: '', args: []);
  }

  /// `Personalization`
  String get personalizationSection {
    return Intl.message(
      'Personalization',
      name: 'personalizationSection',
      desc: '',
      args: [],
    );
  }

  /// `Application`
  String get applicationSection {
    return Intl.message(
      'Application',
      name: 'applicationSection',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get modifyPassword {
    return Intl.message(
      'Change Password',
      name: 'modifyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Email Reminder`
  String get expiryEmailReminder {
    return Intl.message(
      'Expiry Email Reminder',
      name: 'expiryEmailReminder',
      desc: '',
      args: [],
    );
  }

  /// `Traffic Email Reminder`
  String get trafficEmailReminder {
    return Intl.message(
      'Traffic Email Reminder',
      name: 'trafficEmailReminder',
      desc: '',
      args: [],
    );
  }

  /// `Current Version`
  String get currentVersion {
    return Intl.message(
      'Current Version',
      name: 'currentVersion',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get userAgreement {
    return Intl.message(
      'User Agreement',
      name: 'userAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Expiry email reminder enabled`
  String get expiryEmailReminderEnabled {
    return Intl.message(
      'Expiry email reminder enabled',
      name: 'expiryEmailReminderEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Expiry email reminder disabled`
  String get expiryEmailReminderDisabled {
    return Intl.message(
      'Expiry email reminder disabled',
      name: 'expiryEmailReminderDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Traffic email reminder enabled`
  String get trafficEmailReminderEnabled {
    return Intl.message(
      'Traffic email reminder enabled',
      name: 'trafficEmailReminderEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Traffic email reminder disabled`
  String get trafficEmailReminderDisabled {
    return Intl.message(
      'Traffic email reminder disabled',
      name: 'trafficEmailReminderDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Settings failed`
  String get settingsFailed {
    return Intl.message(
      'Settings failed',
      name: 'settingsFailed',
      desc: '',
      args: [],
    );
  }

  /// `Version Info`
  String get versionInfo {
    return Intl.message(
      'Version Info',
      name: 'versionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Current Version`
  String get currentVersionLabel {
    return Intl.message(
      'Current Version',
      name: 'currentVersionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Multi-platform proxy client based on ClashMeta`
  String get appDescription {
    return Intl.message(
      'Multi-platform proxy client based on ClashMeta',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Simple, easy to use, open-source and ad-free`
  String get appFeatures {
    return Intl.message(
      'Simple, easy to use, open-source and ad-free',
      name: 'appFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy page in development`
  String get privacyPolicyInDevelopment {
    return Intl.message(
      'Privacy policy page in development',
      name: 'privacyPolicyInDevelopment',
      desc: '',
      args: [],
    );
  }

  /// `User agreement page in development`
  String get userAgreementInDevelopment {
    return Intl.message(
      'User agreement page in development',
      name: 'userAgreementInDevelopment',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get orderListTitle {
    return Intl.message(
      'My Orders',
      name: 'orderListTitle',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any orders yet`
  String get noOrdersYet {
    return Intl.message(
      'You don\'t have any orders yet',
      name: 'noOrdersYet',
      desc: '',
      args: [],
    );
  }

  /// `{count} orders in total`
  String orderCount(int count) {
    return Intl.message(
      '$count orders in total',
      name: 'orderCount',
      desc: '',
      args: [count],
    );
  }

  /// `Order No`
  String get orderNumber {
    return Intl.message('Order No', name: 'orderNumber', desc: '', args: []);
  }

  /// `Select`
  String get selectPlan {
    return Intl.message('Select', name: 'selectPlan', desc: '', args: []);
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order Type`
  String get orderType {
    return Intl.message('Order Type', name: 'orderType', desc: '', args: []);
  }

  /// `New`
  String get orderTypeNew {
    return Intl.message('New', name: 'orderTypeNew', desc: '', args: []);
  }

  /// `Renew`
  String get orderTypeRenew {
    return Intl.message('Renew', name: 'orderTypeRenew', desc: '', args: []);
  }

  /// `Upgrade`
  String get orderTypeUpgrade {
    return Intl.message(
      'Upgrade',
      name: 'orderTypeUpgrade',
      desc: '',
      args: [],
    );
  }

  /// `Reset Traffic`
  String get orderTypeResetTraffic {
    return Intl.message(
      'Reset Traffic',
      name: 'orderTypeResetTraffic',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get deposit {
    return Intl.message('Deposit', name: 'deposit', desc: '', args: []);
  }

  /// `Deposit Order`
  String get depositOrder {
    return Intl.message(
      'Deposit Order',
      name: 'depositOrder',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get mostPopular {
    return Intl.message(
      'Most Popular',
      name: 'mostPopular',
      desc: '',
      args: [],
    );
  }

  /// `Monthly avg ¥{price}`
  String pricePerMonth(String price) {
    return Intl.message(
      'Monthly avg ¥$price',
      name: 'pricePerMonth',
      desc: '',
      args: [price],
    );
  }

  /// `Total {count} orders`
  String totalOrdersCount(int count) {
    return Intl.message(
      'Total $count orders',
      name: 'totalOrdersCount',
      desc: '',
      args: [count],
    );
  }

  /// `Order was cancelled due to payment timeout.`
  String get orderCancelledDueToTimeout {
    return Intl.message(
      'Order was cancelled due to payment timeout.',
      name: 'orderCancelledDueToTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Product Information`
  String get productInfo {
    return Intl.message(
      'Product Information',
      name: 'productInfo',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Type/Period`
  String get typePeriod {
    return Intl.message('Type/Period', name: 'typePeriod', desc: '', args: []);
  }

  /// `Product Traffic`
  String get productTraffic {
    return Intl.message(
      'Product Traffic',
      name: 'productTraffic',
      desc: '',
      args: [],
    );
  }

  /// `Order Information`
  String get orderInfo {
    return Intl.message(
      'Order Information',
      name: 'orderInfo',
      desc: '',
      args: [],
    );
  }

  /// `Close Order`
  String get closeOrder {
    return Intl.message('Close Order', name: 'closeOrder', desc: '', args: []);
  }

  /// `Discount Amount`
  String get discountAmount {
    return Intl.message(
      'Discount Amount',
      name: 'discountAmount',
      desc: '',
      args: [],
    );
  }

  /// `Created At`
  String get createdAt {
    return Intl.message('Created At', name: 'createdAt', desc: '', args: []);
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `No payment methods available`
  String get noPaymentMethods {
    return Intl.message(
      'No payment methods available',
      name: 'noPaymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message('Discount', name: 'discount', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Ticket Details`
  String get ticketDetails {
    return Intl.message(
      'Ticket Details',
      name: 'ticketDetails',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any tickets yet`
  String get noTicketsYet {
    return Intl.message(
      'You don\'t have any tickets yet',
      name: 'noTicketsYet',
      desc: '',
      args: [],
    );
  }

  /// `Total {count} tickets`
  String totalTicketsCount(int count) {
    return Intl.message(
      'Total $count tickets',
      name: 'totalTicketsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Low Priority`
  String get ticketPriorityLow {
    return Intl.message(
      'Low Priority',
      name: 'ticketPriorityLow',
      desc: '',
      args: [],
    );
  }

  /// `Medium Priority`
  String get ticketPriorityMedium {
    return Intl.message(
      'Medium Priority',
      name: 'ticketPriorityMedium',
      desc: '',
      args: [],
    );
  }

  /// `High Priority`
  String get ticketPriorityHigh {
    return Intl.message(
      'High Priority',
      name: 'ticketPriorityHigh',
      desc: '',
      args: [],
    );
  }

  /// `Urgent`
  String get ticketPriorityUrgent {
    return Intl.message(
      'Urgent',
      name: 'ticketPriorityUrgent',
      desc: '',
      args: [],
    );
  }

  /// `Last Updated`
  String get lastUpdated {
    return Intl.message(
      'Last Updated',
      name: 'lastUpdated',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get viewTicketDetails {
    return Intl.message(
      'View Details',
      name: 'viewTicketDetails',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeTicketButton {
    return Intl.message('Close', name: 'closeTicketButton', desc: '', args: []);
  }

  /// `Are you sure you want to close ticket "{subject}"?`
  String confirmCloseTicket(String subject) {
    return Intl.message(
      'Are you sure you want to close ticket "$subject"?',
      name: 'confirmCloseTicket',
      desc: '',
      args: [subject],
    );
  }

  /// `Ticket closed successfully`
  String get ticketClosedSuccess {
    return Intl.message(
      'Ticket closed successfully',
      name: 'ticketClosedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to close ticket: {error}`
  String ticketCloseFailed(String error) {
    return Intl.message(
      'Failed to close ticket: $error',
      name: 'ticketCloseFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Telegram Group`
  String get telegramGroup {
    return Intl.message(
      'Telegram Group',
      name: 'telegramGroup',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get joinGroup {
    return Intl.message('Join', name: 'joinGroup', desc: '', args: []);
  }

  /// `Unable to open Telegram link`
  String get cannotOpenTelegramLink {
    return Intl.message(
      'Unable to open Telegram link',
      name: 'cannotOpenTelegramLink',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open link: {error}`
  String openLinkFailed(String error) {
    return Intl.message(
      'Failed to open link: $error',
      name: 'openLinkFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Commission distribution`
  String get commissionDistribution {
    return Intl.message(
      'Commission distribution',
      name: 'commissionDistribution',
      desc: '',
      args: [],
    );
  }

  /// `No distribution records`
  String get noDistributionRecord {
    return Intl.message(
      'No distribution records',
      name: 'noDistributionRecord',
      desc: '',
      args: [],
    );
  }

  /// `You haven't received any commission distributions yet`
  String get noDistributionRecordDescription {
    return Intl.message(
      'You haven\'t received any commission distributions yet',
      name: 'noDistributionRecordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Nodes`
  String get nodes {
    return Intl.message('Nodes', name: 'nodes', desc: '', args: []);
  }

  /// `Select Node`
  String get selectNode {
    return Intl.message('Select Node', name: 'selectNode', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
