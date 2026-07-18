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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> initStripe() async {
  Stripe.publishableKey =
      "pk_test_51TYBAgENSWhGkvogiEwPPVPrcBUB8BLQVq9RWQ79vig1JCGEF99is9Hyx473R0Ivggiv8R2KKAUN1zYvZaDaeT6f00jWidjcn5";

  debugPrint("Stripe Initiazed");
  await Stripe.instance.applySettings();
}
