enum NetworkState { idle, loading, success, error }

extension TimeAgo on String? {
  String get calculate {
    String? date = this;
    if (date == null) {
      return 'no date';
    }

    DateTime formattedDate;
    try {
      formattedDate = DateTime.parse(date.split('T')[0]);
    } on FormatException {
      return date;
    }

    Duration diff = DateTime.now().difference(formattedDate);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    return "today";
  }
}
