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

import 'package:flutter_stripe/flutter_stripe.dart';

Future<bool> makePayment(String clientSecret) async {
  if (clientSecret.isEmpty) {
    print('ERROR: clientSecret is empty!');
    return false;
  }

  try {
    print("client secret: $clientSecret");

    // 1️⃣ Initialize Payment Sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'My Trade Pal',
        style: ThemeMode.light,
      ),
    );

    // 2️⃣ Present Payment Sheet
    await Stripe.instance.presentPaymentSheet();

    print('PaymentSheet completed successfully!');
    return true;
  } on StripeException catch (e) {
    print('StripeException: ${e.error.localizedMessage}');
    return false;
  } catch (e, s) {
    print('Other exception: $e');
    print('Stacktrace: $s');
    return false;
  }
}
