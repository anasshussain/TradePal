import '/core/animations.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/custom_loader_component_model.dart';
export '/viewmodels/custom_loader_component_model.dart';

class CustomLoaderComponentWidget extends StatefulWidget {
  const CustomLoaderComponentWidget({super.key});

  @override
  State<CustomLoaderComponentWidget> createState() =>
      _CustomLoaderComponentWidgetState();
}

class _CustomLoaderComponentWidgetState
    extends State<CustomLoaderComponentWidget> with TickerProviderStateMixin {
  late CustomLoaderComponentModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomLoaderComponentModel());

    animationsMap.addAll({
      'iconOnPageLoadAnimation1': AnimationInfo(
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnPageLoadAnimation2': AnimationInfo(
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 1000.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnPageLoadAnimation3': AnimationInfo(
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 2000.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.handyman,
          color: AppTheme.of(context).primary,
          size: 24.0,
        ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation1']!),
        Icon(
          Icons.electric_bolt,
          color: AppTheme.of(context).tertiary,
          size: 24.0,
        ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation2']!),
        Icon(
          Icons.plumbing_outlined,
          color: AppTheme.of(context).success,
          size: 24.0,
        ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation3']!),
      ],
    );
  }
}
