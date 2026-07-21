import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/alerts_model.dart';
export '/viewmodels/alerts_model.dart';

class AlertsWidget extends StatefulWidget {
  const AlertsWidget({
    super.key,
    String? title,
    String? description,
  })  : this.title = title ?? 'title',
        this.description = description ?? 'description';

  final String title;
  final String description;

  @override
  State<AlertsWidget> createState() => _AlertsWidgetState();
}

class _AlertsWidgetState extends State<AlertsWidget> {
  late AlertsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlertsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0.0,
          AppTheme.of(context).designToken.spacing.md,
          0.0,
          AppTheme.of(context).designToken.spacing.md),
      child: Material(
        color: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Container(
          width: double.infinity,
          height: 133.0,
          decoration: BoxDecoration(
            color: AppTheme.of(context).accent3,
            borderRadius: BorderRadius.circular(0.0),
            border: Border.all(
              color: AppTheme.of(context).alternate,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8.0,
                height: 133.0,
                decoration: BoxDecoration(
                  color: Color(0xFF914300),
                  borderRadius: BorderRadius.only(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(valueOrDefault<double>(
                    AppConstants.childPadding,
                    0.0,
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outlined,
                            color: Color(0xFF914300),
                            size: 24.0,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget!.title,
                                style: AppTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: AppTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF914300),
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                widget!.description,
                                style: AppTheme.of(context)
                                    .bodySmall
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: AppTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color:
                                          AppTheme.of(context).accent1,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(
                            width: AppTheme.of(context)
                                .designToken
                                .spacing
                                .md)),
                      ),
                    ].divide(SizedBox(
                        height: AppTheme.of(context)
                            .designToken
                            .spacing
                            .md)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
