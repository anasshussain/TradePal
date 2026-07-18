import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/stats_model.dart';
export '/viewmodels/stats_model.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({
    super.key,
    Color? iconBackgroundColor,
    this.icon,
    required this.value,
    this.title,
    this.valueColor,
  }) : this.iconBackgroundColor =
            iconBackgroundColor ?? const Color(0xFF00B3B3);

  final Color iconBackgroundColor;
  final Widget? icon;
  final int? value;
  final String? title;
  final Color? valueColor;

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  late StatsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            AppTheme.of(context).designToken.radius.lg),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(
              AppTheme.of(context).designToken.radius.lg),
          border: Border.all(
            color: AppTheme.of(context).alternate,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(valueOrDefault<double>(
            AppConstants.childPadding,
            0.0,
          )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.title,
                      'State',
                    ),
                    style: AppTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.inter(
                            fontWeight: AppTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: AppTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          color: AppTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight:
                              AppTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              AppTheme.of(context).bodyLarge.fontStyle,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      formatNumber(
                        widget!.value,
                        formatType: FormatType.custom,
                        format: '00',
                        locale: '',
                      ),
                      '00',
                    ),
                    style: AppTheme.of(context).displayMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w900,
                            fontStyle: AppTheme.of(context)
                                .displayMedium
                                .fontStyle,
                          ),
                          color: widget!.valueColor,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w900,
                          fontStyle: AppTheme.of(context)
                              .displayMedium
                              .fontStyle,
                        ),
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      AppTheme.of(context).designToken.radius.lg),
                ),
                child: Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget!.iconBackgroundColor,
                      AppTheme.of(context).accent1,
                    ),
                    borderRadius: BorderRadius.circular(
                        AppTheme.of(context).designToken.radius.lg),
                    border: Border.all(
                      color: AppTheme.of(context).alternate,
                    ),
                  ),
                  child: widget!.icon!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
