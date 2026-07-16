import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'choose_path_component_model.dart';
export 'choose_path_component_model.dart';

class ChoosePathComponentWidget extends StatefulWidget {
  const ChoosePathComponentWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    Color? btnColor,
    Color? boxColor,
    required this.borderColor,
  })  : this.btnColor = btnColor ?? const Color(0xFF00B3B3),
        this.boxColor = boxColor ?? const Color(0xFF1A1C1E);

  final Widget? icon;
  final String? title;
  final String? description;
  final String? buttonText;
  final Color btnColor;
  final Color boxColor;
  final Color? borderColor;

  @override
  State<ChoosePathComponentWidget> createState() =>
      _ChoosePathComponentWidgetState();
}

class _ChoosePathComponentWidgetState extends State<ChoosePathComponentWidget> {
  late ChoosePathComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChoosePathComponentModel());

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
            color: valueOrDefault<Color>(
              widget!.borderColor,
              AppTheme.of(context).secondaryBackground,
            ),
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(valueOrDefault<double>(
                  AppConstants.childPadding,
                  0.0,
                )),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppTheme.of(context)
                                        .designToken
                                        .radius
                                        .sm),
                              ),
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: widget!.boxColor,
                                  boxShadow: [
                                    AppTheme.of(context)
                                        .designToken
                                        .shadow
                                        .sm
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      AppTheme.of(context)
                                          .designToken
                                          .radius
                                          .sm),
                                  border: Border.all(
                                    color:
                                        AppTheme.of(context).alternate,
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: widget!.icon!,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, -1.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget!.title,
                                  'title',
                                ),
                                style: AppTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: AppTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ].divide(SizedBox(width: AppConstants.spacing)),
                        ),
                      ].divide(SizedBox(width: AppConstants.spacing)),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget!.description,
                        'description',
                      ),
                      style: AppTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.manrope(
                              fontWeight: AppTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: AppTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: AppTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            widget!.buttonText,
                            'btnText',
                          ),
                          style:
                              AppTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: widget!.btnColor,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: widget!.btnColor,
                          size: 24.0,
                        ),
                      ].divide(SizedBox(width: AppConstants.childPadding)),
                    ),
                  ].divide(SizedBox(height: AppConstants.spacing)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
