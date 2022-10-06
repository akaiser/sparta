import 'package:sparta/_epics.dart';

abstract class ContinuationAction {
  dynamic get next;
}

TypedAppEpic<ContinuationAction> continuationEpic() =>
    TypedAppEpic<ContinuationAction>(
      (actions, _) => actions
          .where((action) => action.next != null)
          .map((action) => action.next),
    );
