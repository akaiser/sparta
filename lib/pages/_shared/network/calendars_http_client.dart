import 'package:sparta/pages/_shared/models/calendars_json.dart';
import 'package:sparta/pages/_shared/network/_http_client.dart';

//final response = await client.get('$_host/$_path');

class CalendarsHttpClient {
  const CalendarsHttpClient(this.client);

  final HttpClient client;

  Future<List<CalendarJson>> fetchCalendars() async {
    // TODO(albert): remove
    await Future<void>.delayed(const Duration(seconds: 1));
    return CalendarsJson.fromJson(_calendars).calendars;
  }
}

Map<String, dynamic> get _calendars => {
      'calendars': [
        _calendar(0, 'Sonstiges', '804000'),
        _calendar(1, 'Auslieferung', '000000'),
        _calendar(2, 'Mietwagen', 'ff0000'),
        _calendar(3, 'Urlaub', '8bc34a'),
        _calendar(4, 'Feiertage', 'ff8000'),
        _calendar(5, 'Werkstatt', '9797ff'),
        _calendar(6, 'Geburtstage', 'ffff00'),
      ]
    };

Map<String, dynamic> _calendar(int id, String title, String color) => {
      'id': '$id',
      'title': title,
      'color': color,
    };
