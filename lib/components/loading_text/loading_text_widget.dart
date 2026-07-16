import '/core/animations.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'loading_text_model.dart';
export 'loading_text_model.dart';

class LoadingTextWidget extends StatefulWidget {
  const LoadingTextWidget({super.key});

  @override
  State<LoadingTextWidget> createState() => _LoadingTextWidgetState();
}

class _LoadingTextWidgetState extends State<LoadingTextWidget>
    with TickerProviderStateMixin {
  late LoadingTextModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingTextModel());

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
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
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        'Loading !',
        style: AppTheme.of(context).bodyMedium.override(
              font: GoogleFonts.manrope(
                fontWeight: AppTheme.of(context).bodyMedium.fontWeight,
                fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
              ),
              fontSize: 16.0,
              letterSpacing: 0.0,
              fontWeight: AppTheme.of(context).bodyMedium.fontWeight,
              fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
            ),
      ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
    );
  }
}
