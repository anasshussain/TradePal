import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/widgets/components/choose_path_component/choose_path_component_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/auth/choose_path/choose_path_widget.dart' show ChoosePathWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChoosePathModel extends AppModel<ChoosePathWidget> {
  ///  Local state fields for this page.

  UserRole? selectedRole = UserRole.customer;

  ///  State fields for stateful widgets in this page.

  // Model for choose_path_component component.
  late ChoosePathComponentModel choosePathComponentModel1;
  // Model for choose_path_component component.
  late ChoosePathComponentModel choosePathComponentModel2;

  @override
  void initState(BuildContext context) {
    choosePathComponentModel1 =
        createModel(context, () => ChoosePathComponentModel());
    choosePathComponentModel2 =
        createModel(context, () => ChoosePathComponentModel());
  }

  @override
  void dispose() {
    choosePathComponentModel1.dispose();
    choosePathComponentModel2.dispose();
  }
}
