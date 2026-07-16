import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'button6_model.dart';
export 'button6_model.dart';

class Button6Widget extends StatefulWidget {
  const Button6Widget({
    super.key,
    String? content,
    this.icon,
    bool? iconPresent,
    this.iconEnd,
    bool? iconEndPresent,
    String? variant,
    String? size,
    bool? fullWidth,
    bool? loading,
    bool? disabled,
  })  : this.content = content ?? 'Cancel',
        this.iconPresent = iconPresent ?? false,
        this.iconEndPresent = iconEndPresent ?? false,
        this.variant = variant ?? 'ghost',
        this.size = size ?? 'large',
        this.fullWidth = fullWidth ?? true,
        this.loading = loading ?? false,
        this.disabled = disabled ?? false;

  final String content;
  final Widget? icon;
  final bool iconPresent;
  final Widget? iconEnd;
  final bool iconEndPresent;
  final String variant;
  final String size;
  final bool fullWidth;
  final bool loading;
  final bool disabled;

  @override
  State<Button6Widget> createState() => _Button6WidgetState();
}

class _Button6WidgetState extends State<Button6Widget> {
  late Button6Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Button6Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget!.disabled ? 0.55 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: () {
            if (widget!.variant == 'secondary') {
              return FlutterFlowTheme.of(context).secondary;
            } else if (widget!.variant == 'outline') {
              return Colors.transparent;
            } else if (widget!.variant == 'ghost') {
              return Colors.transparent;
            } else if (widget!.variant == 'destructive') {
              return FlutterFlowTheme.of(context).error;
            } else {
              return FlutterFlowTheme.of(context).primary;
            }
          }(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(valueOrDefault<double>(
              () {
                if (widget!.size == 'small') {
                  return 4.0;
                } else if (widget!.size == 'large') {
                  return 12.0;
                } else {
                  return 8.0;
                }
              }(),
              0.0,
            )),
            topRight: Radius.circular(valueOrDefault<double>(
              () {
                if (widget!.size == 'small') {
                  return 4.0;
                } else if (widget!.size == 'large') {
                  return 12.0;
                } else {
                  return 8.0;
                }
              }(),
              0.0,
            )),
            bottomLeft: Radius.circular(valueOrDefault<double>(
              () {
                if (widget!.size == 'small') {
                  return 4.0;
                } else if (widget!.size == 'large') {
                  return 12.0;
                } else {
                  return 8.0;
                }
              }(),
              0.0,
            )),
            bottomRight: Radius.circular(valueOrDefault<double>(
              () {
                if (widget!.size == 'small') {
                  return 4.0;
                } else if (widget!.size == 'large') {
                  return 12.0;
                } else {
                  return 8.0;
                }
              }(),
              0.0,
            )),
          ),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: widget!.variant == 'outline'
                ? FlutterFlowTheme.of(context).alternate
                : Colors.transparent,
            width: widget!.variant == 'outline' ? 1.0 : 0.0,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            Opacity(
              opacity: widget!.loading ? 0.0 : 1.0,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    valueOrDefault<double>(
                      () {
                        if (widget!.size == 'small') {
                          return 16.0;
                        } else if (widget!.size == 'large') {
                          return 32.0;
                        } else {
                          return 24.0;
                        }
                      }(),
                      0.0,
                    ),
                    valueOrDefault<double>(
                      () {
                        if (widget!.size == 'small') {
                          return 4.0;
                        } else if (widget!.size == 'large') {
                          return 16.0;
                        } else {
                          return 8.0;
                        }
                      }(),
                      0.0,
                    ),
                    valueOrDefault<double>(
                      () {
                        if (widget!.size == 'small') {
                          return 16.0;
                        } else if (widget!.size == 'large') {
                          return 32.0;
                        } else {
                          return 24.0;
                        }
                      }(),
                      0.0,
                    ),
                    valueOrDefault<double>(
                      () {
                        if (widget!.size == 'small') {
                          return 4.0;
                        } else if (widget!.size == 'large') {
                          return 16.0;
                        } else {
                          return 8.0;
                        }
                      }(),
                      0.0,
                    )),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (valueOrDefault<bool>(
                      widget!.iconPresent,
                      false,
                    ))
                      widget!.icon!,
                    Text(
                      valueOrDefault<String>(
                        widget!.content,
                        'Cancel',
                      ),
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                            color: () {
                              if (widget!.variant == 'secondary') {
                                return Colors.white;
                              } else if (widget!.variant == 'outline') {
                                return FlutterFlowTheme.of(context).primaryText;
                              } else if (widget!.variant == 'ghost') {
                                return FlutterFlowTheme.of(context).primary;
                              } else if (widget!.variant == 'destructive') {
                                return Colors.white;
                              } else {
                                return Colors.white;
                              }
                            }(),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                      overflow: TextOverflow.clip,
                    ),
                    if (valueOrDefault<bool>(
                      widget!.iconEndPresent,
                      false,
                    ))
                      widget!.iconEnd!,
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
            ),
            if (widget!.loading ? true : false)
              CircularPercentIndicator(
                percent: 0.0,
                radius: 7.0,
                lineWidth: 2.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: () {
                  if (widget!.variant == 'secondary') {
                    return Colors.white;
                  } else if (widget!.variant == 'outline') {
                    return FlutterFlowTheme.of(context).primaryText;
                  } else if (widget!.variant == 'ghost') {
                    return FlutterFlowTheme.of(context).primary;
                  } else if (widget!.variant == 'destructive') {
                    return Colors.white;
                  } else {
                    return Colors.white;
                  }
                }(),
                backgroundColor: FlutterFlowTheme.of(context).alternate,
              ),
          ],
        ),
      ),
    );
  }
}
