import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/payment_method_item_model.dart';
export '/viewmodels/payment_method_item_model.dart';

class PaymentMethodItemWidget extends StatefulWidget {
  const PaymentMethodItemWidget({
    super.key,
    this.icon,
    String? label,
    bool? selected,
  })  : this.label = label ?? 'Credit Card',
        this.selected = selected ?? true;

  final Widget? icon;
  final String label;
  final bool selected;

  @override
  State<PaymentMethodItemWidget> createState() =>
      _PaymentMethodItemWidgetState();
}

class _PaymentMethodItemWidgetState extends State<PaymentMethodItemWidget> {
  late PaymentMethodItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentMethodItemModel());

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
        color: widget!.selected
            ? Color(0x0D635BFF)
            : AppTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: widget!.selected
              ? AppTheme.of(context).primary
              : AppTheme.of(context).alternate,
          width: widget!.selected ? 1.0 : 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget!.icon!,
              Expanded(
                flex: 1,
                child: Text(
                  valueOrDefault<String>(
                    widget!.label,
                    'Credit Card',
                  ),
                  style: AppTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: AppTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              AppTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: AppTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            AppTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            AppTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.5,
                      ),
                ),
              ),
              Container(
                width: 20.0,
                height: 20.0,
                child: Stack(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  children: [
                    if (widget!.selected ? true : false)
                      Icon(
                        Icons.check_circle_rounded,
                        color: widget!.selected
                            ? AppTheme.of(context).primary
                            : AppTheme.of(context).alternate,
                        size: 20.0,
                      ),
                    if (widget!.selected ? false : true)
                      Icon(
                        Icons.radio_button_unchecked_rounded,
                        color: widget!.selected
                            ? AppTheme.of(context).primary
                            : AppTheme.of(context).alternate,
                        size: 20.0,
                      ),
                  ],
                ),
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ),
      ),
    );
  }
}
