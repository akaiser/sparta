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

class EventsHttpClient {
  const EventsHttpClient(this.client);

  final HttpClient client;

  Future<List<EventsJson>> fetchEvents() async {
    await Future.delayed(const Duration(seconds: 1)); // TODO remove

    //final response =  client.get('http://sgs-automobile.de/raspi/index.php');
    //final response = client.get('http://localhost/own/sgs-automobile/raspi/index.php');

    final from = DateTime(2022, 4, 4);
    final response = {
      'events': List.generate(
        14,
        (index) => {
          'day': from.add(Duration(days: index)).toString(),
          'items': List.generate(
            Random().nextInt(25),
            (index) => {'id': index},
            growable: false,
          ),
        },
        growable: false,
      )
    };

    return safeMap(response['events'], (item) => EventsJson.fromJson(item));
  }
}
