import 'package:flutter/foundation.dart';
import 'package:my_trade_pal/auth/supabase_auth/auth_util.dart';
import 'package:my_trade_pal/repositories/supabase/supabase.dart';

Future<String?> get currentUserStripeCustomerId async {
  final userId = currentUserUid;

  if (userId.isEmpty) {
    return null;
  }
  debugPrint("current User Stripe Customer Id execution started ");
  final data = await SupaFlow.client
      .from('users')
      .select('stripe_customer_id')
      .eq('id', userId)
      .maybeSingle();
  debugPrint(
      "current User Stripe Customer Id execution end and customer id is ${data?['stripe_customer_id']}");
  return data?['stripe_customer_id'];
}
