// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(error) => "Ошибка изменения: ${error}";

  static String m1(error) => "Ошибка перевода комиссии: ${error}";

  static String m2(error) => "Не удалось расшифровать конфигурацию: ${error}";

  static String m3(subject) =>
      "Вы уверены, что хотите закрыть тикет \"${subject}\"?";

  static String m4(error) => "Ошибка копирования: ${error}";

  static String m5(label) =>
      "Вы уверены, что хотите удалить выбранные ${label}?";

  static String m6(label) => "Вы уверены, что хотите удалить текущий ${label}?";

  static String m7(label) => "${label} не может быть пустым";

  static String m8(label) => "Текущий ${label} уже существует";

  static String m9(date, days) => "Истекает ${date}, осталось ${days} дней";

  static String m10(error) => "Не удалось создать код приглашения: ${error}";

  static String m11(error) => "Не удалось загрузить конфигурацию: ${error}";

  static String m12(label) => "Сейчас ${label} нет";

  static String m13(label) => "${label} должно быть числом";

  static String m14(online, limit) => "Онлайн устройств ${online}/${limit}";

  static String m15(error) => "Не удалось открыть ссылку: ${error}";

  static String m16(count) => "Всего ${count} заказов";

  static String m17(error) => "Оплата не удалась: ${error}";

  static String m18(label) => "${label} должен быть числом от 1024 до 49151";

  static String m19(price) => "В среднем ¥${price} в месяц";

  static String m20(date) => "Опубликовано ${date}";

  static String m21(resetDay) => "Трафик будет сброшен через ${resetDay} дней";

  static String m22(count) => "Выбрано ${count} элементов";

  static String m23(code) => "Ошибка сервера: ${code}";

  static String m24(error) => "Не удалось закрыть тикет: ${error}";

  static String m25(count) => "Всего ${count} заказов";

  static String m26(count) => "Всего ${count} тикетов";

  static String m27(used, total) => "Использовано ${used} / Всего ${total} ";

  static String m28(appTitle) =>
      "Переведенный баланс только для потребления в ${appTitle}";

  static String m29(label) => "${label} должен быть URL";

  static String m30(error) => "Ошибка подачи заявки: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("О программе"),
    "accessControl": MessageLookupByLibrary.simpleMessage("Контроль доступа"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить только выбранным приложениям доступ к VPN",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Настройка доступа приложений к прокси",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Выбранные приложения будут исключены из VPN",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "action": MessageLookupByLibrary.simpleMessage("Действие"),
    "action_mode": MessageLookupByLibrary.simpleMessage("Переключить режим"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "action_start": MessageLookupByLibrary.simpleMessage("Старт/Стоп"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("Показать/Скрыть"),
    "add": MessageLookupByLibrary.simpleMessage("Добавить"),
    "addRule": MessageLookupByLibrary.simpleMessage("Добавить правило"),
    "addedOriginRules": MessageLookupByLibrary.simpleMessage(
      "Добавить к оригинальным правилам",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Адрес"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("Адрес сервера WebDAV"),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный адрес WebDAV",
    ),
    "adminAutoLaunch": MessageLookupByLibrary.simpleMessage(
      "Автозапуск с правами администратора",
    ),
    "adminAutoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запуск с правами администратора при загрузке системы",
    ),
    "ago": MessageLookupByLibrary.simpleMessage(" назад"),
    "agree": MessageLookupByLibrary.simpleMessage("Согласен"),
    "alipay": MessageLookupByLibrary.simpleMessage("Алипэй"),
    "allApps": MessageLookupByLibrary.simpleMessage("Все приложения"),
    "allCommissionBalanceWillBeApplied": MessageLookupByLibrary.simpleMessage(
      "Весь баланс комиссии будет подан на вывод",
    ),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Разрешить приложениям обходить VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Некоторые приложения могут обходить VPN при включении",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("Разрешить LAN"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить доступ к прокси через локальную сеть",
    ),
    "app": MessageLookupByLibrary.simpleMessage("Приложение"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений",
    ),
    "appDesc": MessageLookupByLibrary.simpleMessage(
      "Обработка настроек, связанных с приложением",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Мультиплатформенный прокси-клиент на основе ClashMeta",
    ),
    "appFeatures": MessageLookupByLibrary.simpleMessage(
      "Простой, удобный в использовании, открытый исходный код и без рекламы",
    ),
    "appUrlNotConfigured": MessageLookupByLibrary.simpleMessage(
      "URL приложения не настроен",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Приложение"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение настроек, связанных с приложением",
    ),
    "applicationFailed": MessageLookupByLibrary.simpleMessage(
      "Заявка не удалась",
    ),
    "applicationSection": MessageLookupByLibrary.simpleMessage("Приложение"),
    "applyWithdrawal": MessageLookupByLibrary.simpleMessage(
      "Подать заявку на вывод",
    ),
    "asn": MessageLookupByLibrary.simpleMessage("Номер автономной системы"),
    "auto": MessageLookupByLibrary.simpleMessage("Авто"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage(
      "Автопроверка обновлений",
    ),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматически проверять обновления при запуске приложения",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Автоматическое закрытие соединений",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматически закрывать соединения после смены узла",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Автозапуск"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Следовать автозапуску системы",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Автозапуск"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматический запуск при открытии приложения",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Автоматическая настройка системного DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Автообновление"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления (минуты)",
    ),
    "availableCommission": MessageLookupByLibrary.simpleMessage(
      "Доступная комиссия",
    ),
    "availableWithdrawalAmount": MessageLookupByLibrary.simpleMessage(
      "Доступная сумма для вывода",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "backup": MessageLookupByLibrary.simpleMessage("Резервное копирование"),
    "backupAndRecovery": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование и восстановление",
    ),
    "backupAndRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Синхронизация данных через WebDAV или файл",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование успешно",
    ),
    "balance": MessageLookupByLibrary.simpleMessage("Баланс"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Базовая конфигурация"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальное изменение базовых настроек",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Привязать"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage(
      "Режим черного списка",
    ),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Обход домена"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только при включенном системном прокси",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Кэш поврежден. Хотите очистить его?",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cancelFilterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Отменить фильтрацию системных приложений",
    ),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("Отменить заказ"),
    "cancelOrderConfirmTip": MessageLookupByLibrary.simpleMessage(
      "Если вы уже оплатили, отмена заказа может привести к ошибке платежа. Вы уверены, что хотите отменить заказ?",
    ),
    "cancelOrderFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось отменить заказ",
    ),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Отменить выбор всего",
    ),
    "cannotOpenTelegramLink": MessageLookupByLibrary.simpleMessage(
      "Не удается открыть ссылку Telegram",
    ),
    "changeFailedMsg": MessageLookupByLibrary.simpleMessage(
      "Изменение не удалось",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Изменить пароль"),
    "changePasswordFailed": m0,
    "checkError": MessageLookupByLibrary.simpleMessage("Ошибка проверки"),
    "checkOrderStatusFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось проверить статус заказа",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Проверить обновления"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "Текущее приложение уже является последней версией",
    ),
    "checking": MessageLookupByLibrary.simpleMessage("Проверка..."),
    "checkout": MessageLookupByLibrary.simpleMessage("Оформить заказ"),
    "clearData": MessageLookupByLibrary.simpleMessage("Очистить данные"),
    "clickToPay": MessageLookupByLibrary.simpleMessage("Нажмите для оплаты"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Экспорт в буфер обмена",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Импорт из буфера обмена",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "closeOrder": MessageLookupByLibrary.simpleMessage("Закрыть заказ"),
    "closeTicket": MessageLookupByLibrary.simpleMessage("Закрыть тикет"),
    "closeTicketButton": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "closeTicketFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось закрыть тикет",
    ),
    "color": MessageLookupByLibrary.simpleMessage("Цвет"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Цветовые схемы"),
    "columns": MessageLookupByLibrary.simpleMessage("Столбцы"),
    "commissionDistribution": MessageLookupByLibrary.simpleMessage(
      "Распределение комиссии",
    ),
    "commissionRate": MessageLookupByLibrary.simpleMessage("Ставка комиссии"),
    "commissionTransferFailed": m1,
    "commissionTransferFailed2": MessageLookupByLibrary.simpleMessage(
      "Ошибка перевода комиссии",
    ),
    "commissionTransferPageTitle": MessageLookupByLibrary.simpleMessage(
      "Перевод комиссии",
    ),
    "commissionTransferSuccess": MessageLookupByLibrary.simpleMessage(
      "Перевод комиссии выполнен успешно",
    ),
    "commissionTransferSuccessMsg": MessageLookupByLibrary.simpleMessage(
      "Перевод комиссии успешен",
    ),
    "commissionWithdrawal": MessageLookupByLibrary.simpleMessage(
      "Вывод комиссии",
    ),
    "compatible": MessageLookupByLibrary.simpleMessage("Режим совместимости"),
    "compatibleDesc": MessageLookupByLibrary.simpleMessage(
      "Включение приведет к потере части функциональности приложения, но обеспечит полную поддержку Clash.",
    ),
    "complete": MessageLookupByLibrary.simpleMessage("Завершить"),
    "completeBtnText": MessageLookupByLibrary.simpleMessage("Завершить"),
    "configDecryptFailed": m2,
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "confirmCloseTicket": m3,
    "confirmLogout": MessageLookupByLibrary.simpleMessage("Подтвердить выход"),
    "confirmLogoutMessage": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите выйти?",
    ),
    "confirmNewPasswordAgain": MessageLookupByLibrary.simpleMessage(
      "Подтвердите новый пароль еще раз",
    ),
    "confirmNewPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Подтвердите новый пароль еще раз",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "confirmPayment": MessageLookupByLibrary.simpleMessage(
      "Подтвердить оплату",
    ),
    "confirmTransfer": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "connectionTools": MessageLookupByLibrary.simpleMessage(
      "Инструменты подключения",
    ),
    "connections": MessageLookupByLibrary.simpleMessage("Соединения"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр текущих данных о соединениях",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Связь："),
    "contactMe": MessageLookupByLibrary.simpleMessage("Свяжитесь со мной"),
    "content": MessageLookupByLibrary.simpleMessage("Содержание"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Контентная тема"),
    "copy": MessageLookupByLibrary.simpleMessage("Копировать"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Копирование переменных окружения",
    ),
    "copyFailed": m4,
    "copyLink": MessageLookupByLibrary.simpleMessage("Копировать ссылку"),
    "copyLinkButton": MessageLookupByLibrary.simpleMessage("Копировать ссылку"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Копирование успешно"),
    "core": MessageLookupByLibrary.simpleMessage("Ядро"),
    "coreInfo": MessageLookupByLibrary.simpleMessage("Информация о ядре"),
    "country": MessageLookupByLibrary.simpleMessage("Страна"),
    "couponCode": MessageLookupByLibrary.simpleMessage("Код купона"),
    "couponCodeHint": MessageLookupByLibrary.simpleMessage(
      "Введите код купона (опционально)",
    ),
    "couponValid": MessageLookupByLibrary.simpleMessage(
      "Код купона действителен",
    ),
    "couponVerifySuccess": MessageLookupByLibrary.simpleMessage(
      "Купон успешно проверен",
    ),
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест на сбои"),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "createOrder": MessageLookupByLibrary.simpleMessage("Создать заказ"),
    "createOrderFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось создать заказ",
    ),
    "createTicket": MessageLookupByLibrary.simpleMessage("Создать тикет"),
    "createTicketFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось создать тикет",
    ),
    "createdAt": MessageLookupByLibrary.simpleMessage("Дата создания"),
    "currentAvailableWithdrawalAmount": MessageLookupByLibrary.simpleMessage(
      "Текущая доступная сумма для вывода",
    ),
    "currentCommissionBalance": MessageLookupByLibrary.simpleMessage(
      "Текущий баланс комиссии",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Текущий пароль"),
    "currentPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Текущий пароль",
    ),
    "currentRemainingCommission": MessageLookupByLibrary.simpleMessage(
      "Текущая оставшаяся комиссия",
    ),
    "currentVersion": MessageLookupByLibrary.simpleMessage("Текущая версия"),
    "currentVersionLabel": MessageLookupByLibrary.simpleMessage(
      "Текущая версия",
    ),
    "customerSupport": MessageLookupByLibrary.simpleMessage("Служба поддержки"),
    "customerSupport2": MessageLookupByLibrary.simpleMessage(
      "Служба поддержки",
    ),
    "cut": MessageLookupByLibrary.simpleMessage("Вырезать"),
    "dark": MessageLookupByLibrary.simpleMessage("Темный"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Панель управления"),
    "days": MessageLookupByLibrary.simpleMessage("Дней"),
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Сервер имен по умолчанию",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Для разрешения DNS-сервера",
    ),
    "defaultSort": MessageLookupByLibrary.simpleMessage(
      "Сортировка по умолчанию",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("По умолчанию"),
    "delay": MessageLookupByLibrary.simpleMessage("Задержка"),
    "delaySort": MessageLookupByLibrary.simpleMessage("Сортировка по задержке"),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "deleteMultipTip": m5,
    "deleteTip": m6,
    "deposit": MessageLookupByLibrary.simpleMessage("Пополнение"),
    "depositOrder": MessageLookupByLibrary.simpleMessage("Заказ пополнения"),
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный прокси-клиент на основе ClashMeta, простой и удобный в использовании, с открытым исходным кодом и без рекламы.",
    ),
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Опирается на сторонний API, только для справки",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Режим разработчика"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Режим разработчика активирован.",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Прямой"),
    "disclaimer": MessageLookupByLibrary.simpleMessage(
      "Отказ от ответственности",
    ),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "Это программное обеспечение используется только в некоммерческих целях, таких как учебные обмены и научные исследования. Запрещено использовать это программное обеспечение в коммерческих целях. Любая коммерческая деятельность, если таковая имеется, не имеет отношения к этому программному обеспечению.",
    ),
    "discount": MessageLookupByLibrary.simpleMessage("Скидка"),
    "discountAmount": MessageLookupByLibrary.simpleMessage("Сумма скидки"),
    "discountedPrice": MessageLookupByLibrary.simpleMessage("Цена со скидкой"),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage(
      "Обнаружена новая версия",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Обнаружена новая версия",
    ),
    "distributionRecord": MessageLookupByLibrary.simpleMessage(
      "Запись распределения",
    ),
    "distributionRecordInDevelopment": MessageLookupByLibrary.simpleMessage(
      "Функция записи распределения в разработке",
    ),
    "dns": MessageLookupByLibrary.simpleMessage("Разрешение доменных имен"),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Обновление настроек, связанных с DNS",
    ),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Режим DNS"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Вы хотите пропустить",
    ),
    "domain": MessageLookupByLibrary.simpleMessage("Домен"),
    "download": MessageLookupByLibrary.simpleMessage("Скачивание"),
    "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
    "editRules": MessageLookupByLibrary.simpleMessage("Редактировать правила"),
    "emailCodeHint": MessageLookupByLibrary.simpleMessage(
      "Введите проверочный код",
    ),
    "emailHint": MessageLookupByLibrary.simpleMessage("Введите email"),
    "emailSuffixError": MessageLookupByLibrary.simpleMessage(
      "Этот домен email не разрешен",
    ),
    "emptyTip": m7,
    "en": MessageLookupByLibrary.simpleMessage("Английский"),
    "enableOverride": MessageLookupByLibrary.simpleMessage(
      "Включить переопределение",
    ),
    "enterMessage": MessageLookupByLibrary.simpleMessage("Введите сообщение"),
    "entries": MessageLookupByLibrary.simpleMessage(" записей"),
    "error": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Произошла ошибка"),
    "exclude": MessageLookupByLibrary.simpleMessage(
      "Скрыть из последних задач",
    ),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Когда приложение находится в фоновом режиме, оно скрыто из последних задач",
    ),
    "existsTip": m8,
    "exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "expand": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "expirationInfo": m9,
    "expirationTime": MessageLookupByLibrary.simpleMessage("Время истечения"),
    "expireTime": MessageLookupByLibrary.simpleMessage("Срок действия"),
    "expired": MessageLookupByLibrary.simpleMessage("Истек срок"),
    "expiryEmailReminder": MessageLookupByLibrary.simpleMessage(
      "Напоминание об истечении срока по email",
    ),
    "expiryEmailReminderDisabled": MessageLookupByLibrary.simpleMessage(
      "Напоминание об истечении срока по email отключено",
    ),
    "expiryEmailReminderEnabled": MessageLookupByLibrary.simpleMessage(
      "Напоминание об истечении срока по email включено",
    ),
    "exportFile": MessageLookupByLibrary.simpleMessage("Экспорт файла"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Экспорт логов"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Экспорт успешен"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Экспрессивные"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "Внешний контроллер",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "При включении ядро Clash можно контролировать на порту 9090",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("Внешняя ссылка"),
    "externalResources": MessageLookupByLibrary.simpleMessage(
      "Внешние ресурсы",
    ),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Фильтр Fakeip"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Диапазон Fakeip"),
    "fallback": MessageLookupByLibrary.simpleMessage("Резервный"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Обычно используется оффшорный DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage(
      "Фильтр резервного DNS",
    ),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Точная передача"),
    "file": MessageLookupByLibrary.simpleMessage("Файл"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("Прямая загрузка профиля"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "Файл был изменен. Хотите сохранить изменения?",
    ),
    "filterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Фильтровать системные приложения",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage(
      "Режим поиска процесса",
    ),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "При включении возможны небольшие потери производительности",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Семейство шрифтов"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль"),
    "fourColumns": MessageLookupByLibrary.simpleMessage("Четыре столбца"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("Фруктовый микс"),
    "general": MessageLookupByLibrary.simpleMessage("Общие"),
    "generalDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение общих настроек",
    ),
    "generateInviteCode": MessageLookupByLibrary.simpleMessage(
      "Сгенерировать код",
    ),
    "generateInviteCodeButton": MessageLookupByLibrary.simpleMessage(
      "Создать код приглашения",
    ),
    "generateInviteCodeFailed": m10,
    "geoData": MessageLookupByLibrary.simpleMessage("Геоданные"),
    "geoIp": MessageLookupByLibrary.simpleMessage("Географический IP"),
    "geoSite": MessageLookupByLibrary.simpleMessage("Географические сайты"),
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Режим низкого потребления памяти для геоданных",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Включение будет использовать загрузчик геоданных с низким потреблением памяти",
    ),
    "geoip": MessageLookupByLibrary.simpleMessage("Географический IP"),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Код Geoip"),
    "geosite": MessageLookupByLibrary.simpleMessage("Географические сайты"),
    "getConfigInfoFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить информацию о конфигурации, попробуйте позже",
    ),
    "getNoticeListFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить список уведомлений",
    ),
    "getOrderDetailFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить детали заказа",
    ),
    "getOrderListFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить список заказов",
    ),
    "getOriginRules": MessageLookupByLibrary.simpleMessage(
      "Получить оригинальные правила",
    ),
    "getPaymentLinkFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить ссылку на оплату",
    ),
    "getPaymentMethodsFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить способы оплаты",
    ),
    "getPlansFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить планы подписок, обновите и попробуйте снова",
    ),
    "getQuickLoginLinkFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить ссылку быстрого входа",
    ),
    "getStatisticsFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить статистику",
    ),
    "getSubscribeInfoFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить информацию о подписке",
    ),
    "getTicketDetailFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить детали тикета",
    ),
    "getTicketListFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить список тикетов",
    ),
    "getUnpaidOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить неоплаченные заказы",
    ),
    "getUnpaidOrdersFailedMsg": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить неоплаченные заказы",
    ),
    "getUserConfigFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить конфигурацию пользователя",
    ),
    "getUserInfoFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить информацию о пользователе, обновите и попробуйте снова",
    ),
    "global": MessageLookupByLibrary.simpleMessage("Глобальный"),
    "go": MessageLookupByLibrary.simpleMessage("Перейти"),
    "goDownload": MessageLookupByLibrary.simpleMessage("Перейти к загрузке"),
    "goToPay": MessageLookupByLibrary.simpleMessage("Перейти к оплате"),
    "halfYearlyPlan": MessageLookupByLibrary.simpleMessage("Полугодовой"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Хотите сохранить изменения в кэше?",
    ),
    "hasNoAccount": MessageLookupByLibrary.simpleMessage("Нет аккаунта?"),
    "haveCoupon": MessageLookupByLibrary.simpleMessage("Есть купон?"),
    "hosts": MessageLookupByLibrary.simpleMessage("Файл хостов"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Добавить Hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage(
      "Конфликт горячих клавиш",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Управление горячими клавишами",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Использование клавиатуры для управления приложением",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Часов"),
    "icon": MessageLookupByLibrary.simpleMessage("Иконка"),
    "iconConfiguration": MessageLookupByLibrary.simpleMessage(
      "Конфигурация иконки",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Стиль иконки"),
    "import": MessageLookupByLibrary.simpleMessage("Импорт"),
    "importFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка импорта подписки",
    ),
    "importFile": MessageLookupByLibrary.simpleMessage("Импорт из файла"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Импорт из URL"),
    "importSuccess": MessageLookupByLibrary.simpleMessage(
      "Импорт подписки успешен",
    ),
    "importUrl": MessageLookupByLibrary.simpleMessage("Импорт по URL"),
    "importantReminder": MessageLookupByLibrary.simpleMessage(
      "Важное напоминание",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage(
      "Долгосрочное действие",
    ),
    "init": MessageLookupByLibrary.simpleMessage("Инициализация"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите правильную горячую клавишу",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Интеллектуальный выбор",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Интернет"),
    "interval": MessageLookupByLibrary.simpleMessage("Интервал"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Внутренний IP"),
    "invalidConfigDataStructure": MessageLookupByLibrary.simpleMessage(
      "Неверная структура данных конфигурации",
    ),
    "invalidCoupon": MessageLookupByLibrary.simpleMessage(
      "Недействительный купон",
    ),
    "invalidResponseDataFormat": MessageLookupByLibrary.simpleMessage(
      "Неверный формат данных ответа",
    ),
    "inviteCodeGenerateSuccess": MessageLookupByLibrary.simpleMessage(
      "Код приглашения успешно создан",
    ),
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage(
      "Введите код приглашения (опционально)",
    ),
    "inviteCodeManagement": MessageLookupByLibrary.simpleMessage(
      "Управление кодами приглашения",
    ),
    "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Введите код приглашения",
    ),
    "inviteFriends": MessageLookupByLibrary.simpleMessage("Пригласить друзей"),
    "inviteFriends2": MessageLookupByLibrary.simpleMessage("Пригласить друзей"),
    "inviteLink": MessageLookupByLibrary.simpleMessage(
      "Ссылка для приглашения",
    ),
    "inviteLinkCopied": MessageLookupByLibrary.simpleMessage(
      "Ваша ссылка для приглашения скопирована, пригласите друзей!",
    ),
    "inviteLinkCopiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "Ссылка для приглашения скопирована в буфер обмена",
    ),
    "invitedUsers": MessageLookupByLibrary.simpleMessage(
      "Приглашенные пользователи",
    ),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6": MessageLookupByLibrary.simpleMessage("Протокол IPv6"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "При включении будет возможно получать IPv6 трафик",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить входящий IPv6",
    ),
    "ja": MessageLookupByLibrary.simpleMessage("Японский"),
    "joinGroup": MessageLookupByLibrary.simpleMessage("Присоединиться"),
    "just": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Интервал поддержания TCP-соединения",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Последнее обновление"),
    "layout": MessageLookupByLibrary.simpleMessage("Макет"),
    "light": MessageLookupByLibrary.simpleMessage("Светлый"),
    "list": MessageLookupByLibrary.simpleMessage("Список"),
    "listen": MessageLookupByLibrary.simpleMessage("Слушать"),
    "loadConfigFailed": m11,
    "loadFailed": MessageLookupByLibrary.simpleMessage("Ошибка загрузки"),
    "loadFailedMsg": MessageLookupByLibrary.simpleMessage(
      "Загрузка не удалась",
    ),
    "loadingConfig": MessageLookupByLibrary.simpleMessage(
      "Загрузка конфигурации...",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Локальный"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование локальных данных на локальный диск",
    ),
    "localRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановление данных из файла",
    ),
    "logLevel": MessageLookupByLibrary.simpleMessage("Уровень логов"),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Отключение скроет запись логов",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Войти"),
    "loginError": MessageLookupByLibrary.simpleMessage("Ошибка входа"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("Ошибка входа"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "Вход выполнен успешно",
    ),
    "loginToViewPersonalInfo": MessageLookupByLibrary.simpleMessage(
      "Войдите для просмотра личной информации",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
    "logoutButton": MessageLookupByLibrary.simpleMessage("Выйти"),
    "logoutUser": MessageLookupByLibrary.simpleMessage("Выйти"),
    "logs": MessageLookupByLibrary.simpleMessage("Логи"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Записи захвата логов"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Тест журналов"),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Инструмент разблокировки Loopback",
    ),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Используется для разблокировки Loopback UWP",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Свободный"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Информация о памяти"),
    "messageTest": MessageLookupByLibrary.simpleMessage(
      "Тестирование сообщения",
    ),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("Это сообщение."),
    "min": MessageLookupByLibrary.simpleMessage("Мин"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Свернуть при выходе",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Изменить стандартное событие выхода из системы",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("Минут"),
    "mixedPort": MessageLookupByLibrary.simpleMessage("Смешанный порт"),
    "mmdb": MessageLookupByLibrary.simpleMessage("Меморная база данных"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим"),
    "modifyPassword": MessageLookupByLibrary.simpleMessage("Изменить пароль"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthlyPlan": MessageLookupByLibrary.simpleMessage("Ежемесячно"),
    "months": MessageLookupByLibrary.simpleMessage("Месяцев"),
    "more": MessageLookupByLibrary.simpleMessage("Еще"),
    "moreActions": MessageLookupByLibrary.simpleMessage("Больше действий"),
    "mostPopular": MessageLookupByLibrary.simpleMessage("Самый популярный"),
    "myAccount": MessageLookupByLibrary.simpleMessage("Мой аккаунт"),
    "myCenter": MessageLookupByLibrary.simpleMessage("Мое"),
    "myCommission": MessageLookupByLibrary.simpleMessage("Моя комиссия"),
    "myInvite": MessageLookupByLibrary.simpleMessage("Мои приглашения"),
    "myOrders": MessageLookupByLibrary.simpleMessage("Мои заказы"),
    "myOrders2": MessageLookupByLibrary.simpleMessage("Мои заказы"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "nameSort": MessageLookupByLibrary.simpleMessage("Сортировка по имени"),
    "nameserver": MessageLookupByLibrary.simpleMessage("Сервер имен"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Для разрешения домена",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика сервера имен",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Указать соответствующую политику сервера имен",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Сеть"),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение настроек, связанных с сетью",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Обнаружение сети",
    ),
    "networkSection": MessageLookupByLibrary.simpleMessage("Сеть"),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Скорость сети"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Нейтральные"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "newPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Введите новый пароль",
    ),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "newPasswordLengthRequirement": MessageLookupByLibrary.simpleMessage(
      "Новый пароль должен содержать 8-20 символов",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Далее"),
    "noData": MessageLookupByLibrary.simpleMessage("Нет данных"),
    "noDistributionRecord": MessageLookupByLibrary.simpleMessage(
      "Нет записей о распределении",
    ),
    "noDistributionRecordDescription": MessageLookupByLibrary.simpleMessage(
      "У вас пока нет записей о распределении комиссии",
    ),
    "noHotKey": MessageLookupByLibrary.simpleMessage("Нет горячей клавиши"),
    "noIcon": MessageLookupByLibrary.simpleMessage("Нет иконки"),
    "noInfo": MessageLookupByLibrary.simpleMessage("Нет информации"),
    "noInviteCode": MessageLookupByLibrary.simpleMessage(
      "Нет кода приглашения",
    ),
    "noMoreInfoDesc": MessageLookupByLibrary.simpleMessage(
      "Нет дополнительной информации",
    ),
    "noNetwork": MessageLookupByLibrary.simpleMessage("Нет сети"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("Приложение без сети"),
    "noNotices": MessageLookupByLibrary.simpleMessage("Нет уведомлений"),
    "noOrders": MessageLookupByLibrary.simpleMessage("Нет заказов"),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage(
      "У вас пока нет заказов",
    ),
    "noPaymentMethods": MessageLookupByLibrary.simpleMessage(
      "Нет доступных способов оплаты",
    ),
    "noPlans": MessageLookupByLibrary.simpleMessage("Нет доступных тарифов"),
    "noProxy": MessageLookupByLibrary.simpleMessage("Нет прокси"),
    "noProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, создайте профиль или добавьте действительный профиль",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("Не разрешать IP"),
    "noSubscribeUrl": MessageLookupByLibrary.simpleMessage("Нет URL подписки"),
    "noTickets": MessageLookupByLibrary.simpleMessage("Нет тикетов"),
    "noTicketsYet": MessageLookupByLibrary.simpleMessage(
      "У вас пока нет тикетов",
    ),
    "nodes": MessageLookupByLibrary.simpleMessage("Узлы"),
    "none": MessageLookupByLibrary.simpleMessage("Нет"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущая группа прокси не может быть выбрана.",
    ),
    "notices": MessageLookupByLibrary.simpleMessage("Уведомления"),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Нет профиля, пожалуйста, добавьте профиль",
    ),
    "nullTip": m12,
    "numberTip": m13,
    "officialWebsite": MessageLookupByLibrary.simpleMessage("Официальный сайт"),
    "oneClickBlock": MessageLookupByLibrary.simpleMessage(
      "Блокировка одним кликом",
    ),
    "oneColumn": MessageLookupByLibrary.simpleMessage("Один столбец"),
    "onetimePlan": MessageLookupByLibrary.simpleMessage("Разовый"),
    "onlineDevices": MessageLookupByLibrary.simpleMessage("Онлайн устройства"),
    "onlineStatus": m14,
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Только иконка"),
    "onlyOtherApps": MessageLookupByLibrary.simpleMessage(
      "Только сторонние приложения",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Только статистика прокси",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "При включении будет учитываться только трафик прокси",
    ),
    "openLinkFailed": m15,
    "options": MessageLookupByLibrary.simpleMessage("Опции"),
    "orderAmount": MessageLookupByLibrary.simpleMessage("Сумма"),
    "orderCancelledDueToTimeout": MessageLookupByLibrary.simpleMessage(
      "Заказ был отменен из-за истечения времени оплаты.",
    ),
    "orderCompletedTip": MessageLookupByLibrary.simpleMessage(
      "Заказ оплачен и активирован.",
    ),
    "orderCount": m16,
    "orderCreatedAt": MessageLookupByLibrary.simpleMessage("Создан"),
    "orderDetails": MessageLookupByLibrary.simpleMessage("Детали заказа"),
    "orderDiscount": MessageLookupByLibrary.simpleMessage("Скидка"),
    "orderInfo": MessageLookupByLibrary.simpleMessage("Информация о заказе"),
    "orderListTitle": MessageLookupByLibrary.simpleMessage("Мои заказы"),
    "orderNumber": MessageLookupByLibrary.simpleMessage("Номер заказа"),
    "orderStatusCancelled": MessageLookupByLibrary.simpleMessage("Отменен"),
    "orderStatusCompleted": MessageLookupByLibrary.simpleMessage("Завершен"),
    "orderStatusDeducted": MessageLookupByLibrary.simpleMessage("Вычтен"),
    "orderStatusProcessing": MessageLookupByLibrary.simpleMessage(
      "Обрабатывается",
    ),
    "orderStatusUnpaid": MessageLookupByLibrary.simpleMessage("Не оплачен"),
    "orderTotal": MessageLookupByLibrary.simpleMessage("Итого по заказу"),
    "orderType": MessageLookupByLibrary.simpleMessage("Тип заказа"),
    "orderTypeNew": MessageLookupByLibrary.simpleMessage("Новый"),
    "orderTypeRenew": MessageLookupByLibrary.simpleMessage("Продление"),
    "orderTypeResetTraffic": MessageLookupByLibrary.simpleMessage(
      "Сброс трафика",
    ),
    "orderTypeUpgrade": MessageLookupByLibrary.simpleMessage("Обновление"),
    "other": MessageLookupByLibrary.simpleMessage("Другое"),
    "otherContributors": MessageLookupByLibrary.simpleMessage(
      "Другие участники",
    ),
    "otherSettings": MessageLookupByLibrary.simpleMessage("Другие настройки"),
    "outboundMode": MessageLookupByLibrary.simpleMessage(
      "Режим исходящего трафика",
    ),
    "override": MessageLookupByLibrary.simpleMessage("Переопределить"),
    "overrideDesc": MessageLookupByLibrary.simpleMessage(
      "Переопределить конфигурацию, связанную с прокси",
    ),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Переопределить DNS"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Включение переопределит настройки DNS в профиле",
    ),
    "overrideInvalidTip": MessageLookupByLibrary.simpleMessage(
      "В скриптовом режиме не действует",
    ),
    "overrideOriginRules": MessageLookupByLibrary.simpleMessage(
      "Переопределить оригинальное правило",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Палитра"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordChangeSuccess": MessageLookupByLibrary.simpleMessage(
      "Пароль успешно изменен",
    ),
    "passwordChangeSuccessMsg": MessageLookupByLibrary.simpleMessage(
      "Пароль успешно изменен",
    ),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Введите пароль"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Длина пароля не может быть меньше 8",
    ),
    "paste": MessageLookupByLibrary.simpleMessage("Вставить"),
    "paymentFailed": m17,
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Способ оплаты"),
    "paypalAccount": MessageLookupByLibrary.simpleMessage("Аккаунт Paypal"),
    "pendingCommission": MessageLookupByLibrary.simpleMessage(
      "Ожидающая комиссия",
    ),
    "permanentSubscription": MessageLookupByLibrary.simpleMessage(
      "Постоянная подписка",
    ),
    "personalizationSection": MessageLookupByLibrary.simpleMessage(
      "Персонализация",
    ),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, привяжите WebDAV",
    ),
    "pleaseConfirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, подтвердите новый пароль",
    ),
    "pleaseConfirmNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, подтвердите новый пароль еще раз",
    ),
    "pleaseEnterAlipayAccount": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите аккаунт Alipay",
    ),
    "pleaseEnterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите текущий пароль",
    ),
    "pleaseEnterCurrentPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите текущий пароль",
    ),
    "pleaseEnterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите новый пароль",
    ),
    "pleaseEnterNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите новый пароль",
    ),
    "pleaseEnterPaypalAccount": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите аккаунт Paypal",
    ),
    "pleaseEnterReplyContent": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите содержание ответа",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите название скрипта",
    ),
    "pleaseEnterTransferAmount": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите сумму для перевода на баланс",
    ),
    "pleaseEnterTransferAmountHint": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите сумму перевода",
    ),
    "pleaseEnterUsdtWalletAddress": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите адрес USDT кошелька",
    ),
    "pleaseEnterValidAmount": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительную сумму",
    ),
    "pleaseEnterWithdrawalAccount": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите аккаунт для вывода",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите пароль администратора",
    ),
    "pleaseLogin": MessageLookupByLibrary.simpleMessage("Пожалуйста, войдите"),
    "pleaseLogin2": MessageLookupByLibrary.simpleMessage(
      "Сначала войдите в систему",
    ),
    "pleaseSelectWithdrawalMethod": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, выберите способ вывода",
    ),
    "pleaseUploadFile": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, загрузите файл",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, загрузите действительный QR-код",
    ),
    "popupNotification": MessageLookupByLibrary.simpleMessage(
      "Всплывающее уведомление",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Порт"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Введите другой порт",
    ),
    "portTip": m18,
    "preferH3": MessageLookupByLibrary.simpleMessage("Приоритет HTTP3"),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Приоритетное использование HTTP/3 для DOH",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, нажмите клавишу.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
    "pricePerMonth": m19,
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "privacyPolicyInDevelopment": MessageLookupByLibrary.simpleMessage(
      "Страница политики конфиденциальности в разработке",
    ),
    "productInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о продукте",
    ),
    "productName": MessageLookupByLibrary.simpleMessage("Название продукта"),
    "productTraffic": MessageLookupByLibrary.simpleMessage("Трафик продукта"),
    "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Пожалуйста, введите действительный формат интервала времени",
        ),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Пожалуйста, введите интервал времени для автообновления",
        ),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "Профиль был изменен. Хотите отключить автообновление?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите имя профиля",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "ошибка разбора профиля",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный URL профиля",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите URL профиля",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Профили"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Сортировка профилей"),
    "project": MessageLookupByLibrary.simpleMessage("Проект"),
    "providers": MessageLookupByLibrary.simpleMessage("Провайдеры"),
    "proxies": MessageLookupByLibrary.simpleMessage("Прокси"),
    "proxiesSetting": MessageLookupByLibrary.simpleMessage("Настройка прокси"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Группа прокси"),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage(
      "Прокси-сервер имен",
    ),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Домен для разрешения прокси-узлов",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("Порт прокси"),
    "proxyPortDesc": MessageLookupByLibrary.simpleMessage(
      "Установить порт прослушивания Clash",
    ),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Провайдеры прокси"),
    "publishedAt": m20,
    "purchase": MessageLookupByLibrary.simpleMessage("Купить"),
    "purchasePlan": MessageLookupByLibrary.simpleMessage("Купить тариф"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чисто черный режим"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканируйте QR-код для получения профиля",
    ),
    "quarterlyPlan": MessageLookupByLibrary.simpleMessage("Ежеквартально"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радужные"),
    "recovery": MessageLookupByLibrary.simpleMessage("Восстановление"),
    "recoveryAll": MessageLookupByLibrary.simpleMessage(
      "Восстановить все данные",
    ),
    "recoveryProfiles": MessageLookupByLibrary.simpleMessage(
      "Только восстановление профилей",
    ),
    "recoveryStrategy": MessageLookupByLibrary.simpleMessage(
      "Стратегия восстановления",
    ),
    "recoveryStrategy_compatible": MessageLookupByLibrary.simpleMessage(
      "Совместимый",
    ),
    "recoveryStrategy_override": MessageLookupByLibrary.simpleMessage(
      "Переопределение",
    ),
    "recoverySuccess": MessageLookupByLibrary.simpleMessage(
      "Восстановление успешно",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir-порт"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторить"),
    "refresh": MessageLookupByLibrary.simpleMessage("Обновить"),
    "regExp": MessageLookupByLibrary.simpleMessage("Регулярное выражение"),
    "register": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "registerButton": MessageLookupByLibrary.simpleMessage(
      "Зарегистрироваться",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("Ошибка регистрации"),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка регистрации",
    ),
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "Регистрация успешна",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage(
      "Регистрация аккаунта",
    ),
    "registeredUsersCount": MessageLookupByLibrary.simpleMessage(
      "Количество зарегистрированных пользователей",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Удаленный"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование локальных данных на WebDAV",
    ),
    "remoteRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановление данных с WebDAV",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Удалить"),
    "rename": MessageLookupByLibrary.simpleMessage("Переименовать"),
    "reply": MessageLookupByLibrary.simpleMessage("Ответить"),
    "replyTicketFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось ответить на тикет",
    ),
    "requests": MessageLookupByLibrary.simpleMessage("Запросы"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр последних записей запросов",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Сброс"),
    "resetInfo": m21,
    "resetPassword": MessageLookupByLibrary.simpleMessage("Сбросить пароль"),
    "resetPasswordButton": MessageLookupByLibrary.simpleMessage(
      "Подтвердить сброс",
    ),
    "resetPasswordError": MessageLookupByLibrary.simpleMessage("Ошибка сброса"),
    "resetPasswordFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка сброса пароля",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Письмо для сброса успешно отправлено",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage(
      "Убедитесь, что хотите сбросить",
    ),
    "resetTraffic": MessageLookupByLibrary.simpleMessage("Сбросить трафик"),
    "resources": MessageLookupByLibrary.simpleMessage("Ресурсы"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Информация, связанная с внешними ресурсами",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Соблюдение правил"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS-соединение следует правилам, необходимо настроить proxy-server-nameserver",
    ),
    "responseFormatError": MessageLookupByLibrary.simpleMessage(
      "Ошибка формата ответа",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "retryBtnText": MessageLookupByLibrary.simpleMessage("Повторить"),
    "retryButton": MessageLookupByLibrary.simpleMessage("Повторить"),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Адрес маршрутизации"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Настройка адреса прослушивания маршрутизации",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Режим маршрутизации"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Обход частных адресов маршрутизации",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage(
      "Использовать конфигурацию",
    ),
    "ru": MessageLookupByLibrary.simpleMessage("Русский"),
    "rule": MessageLookupByLibrary.simpleMessage("Правило"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Название правила"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Провайдеры правил"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель правила"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Сохранить изменения?"),
    "saveTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите сохранить?",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Скрипт"),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "seconds": MessageLookupByLibrary.simpleMessage("Секунд"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Выбрать все"),
    "selectNode": MessageLookupByLibrary.simpleMessage("Выбрать узел"),
    "selectPaymentMethod": MessageLookupByLibrary.simpleMessage(
      "Выберите способ оплаты",
    ),
    "selectPlan": MessageLookupByLibrary.simpleMessage("Выбрать"),
    "selected": MessageLookupByLibrary.simpleMessage("Выбрано"),
    "selectedCountTitle": m22,
    "send": MessageLookupByLibrary.simpleMessage("Отправить"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Отправить код"),
    "sendCodeError": MessageLookupByLibrary.simpleMessage(
      "Ошибка отправки кода",
    ),
    "sendCodeSuccess": MessageLookupByLibrary.simpleMessage(
      "Код успешно отправлен",
    ),
    "sendVerificationCodeFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка отправки кода подтверждения",
    ),
    "serverError": m23,
    "setDirectConnection": MessageLookupByLibrary.simpleMessage(
      "Установить прямое соединение",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "settingsFailed": MessageLookupByLibrary.simpleMessage(
      "Настройки не удались",
    ),
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "shrink": MessageLookupByLibrary.simpleMessage("Сжать"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Тихий запуск"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запуск в фоновом режиме",
    ),
    "size": MessageLookupByLibrary.simpleMessage("Размер"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socks-порт"),
    "sort": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "source": MessageLookupByLibrary.simpleMessage("Источник"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("Исходный IP"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Режим стека"),
    "standard": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "start": MessageLookupByLibrary.simpleMessage("Старт"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Запуск VPN..."),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "Системный DNS будет использоваться при выключении",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Стоп"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Остановка VPN..."),
    "style": MessageLookupByLibrary.simpleMessage("Стиль"),
    "subRule": MessageLookupByLibrary.simpleMessage("Подправило"),
    "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
    "submitBtnText": MessageLookupByLibrary.simpleMessage("Отправить"),
    "subscribe": MessageLookupByLibrary.simpleMessage("Подписка"),
    "sync": MessageLookupByLibrary.simpleMessage("Синхронизация"),
    "system": MessageLookupByLibrary.simpleMessage("Система"),
    "systemApp": MessageLookupByLibrary.simpleMessage("Системное приложение"),
    "systemFont": MessageLookupByLibrary.simpleMessage("Системный шрифт"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Прикрепить HTTP-прокси к VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Вкладка"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Анимация вкладок"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Действительно только в мобильном виде",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP параллелизм"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Включение позволит использовать параллелизм TCP",
    ),
    "telegram": MessageLookupByLibrary.simpleMessage("Телеграм"),
    "telegramGroup": MessageLookupByLibrary.simpleMessage("Телеграм группа"),
    "testUrl": MessageLookupByLibrary.simpleMessage("Тест URL"),
    "textScale": MessageLookupByLibrary.simpleMessage("Масштабирование текста"),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Цвет темы"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Установить темный режим, настроить цвет",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Режим темы"),
    "threeColumns": MessageLookupByLibrary.simpleMessage("Три столбца"),
    "threeYearlyPlan": MessageLookupByLibrary.simpleMessage("3 года"),
    "ticketCloseFailed": m24,
    "ticketClosedSuccess": MessageLookupByLibrary.simpleMessage(
      "Тикет успешно закрыт",
    ),
    "ticketDetails": MessageLookupByLibrary.simpleMessage("Детали тикета"),
    "ticketLevel": MessageLookupByLibrary.simpleMessage("Приоритет"),
    "ticketLevelHigh": MessageLookupByLibrary.simpleMessage("Высокий"),
    "ticketLevelLow": MessageLookupByLibrary.simpleMessage("Низкий"),
    "ticketLevelMedium": MessageLookupByLibrary.simpleMessage("Средний"),
    "ticketNotFound": MessageLookupByLibrary.simpleMessage("Тикет не найден"),
    "ticketPriorityHigh": MessageLookupByLibrary.simpleMessage(
      "Высокий приоритет",
    ),
    "ticketPriorityLow": MessageLookupByLibrary.simpleMessage(
      "Низкий приоритет",
    ),
    "ticketPriorityMedium": MessageLookupByLibrary.simpleMessage(
      "Средний приоритет",
    ),
    "ticketPriorityUrgent": MessageLookupByLibrary.simpleMessage("Срочно"),
    "ticketStatusClosed": MessageLookupByLibrary.simpleMessage("Закрыт"),
    "ticketStatusOpen": MessageLookupByLibrary.simpleMessage("Обрабатывается"),
    "ticketSubject": MessageLookupByLibrary.simpleMessage("Тема"),
    "tight": MessageLookupByLibrary.simpleMessage("Плотный"),
    "time": MessageLookupByLibrary.simpleMessage("Время"),
    "tip": MessageLookupByLibrary.simpleMessage("подсказка"),
    "toggle": MessageLookupByLibrary.simpleMessage("Переключить"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("Тональный акцент"),
    "tools": MessageLookupByLibrary.simpleMessage("Инструменты"),
    "tools2": MessageLookupByLibrary.simpleMessage("Инструменты"),
    "toolsEntryHidden": MessageLookupByLibrary.simpleMessage(
      "Вход в инструменты скрыт",
    ),
    "toolsEntryShown": MessageLookupByLibrary.simpleMessage(
      "Вход в инструменты показан",
    ),
    "total": MessageLookupByLibrary.simpleMessage("Итого"),
    "totalCommissionEarned": MessageLookupByLibrary.simpleMessage(
      "Общая заработанная комиссия",
    ),
    "totalOrdersCount": m25,
    "totalTicketsCount": m26,
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxy-порт"),
    "trafficEmailReminder": MessageLookupByLibrary.simpleMessage(
      "Напоминание о трафике по email",
    ),
    "trafficEmailReminderDisabled": MessageLookupByLibrary.simpleMessage(
      "Напоминание о трафике по email отключено",
    ),
    "trafficEmailReminderEnabled": MessageLookupByLibrary.simpleMessage(
      "Напоминание о трафике по email включено",
    ),
    "trafficStats": m27,
    "trafficUsage": MessageLookupByLibrary.simpleMessage(
      "Использование трафика",
    ),
    "transfer": MessageLookupByLibrary.simpleMessage("Перевод"),
    "transferAllAmount": MessageLookupByLibrary.simpleMessage("Перевести все"),
    "transferAmount": MessageLookupByLibrary.simpleMessage("Сумма перевода"),
    "transferAmountCannotExceedCommissionBalance":
        MessageLookupByLibrary.simpleMessage(
          "Сумма перевода не может превышать баланс комиссии",
        ),
    "transferAmountExceedsBalance": MessageLookupByLibrary.simpleMessage(
      "Сумма перевода не может превышать баланс комиссии",
    ),
    "transferAmountValidError": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительную сумму",
    ),
    "transferCommissionToBalance": MessageLookupByLibrary.simpleMessage(
      "Перевод комиссии на баланс",
    ),
    "transferFailedMsg": MessageLookupByLibrary.simpleMessage(
      "Перевод не удался",
    ),
    "transferredBalanceOnlyForAppConsumption": m28,
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "действительно только в режиме администратора",
    ),
    "twoColumns": MessageLookupByLibrary.simpleMessage("Два столбца"),
    "twoYearlyPlan": MessageLookupByLibrary.simpleMessage("2 года"),
    "typePeriod": MessageLookupByLibrary.simpleMessage("Тип/Период"),
    "ua": MessageLookupByLibrary.simpleMessage("Пользовательский агент"),
    "unableToUpdateCurrentProfileDesc": MessageLookupByLibrary.simpleMessage(
      "невозможно обновить текущий профиль",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Отменить"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage(
      "Унифицированная задержка",
    ),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Убрать дополнительные задержки, такие как рукопожатие",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Неизвестно"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Без имени"),
    "unpaidOrderTip": MessageLookupByLibrary.simpleMessage(
      "У вас есть неоплаченные заказы",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Обновить"),
    "updateSuccess": MessageLookupByLibrary.simpleMessage(
      "Обновление подписки успешно",
    ),
    "updateUserInfoFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось обновить информацию о пользователе, попробуйте позже",
    ),
    "upload": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Получить профиль через URL",
    ),
    "urlTip": m29,
    "usdtWalletAddress": MessageLookupByLibrary.simpleMessage(
      "Адрес USDT кошелька",
    ),
    "useHosts": MessageLookupByLibrary.simpleMessage("Использовать hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Использовать системные hosts",
    ),
    "userAgreement": MessageLookupByLibrary.simpleMessage(
      "Пользовательское соглашение",
    ),
    "userAgreementInDevelopment": MessageLookupByLibrary.simpleMessage(
      "Страница пользовательского соглашения в разработке",
    ),
    "userCenter": MessageLookupByLibrary.simpleMessage("Личный кабинет"),
    "userInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о пользователе",
    ),
    "userStats": MessageLookupByLibrary.simpleMessage(
      "Статистика пользователя",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Значение"),
    "verify": MessageLookupByLibrary.simpleMessage("Проверить"),
    "verifyCouponFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось проверить купон",
    ),
    "verifyingCoupon": MessageLookupByLibrary.simpleMessage(
      "Проверка купона...",
    ),
    "versionInfo": MessageLookupByLibrary.simpleMessage("Информация о версии"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Яркие"),
    "view": MessageLookupByLibrary.simpleMessage("Просмотр"),
    "viewDetails": MessageLookupByLibrary.simpleMessage("Просмотр деталей"),
    "viewTicketDetails": MessageLookupByLibrary.simpleMessage(
      "Просмотр деталей",
    ),
    "vpn": MessageLookupByLibrary.simpleMessage("Виртуальная частная сеть"),
    "vpnDesc": MessageLookupByLibrary.simpleMessage(
      "Изменение настроек, связанных с VPN",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматически направляет весь системный трафик через VpnService",
    ),
    "vpnSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Прикрепить HTTP-прокси к VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Изменения вступят в силу после перезапуска VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "Конфигурация WebDAV",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage(
      "Режим белого списка",
    ),
    "withdrawApplyFailed": m30,
    "withdrawApplySuccess": MessageLookupByLibrary.simpleMessage(
      "Заявка на вывод подана успешно",
    ),
    "withdrawalAccount": MessageLookupByLibrary.simpleMessage(
      "Аккаунт для вывода",
    ),
    "withdrawalAccountLabel": MessageLookupByLibrary.simpleMessage(
      "Аккаунт для вывода",
    ),
    "withdrawalApplication": MessageLookupByLibrary.simpleMessage(
      "Заявка на вывод средств",
    ),
    "withdrawalApplicationFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка заявки на вывод средств",
    ),
    "withdrawalApplicationSubmitted": MessageLookupByLibrary.simpleMessage(
      "Заявка на вывод отправлена, ожидайте рассмотрения",
    ),
    "withdrawalFunctionClosed": MessageLookupByLibrary.simpleMessage(
      "Функция вывода закрыта",
    ),
    "withdrawalFunctionDisabled": MessageLookupByLibrary.simpleMessage(
      "Функция вывода отключена",
    ),
    "withdrawalInstructions": MessageLookupByLibrary.simpleMessage(
      "Инструкции по выводу",
    ),
    "withdrawalInstructionsText": MessageLookupByLibrary.simpleMessage(
      "• Заявки на вывод требуют ручного рассмотрения после подачи\n• Средства будут переведены на ваш аккаунт после одобрения\n• Убедитесь, что информация об аккаунте для вывода точна",
    ),
    "withdrawalMethod": MessageLookupByLibrary.simpleMessage("Способ вывода"),
    "withdrawalMethodLabel": MessageLookupByLibrary.simpleMessage(
      "Способ вывода",
    ),
    "withdrawalRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка заявки на вывод",
    ),
    "withdrawalRequestSubmitted": MessageLookupByLibrary.simpleMessage(
      "Заявка на вывод отправлена, ожидайте рассмотрения",
    ),
    "withdrawalSystemTemporarilyClosed": MessageLookupByLibrary.simpleMessage(
      "Система временно закрыла функцию вывода",
    ),
    "yearlyPlan": MessageLookupByLibrary.simpleMessage("Годовой"),
    "years": MessageLookupByLibrary.simpleMessage("Лет"),
    "zeroCommissionBalanceTransfer": MessageLookupByLibrary.simpleMessage(
      "Баланс комиссии равен нулю, невозможно перевести",
    ),
    "zeroCommissionBalanceWithdraw": MessageLookupByLibrary.simpleMessage(
      "Баланс комиссии равен нулю, невозможно вывести",
    ),
    "zh_CN": MessageLookupByLibrary.simpleMessage("Упрощенный китайский"),
    "zoom": MessageLookupByLibrary.simpleMessage("Масштаб"),
  };
}
