import '/widgets/components/button4/button4_widget.dart';
import '/widgets/components/trust_bullet3/trust_bullet3_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/complete_booking_dialog/complete_booking_dialog_widget.dart' show CompleteBookingDialogWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CompleteBookingDialogModel
    extends AppModel<CompleteBookingDialogWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TrustBullet.
  late TrustBullet3Model trustBulletModel1;
  // Model for TrustBullet.
  late TrustBullet3Model trustBulletModel2;
  // Model for TrustBullet.
  late TrustBullet3Model trustBulletModel3;
  // Model for Button.
  late Button4Model buttonModel1;
  // Model for Button.
  late Button4Model buttonModel2;

  @override
  void initState(BuildContext context) {
    trustBulletModel1 = createModel(context, () => TrustBullet3Model());
    trustBulletModel2 = createModel(context, () => TrustBullet3Model());
    trustBulletModel3 = createModel(context, () => TrustBullet3Model());
    buttonModel1 = createModel(context, () => Button4Model());
    buttonModel2 = createModel(context, () => Button4Model());
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
