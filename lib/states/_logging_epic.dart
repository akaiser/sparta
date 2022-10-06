import 'dart:developer' show log;

import 'package:sparta/_environment.dart';
import 'package:sparta/_epics.dart';

TypedAppEpic<dynamic> loggingEpic() => TypedAppEpic<dynamic>(
      (actions, _) => actions
          .where((_) => !isReleaseMode)
          .map((action) => log('$action', name: 'redux'))
          .where((_) => false),
    );
