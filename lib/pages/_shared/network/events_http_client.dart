import 'dart:math';

import 'package:sparta/pages/_shared/models/event_json.dart';
import 'package:sparta/pages/_shared/network/_http_client.dart';
import 'package:sparta/pages/_shared/util/safe_map.dart';

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

class EventsHttpClient extends HttpClient {
  Future<List<EventsJson>> fetchEvents() async {
    await Future.delayed(const Duration(seconds: 1)); // TODO remove

    //final response =  get('http://sgs-automobile.de/raspi/index.php');
    //final response = get('http://localhost/own/sgs-automobile/raspi/index.php');

    final response = {
      'events': List.generate(
        14,
        (index) => {
          'day': '2018-10-01',
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
