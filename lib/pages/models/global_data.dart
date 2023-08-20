import 'package:flutter/material.dart';

navigatorPush({
  required BuildContext context,
  required String name,
  required Widget widget,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar(
    reason: SnackBarClosedReason.dismiss,
  );
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: name),
    ),
  );
}

void showScaffoldMessage({
  String message = "Oops! Something went wrong.",
  required BuildContext context,
  Color color = Colors.red,
  SnackBarBehavior behavior = SnackBarBehavior.fixed,
}) {
  var messenger = ScaffoldMessenger.of(context);

  messenger.removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
  messenger.showSnackBar(SnackBar(
    backgroundColor: color,
    behavior: behavior,
    content: Text(
      message,
      style: const TextStyle(fontFamily: 'ValeraRound'),
    ),
  ));
}
