import '/auth/supabase_auth/auth_util.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/applogo_component/applogo_component_widget.dart';
import '/widgets/components/info_cards_component/info_cards_component_widget.dart';
import '/widgets/components/testimonials_component/testimonials_component_widget.dart';
import '/core/utils/animations.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:math';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import '/dormant/home/home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeModel extends AppModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for applogo_component component.
  late ApplogoComponentModel applogoComponentModel;
  // Model for infoCards_component component.
  late InfoCardsComponentModel infoCardsComponentModel1;
  // Model for infoCards_component component.
  late InfoCardsComponentModel infoCardsComponentModel2;
  // Model for infoCards_component component.
  late InfoCardsComponentModel infoCardsComponentModel3;
  // Model for testimonials_component component.
  late TestimonialsComponentModel testimonialsComponentModel;

  @override
  void initState(BuildContext context) {
    applogoComponentModel = createModel(context, () => ApplogoComponentModel());
    infoCardsComponentModel1 =
        createModel(context, () => InfoCardsComponentModel());
    infoCardsComponentModel2 =
        createModel(context, () => InfoCardsComponentModel());
    infoCardsComponentModel3 =
        createModel(context, () => InfoCardsComponentModel());
    testimonialsComponentModel =
        createModel(context, () => TestimonialsComponentModel());
  }

  @override
  void dispose() {
    applogoComponentModel.dispose();
    infoCardsComponentModel1.dispose();
    infoCardsComponentModel2.dispose();
    infoCardsComponentModel3.dispose();
    testimonialsComponentModel.dispose();
  }
}
