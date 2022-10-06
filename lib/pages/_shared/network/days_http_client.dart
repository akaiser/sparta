import 'dart:math';

import 'package:sparta/pages/_shared/models/days_json.dart';
import 'package:sparta/pages/_shared/network/_http_client.dart';

//final response = await client.get('$_host/$_path?from=${from.toCommonIsoDate}&to=${to.toCommonIsoDate}');

class DaysHttpClient {
  const DaysHttpClient(this.client);

  final HttpClient client;

  Future<List<DayJson>> fetchDays({
    required DateTime from,
    required DateTime to,
  }) async {
    // TODO(albert): remove
    await Future<void>.delayed(const Duration(seconds: 1));
    return DaysJson.fromJson(_days(from, to)).days;
  }
}

Map<String, dynamic> _days(DateTime from, DateTime to) {
  final random = Random();
  final diffInDays = to.difference(from).inDays;
  return {
    'days': List.generate(
      diffInDays + 1,
      (i) => _day(from.add(Duration(days: i)), random),
    ),
  };
}

Map<String, dynamic> _day(DateTime day, Random random) => {
      'date': '$day',
      'day_events': List.generate(random.nextInt(25), (_) => _dayEvent(random)),
    };

Map<String, dynamic> _dayEvent(Random random) => {
      'id': '${random.nextInt(1000)}',
      'calender_id': (random.nextInt(10) > 2) ? '5' : '${random.nextInt(7)}',
      'category_ids': <String>[
        if (random.nextInt(10) > 7) '${random.nextInt(2)}',
        if (random.nextInt(10) > 8) '${random.nextInt(2)}',
      ],
    };
