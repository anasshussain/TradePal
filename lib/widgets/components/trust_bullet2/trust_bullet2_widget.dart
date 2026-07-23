import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/trust_bullet2_model.dart';
export '/viewmodels/trust_bullet2_model.dart';

class TrustBullet2Widget extends StatefulWidget {
  const TrustBullet2Widget({
    super.key,
    String? label,
  }) : this.label = label ?? 'Phone numbers';

  final String label;

  @override
  State<TrustBullet2Widget> createState() => _TrustBullet2WidgetState();
}

class _TrustBullet2WidgetState extends State<TrustBullet2Widget> {
  late TrustBullet2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrustBullet2Model());

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
          alignment: const AlignmentDirectional(0.0, 0.0),
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
      ].divide(const SizedBox(width: 8.0)),
    );
  }
}
