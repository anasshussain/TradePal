import '/auth/supabase_auth/auth_util.dart';
import '/repositories/backend.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/settings_component/settings_component_widget.dart';
import '/widgets/components/theme_picker/theme_picker_widget.dart';
import '/widgets/components/tp_navbar/tp_navbar_widget.dart';
import '/widgets/app_choice_chips.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/form_field_controller.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/core/routes/index.dart';
import '/trader_screens/trader_profile/trader_profile_widget.dart' show TraderProfileWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TraderProfileModel extends AppModel<TraderProfileWidget> {
  ///  Local state fields for this page.

  List<String> images = [
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg',
    'https://images.pexels.com/photos/36815599/pexels-photo-36815599.jpeg'
  ];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  List<StripeDataStruct> stripeDetails = [];
  void addToStripeDetails(StripeDataStruct item) => stripeDetails.add(item);
  void removeFromStripeDetails(StripeDataStruct item) =>
      stripeDetails.remove(item);
  void removeAtIndexFromStripeDetails(int index) =>
      stripeDetails.removeAt(index);
  void insertAtIndexInStripeDetails(int index, StripeDataStruct item) =>
      stripeDetails.insert(index, item);
  void updateStripeDetailsAtIndex(
          int index, Function(StripeDataStruct) updateFn) =>
      stripeDetails[index] = updateFn(stripeDetails[index]);

  List<BankDetailsStruct> bankDetails = [];
  void addToBankDetails(BankDetailsStruct item) => bankDetails.add(item);
  void removeFromBankDetails(BankDetailsStruct item) =>
      bankDetails.remove(item);
  void removeAtIndexFromBankDetails(int index) => bankDetails.removeAt(index);
  void insertAtIndexInBankDetails(int index, BankDetailsStruct item) =>
      bankDetails.insert(index, item);
  void updateBankDetailsAtIndex(
          int index, Function(BankDetailsStruct) updateFn) =>
      bankDetails[index] = updateFn(bankDetails[index]);

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
