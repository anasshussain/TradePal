import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/settings_component/settings_component_widget.dart';
import '/widgets/components/tp_navbar/tp_navbar_widget.dart';
import '/utils/util.dart';
import '/core/form_field_controller.dart';
import '/core/routes/index.dart';
import '/trader_screens/trader_profile/trader_profile_widget.dart' show TraderProfileWidget;
import 'package:flutter/material.dart';

class TraderProfileModel extends AppModel<TraderProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Model for settings_component component.
  late SettingsComponentModel settingsComponentModel1;
  // Model for settings_component component.
  late SettingsComponentModel settingsComponentModel2;
  // Model for settings_component component.
  late SettingsComponentModel settingsComponentModel3;
  // Model for settings_component component.
  late SettingsComponentModel settingsComponentModel4;
  // Model for settings_component component.
  late SettingsComponentModel settingsComponentModel5;
  // Model for settings_component component.
  late SettingsComponentModel settingsComponentModel6;
  // Model for tp_navbar component.
  late TpNavbarModel tpNavbarModel;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    settingsComponentModel1 =
        createModel(context, () => SettingsComponentModel());
    settingsComponentModel2 =
        createModel(context, () => SettingsComponentModel());
    settingsComponentModel3 =
        createModel(context, () => SettingsComponentModel());
    settingsComponentModel4 =
        createModel(context, () => SettingsComponentModel());
    settingsComponentModel5 =
        createModel(context, () => SettingsComponentModel());
    settingsComponentModel6 =
        createModel(context, () => SettingsComponentModel());
    tpNavbarModel = createModel(context, () => TpNavbarModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    settingsComponentModel1.dispose();
    settingsComponentModel2.dispose();
    settingsComponentModel3.dispose();
    settingsComponentModel4.dispose();
    settingsComponentModel5.dispose();
    settingsComponentModel6.dispose();
    tpNavbarModel.dispose();
  }
}
