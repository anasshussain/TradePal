import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'page_header_sectiom_model.dart';
export 'page_header_sectiom_model.dart';

class PageHeaderSectiomWidget extends StatefulWidget {
  const PageHeaderSectiomWidget({
    super.key,
    this.tag,
    this.title,
    this.subtitle,
    this.numberOfItems,
    this.itemText,
  });

  final String? tag;
  final String? title;
  final String? subtitle;
  final int? numberOfItems;
  final String? itemText;

  @override
  State<PageHeaderSectiomWidget> createState() =>
      _PageHeaderSectiomWidgetState();
}

class _PageHeaderSectiomWidgetState extends State<PageHeaderSectiomWidget> {
  late PageHeaderSectiomModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PageHeaderSectiomModel());

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
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget!.tag != null && widget!.tag != '')
            Text(
              widget!.tag!,
              style: AppTheme.of(context).bodySmall.override(
                    font: GoogleFonts.manrope(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          AppTheme.of(context).bodySmall.fontStyle,
                    ),
                    color: AppTheme.of(context).primary,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                  ),
            ),
          if (valueOrDefault<String>(
                    widget!.subtitle,
                    '--',
                  ) !=
                  null &&
              valueOrDefault<String>(
                    widget!.subtitle,
                    '--',
                  ) !=
                  '')
            Text(
              widget!.title!,
              style: AppTheme.of(context).displayMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.w900,
                      fontStyle:
                          AppTheme.of(context).displayMedium.fontStyle,
                    ),
                    fontSize: 38.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w900,
                    fontStyle:
                        AppTheme.of(context).displayMedium.fontStyle,
                    lineHeight: 1.0,
                  ),
            ),
          if (valueOrDefault<String>(
                    widget!.subtitle,
                    '--',
                  ) !=
                  null &&
              valueOrDefault<String>(
                    widget!.subtitle,
                    '--',
                  ) !=
                  '')
            Text(
              widget!.subtitle!,
              textAlign: TextAlign.start,
              style: AppTheme.of(context).titleSmall.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          AppTheme.of(context).titleSmall.fontStyle,
                    ),
                    color: AppTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        AppTheme.of(context).titleSmall.fontStyle,
                  ),
            ),
          if (widget!.numberOfItems != null)
            Material(
              color: Colors.transparent,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x4D214FC7),
                  borderRadius: BorderRadius.circular(8.0),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        color: AppTheme.of(context).primary,
                        size: 14.0,
                      ),
                      Text(
                        '${widget!.numberOfItems?.toString()} ${widget!.itemText}',
                        style: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.manrope(
                                fontWeight: AppTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: AppTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: AppTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ].divide(SizedBox(width: AppConstants.childSpacing)),
                  ),
                ),
              ),
            ),
        ].divide(SizedBox(height: AppConstants.childSpacing)),
      ),
    );
  }
}
