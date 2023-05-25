import 'package:intl/intl.dart';

String formatDateOrEmptyString(DateTime? dateTime) {
  return dateTime != null
      ? DateFormat('dd MMMM yyyy').format(
          dateTime,
        )
      : '';
}

String formatDateOrNow(DateTime? dateTime) {
  return DateFormat('dd.MM.yyyy').format(
    dateTime ?? DateTime.now(),
  );
}
