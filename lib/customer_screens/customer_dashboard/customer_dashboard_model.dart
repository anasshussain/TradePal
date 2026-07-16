import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/customer_navbar/customer_navbar_widget.dart';
import '/components/jobs_list/jobs_list_widget.dart';
import '/components/stats/stats_widget.dart';
import '/components/text_button/text_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'customer_dashboard_widget.dart' show CustomerDashboardWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomerDashboardModel extends FlutterFlowModel<CustomerDashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar_component component.
  late AppbarComponentModel appbarComponentModel;
  // Model for stats component.
  late StatsModel statsModel1;
  // Model for stats component.
  late StatsModel statsModel2;
  // Model for textButton component.
  late TextButtonModel textButtonModel;
  // Model for jobs_list component.
  late JobsListModel jobsListModel;
  // Model for customer_navbar component.
  late CustomerNavbarModel customerNavbarModel;

  @override
  void initState(BuildContext context) {
    appbarComponentModel = createModel(context, () => AppbarComponentModel());
    statsModel1 = createModel(context, () => StatsModel());
    statsModel2 = createModel(context, () => StatsModel());
    textButtonModel = createModel(context, () => TextButtonModel());
    jobsListModel = createModel(context, () => JobsListModel());
    customerNavbarModel = createModel(context, () => CustomerNavbarModel());
  }

  @override
  void dispose() {
    appbarComponentModel.dispose();
    statsModel1.dispose();
    statsModel2.dispose();
    textButtonModel.dispose();
    jobsListModel.dispose();
    customerNavbarModel.dispose();
  }
}
