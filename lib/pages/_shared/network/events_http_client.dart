import 'dart:math';

import 'package:sparta/pages/_shared/models/event_json.dart';
import 'package:sparta/pages/_shared/network/_http_client.dart';
import 'package:sparta/pages/_shared/util/safe_map.dart';

// api/events
/*
final _example = {
  'events': [
    {
      'day': '2018-10-01',
      'items': [
        {'id': 1},
        {'id': 2}
      ]
    },
    {
      // EventsJson
      'day': '2018-10-02',
      'items': [
        {'id': 3}, // EventJson
        {'id': 4}
      ]
    }
  ]
};
*/

//const _host = 'http://localhost';
//const _host = 'http://sgs-automobile.de';
//const _path = 'raspi/index.php';

class EventsHttpClient {
  const EventsHttpClient(this.client);

  final HttpClient client;

  Future<List<EventsJson>> fetchEvents({
    required DateTime from,
    required DateTime to,
  }) async {
    //print('###############');
    //print('from: ${from.toCommonIsoDate}');
    //print('to: ${to.toCommonIsoDate}');
    //print('###############');
    // TODO(albert): remove
    await Future<void>.delayed(const Duration(seconds: 1));

    //final response = await client.get(
    //  '$_host/$_path?from=${from.toCommonIsoDate}&to=${to.toCommonIsoDate}',
    //);

    return safeMap(_dummyEvents(from, to), EventsJson.fromJson);
  }

  Iterable<Map<String, dynamic>> _dummyEvents(
    DateTime from,
    DateTime to,
  ) sync* {
    final diffInDays = to.difference(from).inDays;
    for (var i = 0; i <= diffInDays; i++) {
      final day = from.add(Duration(days: i));
      yield _dummyDay(day);
    }
  }

  Map<String, dynamic> _dummyDay(DateTime day) {
    final random = Random();
    return <String, dynamic>{
      'day': '$day',
      'items': List.generate(
        random.nextInt(25),
        (index) => {'id': random.nextInt(1000)},
      ),
    };
  }
}
