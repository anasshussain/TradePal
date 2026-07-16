import '/components/action_tile2/action_tile2_widget.dart';
import '/components/button6/button6_widget.dart';
import '/widgets/app_icon_button.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'new_screen4_widget.dart' show NewScreen4Widget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewScreen4Model extends AppModel<NewScreen4Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for ActionTile.
  late ActionTile2Model actionTileModel1;
  // Model for ActionTile.
  late ActionTile2Model actionTileModel2;
  // Model for ActionTile.
  late ActionTile2Model actionTileModel3;
  // Model for ActionTile.
  late ActionTile2Model actionTileModel4;
  // Model for ActionTile.
  late ActionTile2Model actionTileModel5;
  // Model for ActionTile.
  late ActionTile2Model actionTileModel6;
  // Model for Button.
  late Button6Model buttonModel;

  @override
  void initState(BuildContext context) {
    actionTileModel1 = createModel(context, () => ActionTile2Model());
    actionTileModel2 = createModel(context, () => ActionTile2Model());
    actionTileModel3 = createModel(context, () => ActionTile2Model());
    actionTileModel4 = createModel(context, () => ActionTile2Model());
    actionTileModel5 = createModel(context, () => ActionTile2Model());
    actionTileModel6 = createModel(context, () => ActionTile2Model());
    buttonModel = createModel(context, () => Button6Model());
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
