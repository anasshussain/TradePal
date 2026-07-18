import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/customer_navbar/customer_navbar_widget.dart';
import '/widgets/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/dormant/browse_trade_person/browse_trade_person_widget.dart' show BrowseTradePersonWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BrowseTradePersonModel extends AppModel<BrowseTradePersonWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // Model for page_header_sectiom component.
  late PageHeaderSectiomModel pageHeaderSectiomModel;
  // Model for customer_navbar component.
  late CustomerNavbarModel customerNavbarModel;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    pageHeaderSectiomModel =
        createModel(context, () => PageHeaderSectiomModel());
    customerNavbarModel = createModel(context, () => CustomerNavbarModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    pageHeaderSectiomModel.dispose();
    customerNavbarModel.dispose();
  }
}
