import 'package:chat_app/src/core/i18n/app_locale.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'locale_messages/time_ago_messages_en.dart';
import 'locale_messages/time_ago_messages_vi.dart';

const defaultLocale = AppLocale.en;
const _vietnameseLocale = AppLocale.vi;
const _supportedLocales = <String>{defaultLocale, _vietnameseLocale};

void initCustomTimeMessages() {
  timeago.setLocaleMessages(defaultLocale, TimeAgoMessagesEn());
  timeago.setLocaleMessages(_vietnameseLocale, TimeAgoMessagesVi());
  timeago.setDefaultLocale(defaultLocale);
}

String formatTimeAgo({
  required DateTime dateTime,
  String locale = defaultLocale,
}) {
  final normalizedLocale = _supportedLocales.contains(locale)
      ? locale
      : defaultLocale;
  return timeago.format(dateTime, locale: normalizedLocale);
}
