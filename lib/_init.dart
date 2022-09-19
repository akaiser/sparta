import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sparta/_settings.dart';
import 'package:sparta/_web/_shared.dart';

class Init {
  Init._();

  static Future<void> init() {
    _initLicenses();
    return Future.wait([
      Settings.init(),
      _initWeb(),
    ]);
  }

  static void _initLicenses() {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
  }

  static Future<void> _initWeb() async => preventDefaults();
}
