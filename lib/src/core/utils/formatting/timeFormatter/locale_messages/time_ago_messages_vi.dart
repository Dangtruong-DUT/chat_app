import 'package:timeago/timeago.dart' as timeago;

class TimeAgoMessagesVi implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'vừa xong';

  @override
  String aboutAMinute(int minutes) => '$minutes phút';

  @override
  String minutes(int minutes) => '$minutes phút';

  @override
  String aboutAnHour(int minutes) => '$minutes phút';

  @override
  String hours(int hours) => '$hours giờ';

  @override
  String aDay(int hours) => '$hours giờ';

  @override
  String days(int days) => '$days ngày';

  @override
  String aboutAMonth(int days) => '$days ngày';

  @override
  String months(int months) => '$months tháng';

  @override
  String aboutAYear(int year) => '$year năm';

  @override
  String years(int years) => '$years năm';

  @override
  String wordSeparator() => ' ';
}
