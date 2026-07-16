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
import 'text_loader_model.dart';
export 'text_loader_model.dart';

class TextLoaderWidget extends StatefulWidget {
  const TextLoaderWidget({
    super.key,
    int? height,
    int? width,
  })  : this.height = height ?? 20,
        this.width = width ?? 120;

  final int height;
  final int width;

  @override
  State<TextLoaderWidget> createState() => _TextLoaderWidgetState();
}

class _TextLoaderWidgetState extends State<TextLoaderWidget>
    with TickerProviderStateMixin {
  late TextLoaderModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TextLoaderModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x57FFFFFF),
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
    return Container(
      width: widget!.width.toDouble(),
      height: widget!.height.toDouble(),
      decoration: BoxDecoration(
        color: Color(0xA8DCE4E8),
        borderRadius: BorderRadius.circular(
            AppTheme.of(context).designToken.radius.full),
      ),
    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
  }
}
