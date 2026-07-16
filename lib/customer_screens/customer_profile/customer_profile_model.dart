import '/auth/supabase_auth/auth_util.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/customer_navbar/customer_navbar_widget.dart';
import '/components/settings_component/settings_component_widget.dart';
import '/components/theme_picker/theme_picker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/index.dart';
import 'customer_profile_widget.dart' show CustomerProfileWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomerProfileModel extends FlutterFlowModel<CustomerProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
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
  // Model for settings_component component.
  late SettingsComponentModel settingsComponentModel7;
  // Model for settings_component component.
  late SettingsComponentModel settingsComponentModel8;
  // Model for customer_navbar component.
  late CustomerNavbarModel customerNavbarModel;

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
    settingsComponentModel7 =
        createModel(context, () => SettingsComponentModel());
    settingsComponentModel8 =
        createModel(context, () => SettingsComponentModel());
    customerNavbarModel = createModel(context, () => CustomerNavbarModel());
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
    settingsComponentModel7.dispose();
    settingsComponentModel8.dispose();
    customerNavbarModel.dispose();
  }
}
