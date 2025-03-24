import 'package:timeago/timeago.dart' as timeago;

class ShortViMessages implements timeago.LookupMessages {
  @override String prefixAgo() => '';
  @override String prefixFromNow() => '';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => 'tới';
  @override String lessThanOneMinute(int seconds) => 'Vừa xong';
  @override String aboutAMinute(int minutes) => '1p';
  @override String minutes(int minutes) => '${minutes}p';
  @override String aboutAnHour(int minutes) => '1h';
  @override String hours(int hours) => '${hours}h';
  @override String aDay(int hours) => '1d';
  @override String days(int days) => '${days}d';
  @override String aboutAMonth(int days) => '1 tháng';
  @override String months(int months) => '${months} tháng';
  @override String aboutAYear(int year) => '1 năm';
  @override String years(int years) => '${years} năm';
  @override String wordSeparator() => ' ';
}
