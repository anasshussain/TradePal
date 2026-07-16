import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/text_button/text_button_widget.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/core/custom_functions.dart' as functions;
import '/index.dart';
import 'job_item_widget.dart' show JobItemWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JobItemModel extends AppModel<JobItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for textButton component.
  late TextButtonModel textButtonModel;

  @override
  void initState(BuildContext context) {
    textButtonModel = createModel(context, () => TextButtonModel());
  }

  @override
  void dispose() {
    textButtonModel.dispose();
  }
}
