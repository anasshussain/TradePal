import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/labels_model.dart';
export '/viewmodels/labels_model.dart';

class LabelsWidget extends StatefulWidget {
  const LabelsWidget({
    super.key,
    this.icon,
    this.labelText,
    this.textcolor,
    required this.backroundColor,
  });

  final Widget? icon;
  final String? labelText;
  final Color? textcolor;
  final Color? backroundColor;

  @override
  State<LabelsWidget> createState() => _LabelsWidgetState();
}

class _LabelsWidgetState extends State<LabelsWidget> {
  late LabelsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LabelsModel());

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
      height: 24.0,
      decoration: BoxDecoration(
        color: widget!.backroundColor,
        borderRadius: BorderRadius.circular(
            AppTheme.of(context).designToken.radius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (valueOrDefault<bool>(
            widget!.icon != null,
            false,
          ))
            widget!.icon!,
          Text(
            valueOrDefault<String>(
              widget!.labelText,
              'unknown',
            ),
            style: AppTheme.of(context).bodySmall.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                  ),
                  color: valueOrDefault<Color>(
                    widget!.textcolor,
                    AppTheme.of(context).secondaryText,
                  ),
                  fontSize: 10.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                ),
          ),
        ]
            .divide(SizedBox(width: AppConstants.childSpacing))
            .around(SizedBox(width: AppConstants.childSpacing)),
      ),
    );
  }
}
