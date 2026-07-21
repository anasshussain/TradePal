import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/action_tile2_model.dart';
export '/viewmodels/action_tile2_model.dart';

class ActionTile2Widget extends StatefulWidget {
  const ActionTile2Widget({
    super.key,
    Color? bgColor,
    this.icon,
    Color? iconColor,
    String? label,
  })  : this.bgColor = bgColor ?? const Color(0x1A635BFF),
        this.iconColor = iconColor ?? const Color(0x00000000),
        this.label = label ?? 'Photos';

  final Color bgColor;
  final Widget? icon;
  final Color iconColor;
  final String label;

  @override
  State<ActionTile2Widget> createState() => _ActionTile2WidgetState();
}

class _ActionTile2WidgetState extends State<ActionTile2Widget> {
  late ActionTile2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ActionTile2Model());

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
      decoration: BoxDecoration(
        color: AppTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: AppTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    widget!.bgColor,
                    Color(0x1A635BFF),
                  ),
                  borderRadius: BorderRadius.circular(9999.0),
                  shape: BoxShape.rectangle,
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: widget!.icon!,
              ),
              Text(
                valueOrDefault<String>(
                  widget!.label,
                  'Photos',
                ),
                textAlign: TextAlign.center,
                style: AppTheme.of(context).labelMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            AppTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            AppTheme.of(context).labelMedium.fontStyle,
                      ),
                      color: AppTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          AppTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          AppTheme.of(context).labelMedium.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}
