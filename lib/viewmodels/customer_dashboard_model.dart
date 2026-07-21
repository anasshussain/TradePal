import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/utils/enums/enums.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/customer_navbar/customer_navbar_widget.dart';
import '/widgets/components/jobs_list/jobs_list_widget.dart';
import '/widgets/components/stats/stats_widget.dart';
import '/widgets/components/text_button/text_button_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import '/customer_screens/customer_dashboard/customer_dashboard_widget.dart' show CustomerDashboardWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomerDashboardModel extends AppModel<CustomerDashboardWidget> {
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
