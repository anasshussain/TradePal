import '/components/countinue_booking/countinue_booking_widget.dart';
import '/components/trust_bullet4/trust_bullet4_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'complete_booking_page_widget.dart' show CompleteBookingPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CompleteBookingPageModel
    extends FlutterFlowModel<CompleteBookingPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TrustBullet.
  late TrustBullet4Model trustBulletModel1;
  // Model for TrustBullet.
  late TrustBullet4Model trustBulletModel2;
  // Model for TrustBullet.
  late TrustBullet4Model trustBulletModel3;
  // Model for Button.
  late CountinueBookingModel buttonModel1;
  // Model for Button.
  late CountinueBookingModel buttonModel2;

  @override
  void initState(BuildContext context) {
    trustBulletModel1 = createModel(context, () => TrustBullet4Model());
    trustBulletModel2 = createModel(context, () => TrustBullet4Model());
    trustBulletModel3 = createModel(context, () => TrustBullet4Model());
    buttonModel1 = createModel(context, () => CountinueBookingModel());
    buttonModel2 = createModel(context, () => CountinueBookingModel());
  }

  @override
  void dispose() {
    trustBulletModel1.dispose();
    trustBulletModel2.dispose();
    trustBulletModel3.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
