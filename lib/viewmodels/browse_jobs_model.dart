import '/utils/enums/enums.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/jobs_list/jobs_list_widget.dart';
import '/widgets/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/widgets/components/tp_navbar/tp_navbar_widget.dart';
import '/widgets/app_drop_down.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/utils/form_field_controller.dart';
import 'dart:ui';
import '/core/routes/index.dart';
import '/trader_screens/browse_jobs/browse_jobs_widget.dart' show BrowseJobsWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BrowseJobsModel extends AppModel<BrowseJobsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // Model for page_header_sectiom component.
  late PageHeaderSectiomModel pageHeaderSectiomModel;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Model for jobs_list component.
  late JobsListModel jobsListModel;
  // Model for tp_navbar component.
  late TpNavbarModel tpNavbarModel;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    pageHeaderSectiomModel =
        createModel(context, () => PageHeaderSectiomModel());
    jobsListModel = createModel(context, () => JobsListModel());
    tpNavbarModel = createModel(context, () => TpNavbarModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    pageHeaderSectiomModel.dispose();
    jobsListModel.dispose();
    tpNavbarModel.dispose();
  }
}
