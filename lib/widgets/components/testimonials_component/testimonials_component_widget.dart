import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/testimonials_component_model.dart';
export '/viewmodels/testimonials_component_model.dart';

class TestimonialsComponentWidget extends StatefulWidget {
  const TestimonialsComponentWidget({super.key});

  @override
  State<TestimonialsComponentWidget> createState() =>
      _TestimonialsComponentWidgetState();
}

class _TestimonialsComponentWidgetState
    extends State<TestimonialsComponentWidget> {
  late TestimonialsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestimonialsComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});

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
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(valueOrDefault<double>(
            AppConstants.childPadding,
            0.0,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Text(
                  'What users say',
                  style: AppTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FontWeight.w600,
                          fontStyle: AppTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                        color: AppTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: AppTheme.of(context)
                            .headlineSmall
                            .fontStyle,
                      ),
                ),
              ),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryBackground,
                        borderRadius:
                            BorderRadius.circular(valueOrDefault<double>(
                          AppConstants.radius2,
                          0.0,
                        )),
                        border: Border.all(
                          color: AppTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            RatingBar.builder(
                              onRatingUpdate: (newValue) => safeSetState(
                                  () => _model.ratingBarValue1 = newValue),
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: AppTheme.of(context).primary,
                              ),
                              direction: Axis.horizontal,
                              initialRating: _model.ratingBarValue1 ??= 5.0,
                              unratedColor:
                                  AppTheme.of(context).accent1,
                              itemCount: 5,
                              itemSize: 24.0,
                              glowColor: AppTheme.of(context).primary,
                            ),
                            Text(
                              '\"Found an amazing electrician through\n\'My Trade Pal\' in just 30 minutes! The whole process was seamless and the work quality was excellent. - Sarah M.',
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryBackground,
                        borderRadius:
                            BorderRadius.circular(valueOrDefault<double>(
                          AppConstants.radius2,
                          0.0,
                        )),
                        border: Border.all(
                          color: AppTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            RatingBar.builder(
                              onRatingUpdate: (newValue) => safeSetState(
                                  () => _model.ratingBarValue2 = newValue),
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: AppTheme.of(context).primary,
                              ),
                              direction: Axis.horizontal,
                              initialRating: _model.ratingBarValue2 ??= 5.0,
                              unratedColor:
                                  AppTheme.of(context).accent1,
                              itemCount: 5,
                              itemSize: 24.0,
                              glowColor: AppTheme.of(context).primary,
                            ),
                            Text(
                              'The comments section is still static',
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}
