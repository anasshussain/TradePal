import '/widgets/components/action_tile3/action_tile3_widget.dart';
import '/widgets/components/cancel_button/cancel_button_widget.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/widgets/components/bottom_sheet_attachment_component/bottom_sheet_attachment_component_widget.dart'
    show BottomSheetAttachmentComponentWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BottomSheetAttachmentComponentModel
    extends AppModel<BottomSheetAttachmentComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ActionTile.
  late ActionTile3Model actionTileModel1;
  // Model for ActionTile.
  late ActionTile3Model actionTileModel2;
  // Model for ActionTile.
  late ActionTile3Model actionTileModel3;
  // Model for ActionTile.
  late ActionTile3Model actionTileModel4;
  // Model for ActionTile.
  late ActionTile3Model actionTileModel5;
  // Model for ActionTile.
  late ActionTile3Model actionTileModel6;
  // Model for Button.
  late CancelButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    actionTileModel1 = createModel(context, () => ActionTile3Model());
    actionTileModel2 = createModel(context, () => ActionTile3Model());
    actionTileModel3 = createModel(context, () => ActionTile3Model());
    actionTileModel4 = createModel(context, () => ActionTile3Model());
    actionTileModel5 = createModel(context, () => ActionTile3Model());
    actionTileModel6 = createModel(context, () => ActionTile3Model());
    buttonModel = createModel(context, () => CancelButtonModel());
  }

  @override
  void dispose() {
    actionTileModel1.dispose();
    actionTileModel2.dispose();
    actionTileModel3.dispose();
    actionTileModel4.dispose();
    actionTileModel5.dispose();
    actionTileModel6.dispose();
    buttonModel.dispose();
  }
}
