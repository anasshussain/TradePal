import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'appbar_component_model.dart';
export 'appbar_component_model.dart';

class AppbarComponentWidget extends StatefulWidget {
  const AppbarComponentWidget({
    super.key,
    this.title,
    this.action,
    bool? showAction,
    this.actionIcon,
    this.extraWidget,
  }) : this.showAction = showAction ?? false;

  final String? title;
  final Future Function()? action;
  final bool showAction;
  final Widget? actionIcon;
  final Widget Function()? extraWidget;

  @override
  State<AppbarComponentWidget> createState() => _AppbarComponentWidgetState();
}

class _AppbarComponentWidgetState extends State<AppbarComponentWidget> {
  late AppbarComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppbarComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (getCurrentRouteStack(context).length > 1)
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      icon: FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (widget!.extraWidget != null) {
                          return Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await widget.action?.call();
                              },
                              child: Builder(builder: (_) {
                                return widget.extraWidget != null
                                    ? widget.extraWidget!()
                                    : SizedBox.shrink();
                              }),
                            ),
                          );
                        } else {
                          return Text(
                            valueOrDefault<String>(
                              widget!.title,
                              'Page title',
                            ),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (widget!.showAction)
              FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                icon: widget!.actionIcon!,
                onPressed: () async {
                  await widget.action?.call();
                },
              ),
          ],
        ),
        Divider(
          height: 3.0,
          thickness: 1.0,
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ],
    );
  }
}
