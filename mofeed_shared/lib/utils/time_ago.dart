class TimeAgo {
  final DateTime _time;
  final String _languageCode;

  const TimeAgo(this._time, this._languageCode);

  String get timeAgo {
    final now = DateTime.now();
    final duration = now.difference(_time);
    if (duration.inSeconds < 60) {
      return _humanReadbale['moment']![_languageCode]!;
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} ${_humanReadbale['minutes']![_languageCode]!}';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} ${_humanReadbale['hours']![_languageCode]!}';
    } else if (duration.inDays < 30) {
      return '${duration.inDays} ${_humanReadbale['days']![_languageCode]!}';
    } else if (duration.inDays < 365) {
      return '${duration.inDays ~/ 30} ${_humanReadbale['month']![_languageCode]!}';
    } else {
      return '${duration.inDays ~/ 365} ${_humanReadbale['year']![_languageCode]!}';
    }
  }

  Map<String, Map<String, String>> get _humanReadbale {
    return {
      'moment': {'ar': 'لسة حالا', 'en': 'Just now'},
      'minutes': {'ar': 'دقائق', 'en': 'm'},
      'hours': {'ar': 'ساعات', 'en': 'h'},
      'days': {'ar': 'ايام', 'en': 'd'},
      'month': {'ar': 'شهور', 'en': 'mon'},
      'year': {'ar': 'سنوات', 'en': ' y'},
    };
  }
}
