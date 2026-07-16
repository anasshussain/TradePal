import '/components/text_loader/text_loader_widget.dart';
import '/core/animations.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'inbox_component_loader_model.dart';
export 'inbox_component_loader_model.dart';

class InboxComponentLoaderWidget extends StatefulWidget {
  const InboxComponentLoaderWidget({super.key});

  @override
  State<InboxComponentLoaderWidget> createState() =>
      _InboxComponentLoaderWidgetState();
}

class _InboxComponentLoaderWidgetState extends State<InboxComponentLoaderWidget>
    with TickerProviderStateMixin {
  late InboxComponentLoaderModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InboxComponentLoaderModel());

    animationsMap.addAll({
      'imageOnPageLoadAnimation': AnimationInfo(
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
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            AppTheme.of(context).designToken.radius.lg),
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 100.0,
        ),
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(
              AppTheme.of(context).designToken.radius.lg),
          border: Border.all(
            color: AppTheme.of(context).alternate,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(valueOrDefault<double>(
            AppConstants.childPadding,
            0.0,
          )),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  'https://images-ext-1.discordapp.net/external/AO96cLsz1bw1R0zy6qWuphMKgA7a3OkU2M3-zUSxcXM/%3Fq%3Dtbn%3AANd9GcTpRGUcBVltEkFutN21fIqebRvrgP7fOv4CjcNwuka3BtXR_-jhpd7GheJ_RkvMtSsnsA8%26usqp%3DCAU/https/encrypted-tbn0.gstatic.com/images?format=webp&width=562&height=360',
                  width: 56.0,
                  height: 56.0,
                  fit: BoxFit.cover,
                ),
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wrapWithModel(
                          model: _model.textLoaderModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: TextLoaderWidget(
                            height: 18,
                            width: 80,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.textLoaderModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: TextLoaderWidget(
                            height: 18,
                            width: 30,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          AppTheme.of(context).designToken.spacing.md,
                          0.0,
                          0.0),
                      child: wrapWithModel(
                        model: _model.textLoaderModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: TextLoaderWidget(
                          height: 18,
                          width: 70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ].divide(SizedBox(width: AppConstants.childSpacing)),
          ),
        ),
      ),
    );
  }
}
