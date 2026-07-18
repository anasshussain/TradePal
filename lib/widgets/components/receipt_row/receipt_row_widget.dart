import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/receipt_row_model.dart';
export '/viewmodels/receipt_row_model.dart';

class ReceiptRowWidget extends StatefulWidget {
  const ReceiptRowWidget({
    super.key,
    String? label,
    String? value,
  })  : this.label = label ?? 'Payment Method',
        this.value = value ?? 'Visa •••• 4242';

  final String label;
  final String value;

  @override
  State<ReceiptRowWidget> createState() => _ReceiptRowWidgetState();
}

class _ReceiptRowWidgetState extends State<ReceiptRowWidget> {
  late ReceiptRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReceiptRowModel());

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          valueOrDefault<String>(
            widget!.label,
            'Payment Method',
          ),
          style: AppTheme.of(context).bodyMedium.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      AppTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                ),
                color: AppTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: AppTheme.of(context).bodyMedium.fontWeight,
                fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                lineHeight: 1.5,
              ),
        ),
        Text(
          valueOrDefault<String>(
            widget!.value,
            'Visa •••• 4242',
          ),
          style: AppTheme.of(context).bodyMedium.override(
                font: GoogleFonts.manrope(
                  fontWeight: FontWeight.w600,
                  fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                ),
                color: AppTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                lineHeight: 1.5,
              ),
        ),
      ],
    );
  }
}
