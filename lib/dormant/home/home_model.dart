import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/applogo_component/applogo_component_widget.dart';
import '/components/info_cards_component/info_cards_component_widget.dart';
import '/components/testimonials_component/testimonials_component_widget.dart';
import '/core/animations.dart';
import '/widgets/app_icon_button.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
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
