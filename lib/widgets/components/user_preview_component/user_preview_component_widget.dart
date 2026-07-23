import '/core/utils/image_decode_size.dart';
import '/core/utils/animations.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/user_preview_component_model.dart';
export '/viewmodels/user_preview_component_model.dart';

class UserPreviewComponentWidget extends StatefulWidget {
  const UserPreviewComponentWidget({
    super.key,
    String? name,
    required this.avatarUrl,
  }) : this.name = name ?? 'name';

  final String name;
  final String? avatarUrl;

  @override
  State<UserPreviewComponentWidget> createState() =>
      _UserPreviewComponentWidgetState();
}

class _UserPreviewComponentWidgetState extends State<UserPreviewComponentWidget>
    with TickerProviderStateMixin {
  late UserPreviewComponentModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserPreviewComponentModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 80.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(valueOrDefault<double>(
          AppConstants.radius3,
          0.0,
        )),
        border: Border.all(
          color: Colors.transparent,
          width: 0.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(valueOrDefault<double>(
          AppConstants.childPadding,
          0.0,
        )),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: AppTheme.of(context).primary,
                  width: 2.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeOutDuration: const Duration(milliseconds: 500),
                  imageUrl: valueOrDefault<String>(
                    widget!.avatarUrl,
                    'https://images-ext-1.discordapp.net/external/AO96cLsz1bw1R0zy6qWuphMKgA7a3OkU2M3-zUSxcXM/%3Fq%3Dtbn%3AANd9GcTpRGUcBVltEkFutN21fIqebRvrgP7fOv4CjcNwuka3BtXR_-jhpd7GheJ_RkvMtSsnsA8%26usqp%3DCAU/https/encrypted-tbn0.gstatic.com/images?format=webp&width=562&height=360',
                  ),
                  width: 44.0,
                  height: 44.0,
                  memCacheWidth: decodeCacheSize(context, 44.0),
                  memCacheHeight: decodeCacheSize(context, 44.0),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget!.name,
                        'TradePal',
                      ),
                      style: AppTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.manrope(
                              fontWeight: AppTheme.of(context)
                                  .bodyLarge
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: AppTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: AppTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
  }
}
