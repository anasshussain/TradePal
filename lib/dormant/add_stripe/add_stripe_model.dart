import '/backend/schema/structs/index.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'add_stripe_widget.dart' show AddStripeWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddStripeModel extends AppModel<AddStripeWidget> {
  ///  Local state fields for this component.

  bool payoutsEnabled = true;

  bool isVerificationPending = true;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
