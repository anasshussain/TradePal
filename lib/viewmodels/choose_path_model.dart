import '/widgets/components/choose_path_component/choose_path_component_widget.dart';
import '/utils/util.dart';
import '/auth/choose_path/choose_path_widget.dart' show ChoosePathWidget;
import 'package:flutter/material.dart';

class ChoosePathModel extends AppModel<ChoosePathWidget> {
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
