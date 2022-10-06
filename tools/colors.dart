import 'package:flutter/material.dart';

const sonstiges = Color.fromRGBO(128, 64, 0, 1);
const auslieferung = Color.fromRGBO(0, 0, 0, 1);
const mietwagen = Color.fromRGBO(255, 0, 0, 1);
const urlaub = Color.fromRGBO(139, 195, 74, 1);
const schulung = Color.fromRGBO(192, 192, 192, 1);
const feiertage = Color.fromRGBO(255, 128, 0, 1);
const werkstatt = Color.fromRGBO(151, 151, 255, 1);
const geburtstage = Color.fromRGBO(255, 255, 0, 1);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  print('sonstiges: ${sonstiges.value}'); // 4286595072
  print('auslieferung: ${auslieferung.value}'); // 4278190080
  print('mietwagen: ${mietwagen.value}'); // 4294901760
  print('urlaub: ${urlaub.value}'); // 4287349578
  print('schulung: ${schulung.value}'); // 4290822336
  print('feiertage: ${feiertage.value}'); // 4294934528
  print('werkstatt: ${werkstatt.value}'); // 4288124927
  print('geburtstage: ${geburtstage.value}'); // 4294967040

  runApp(const MaterialApp(home: Scaffold(body: Text('test'))));
}

int _convertColorTHex(Color color) => int.parse('${color.value}', radix: 16);
