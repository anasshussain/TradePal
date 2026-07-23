import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/utils/enums/enums.dart';
import '/repositories/supabase/supabase.dart';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/utils/custom_code/actions/index.dart'; // Imports other custom actions
import '/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future showToast(
  BuildContext context,
  String message,
  int? duration,
) async {
  // Add your function code here!
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 80,
      left: MediaQuery.of(context).size.width / 2 - 100,
      width: 200,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  await Future.delayed(Duration(seconds: duration ?? 2));
  overlayEntry.remove();
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
