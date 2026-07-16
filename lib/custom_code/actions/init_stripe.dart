import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/theme/app_theme.dart';
import '/core/util.dart';
import 'index.dart'; // Imports other custom actions
import '/core/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> initStripe() async {
  Stripe.publishableKey =
      "pk_test_51TYBAgENSWhGkvogiEwPPVPrcBUB8BLQVq9RWQ79vig1JCGEF99is9Hyx473R0Ivggiv8R2KKAUN1zYvZaDaeT6f00jWidjcn5";

  debugPrint("Stripe Initiazed");
  await Stripe.instance.applySettings();
}
