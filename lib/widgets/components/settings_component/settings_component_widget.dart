import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/settings_component_model.dart';
export '/viewmodels/settings_component_model.dart';

class SettingsComponentWidget extends StatefulWidget {
  const SettingsComponentWidget({
    super.key,
    required this.icon,
    String? title,
    String? description,
    required this.onTap,
    bool? showTrailingIcon,
  })  : this.title = title ?? 'text',
        this.description = description ?? 'description',
        this.showTrailingIcon = showTrailingIcon ?? false;

  final Widget? icon;
  final String title;
  final String description;
  final Future Function()? onTap;
  final bool showTrailingIcon;

  @override
  State<SettingsComponentWidget> createState() =>
      _SettingsComponentWidgetState();
}

class _SettingsComponentWidgetState extends State<SettingsComponentWidget> {
  late SettingsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await widget.onTap?.call();
      },
      child: Material(
        color: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppTheme.of(context).designToken.radius.sm),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
                AppTheme.of(context).designToken.radius.sm),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.32, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(valueOrDefault<double>(
                          AppConstants.radius1,
                          0.0,
                        )),
                      ),
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: AppTheme.of(context).secondary,
                          borderRadius:
                              BorderRadius.circular(valueOrDefault<double>(
                            AppConstants.radius1,
                            0.0,
                          )),
                        ),
                        child: widget!.icon!,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget!.title,
                        style: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.manrope(
                                fontWeight: FontWeight.w600,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: AppTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Text(
                        widget!.description,
                        style: AppTheme.of(context).labelSmall.override(
                              font: GoogleFonts.inter(
                                fontWeight: AppTheme.of(context)
                                    .labelSmall
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .labelSmall
                                    .fontStyle,
                              ),
                              fontSize: 10.0,
                              letterSpacing: 0.0,
                              fontWeight: AppTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                      ),
                    ].divide(SizedBox(
                        height: AppTheme.of(context)
                            .designToken
                            .spacing
                            .sm)),
                  ),
                ].divide(const SizedBox(width: AppConstants.childSpacing)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
