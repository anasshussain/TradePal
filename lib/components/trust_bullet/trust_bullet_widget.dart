import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'trust_bullet_model.dart';
export 'trust_bullet_model.dart';

class TrustBulletWidget extends StatefulWidget {
  const TrustBulletWidget({
    super.key,
    String? label,
  }) : this.label = label ?? 'Phone numbers';

  final String label;

  @override
  State<TrustBulletWidget> createState() => _TrustBulletWidgetState();
}

class _TrustBulletWidgetState extends State<TrustBulletWidget> {
  late TrustBulletModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrustBulletModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9999.0),
            shape: BoxShape.rectangle,
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Icon(
            Icons.check_rounded,
            color: AppTheme.of(context).info,
            size: 14.0,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            valueOrDefault<String>(
              widget!.label,
              'Phone numbers',
            ),
            style: AppTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.manrope(
                    fontWeight:
                        AppTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        AppTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: AppTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      AppTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                  lineHeight: 1.5,
                ),
          ),
        ),
      ].divide(SizedBox(width: 8.0)),
    );
  }
}
