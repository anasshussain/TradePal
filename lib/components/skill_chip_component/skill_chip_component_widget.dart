import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'skill_chip_component_model.dart';
export 'skill_chip_component_model.dart';

class SkillChipComponentWidget extends StatefulWidget {
  const SkillChipComponentWidget({
    super.key,
    required this.title,
    required this.onTap,
    bool? callAction,
    bool? showTrailingIcon,
  })  : this.callAction = callAction ?? false,
        this.showTrailingIcon = showTrailingIcon ?? true;

  final String? title;
  final Future Function()? onTap;
  final bool callAction;
  final bool showTrailingIcon;

  @override
  State<SkillChipComponentWidget> createState() =>
      _SkillChipComponentWidgetState();
}

class _SkillChipComponentWidgetState extends State<SkillChipComponentWidget> {
  late SkillChipComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SkillChipComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (widget!.callAction) {
          await widget.onTap?.call();
        } else {
          if (widget!.showTrailingIcon) {
            await widget.onTap?.call();
          }
        }
      },
      child: Material(
        color: Colors.transparent,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              FlutterFlowTheme.of(context).designToken.radius.sm),
        ),
        child: Container(
          width: 120.0,
          height: 34.0,
          decoration: BoxDecoration(
            color: !widget!.callAction
                ? FlutterFlowTheme.of(context).primary
                : Color(0x00000000),
            borderRadius: BorderRadius.circular(
                FlutterFlowTheme.of(context).designToken.radius.sm),
            border: Border.all(
              color: !widget!.callAction
                  ? Colors.transparent
                  : FlutterFlowTheme.of(context).border,
              width: !widget!.callAction ? 0.0 : 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        widget!.title,
                        'title',
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: Colors.white,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                          ),
                    ),
                  ),
                ),
                if (widget!.showTrailingIcon)
                  Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 16.0,
                  ),
              ].divide(SizedBox(
                  width: FlutterFlowTheme.of(context).designToken.spacing.sm)),
            ),
          ),
        ),
      ),
    );
  }
}
