import '/core/utils/animations.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:math';
import 'dart:ui';
import '/widgets/components/user_preview_component/user_preview_component_widget.dart' show UserPreviewComponentWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserPreviewComponentModel
    extends AppModel<UserPreviewComponentWidget> {
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
