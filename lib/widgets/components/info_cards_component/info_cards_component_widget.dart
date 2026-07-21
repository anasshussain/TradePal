import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/info_cards_component_model.dart';
export '/viewmodels/info_cards_component_model.dart';

class InfoCardsComponentWidget extends StatefulWidget {
  const InfoCardsComponentWidget({
    super.key,
    this.icon,
    required this.title,
    this.description,
    this.image,
  });

  final Widget? icon;
  final String? title;
  final String? description;
  final String? image;

  @override
  State<InfoCardsComponentWidget> createState() =>
      _InfoCardsComponentWidgetState();
}

class _InfoCardsComponentWidgetState extends State<InfoCardsComponentWidget> {
  late InfoCardsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfoCardsComponentModel());

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
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(valueOrDefault<double>(
          AppConstants.radius1,
          0.0,
        )),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(valueOrDefault<double>(
            AppConstants.radius1,
            0.0,
          )),
          border: Border.all(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(valueOrDefault<double>(
            AppConstants.childPadding,
            0.0,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget!.icon != null) widget!.icon!,
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget!.title != null && widget!.title != '')
                    Text(
                      valueOrDefault<String>(
                        widget!.title,
                        'title',
                      ),
                      style: AppTheme.of(context).titleLarge.override(
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
                  if (widget!.description != null && widget!.description != '')
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
                            color: AppTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: AppTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: AppTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                ].divide(SizedBox(height: 5.0)),
              ),
              if ((widget!.image != null && widget!.image != '') &&
                  responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                    tabletLandscape: false,
                    desktop: false,
                  ))
                ClipRRect(
                  borderRadius: BorderRadius.circular(valueOrDefault<double>(
                    AppConstants.radius3,
                    0.0,
                  )),
                  child: CachedNetworkImage(
                    fadeInDuration: Duration(milliseconds: 500),
                    fadeOutDuration: Duration(milliseconds: 500),
                    imageUrl: widget!.image!,
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.contain,
                    errorWidget: (context, error, stackTrace) => Image.asset(
                      'assets/images/error_image.svg',
                      width: double.infinity,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
            ].divide(SizedBox(height: AppConstants.childSpacing)),
          ),
        ),
      ),
    );
  }
}
