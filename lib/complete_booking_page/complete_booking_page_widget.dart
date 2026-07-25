import '/widgets/components/countinue_booking/countinue_booking_widget.dart';
import '/widgets/components/trust_bullet4/trust_bullet4_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/complete_booking_page_provider.dart';
import '/viewmodels/complete_booking_page_model.dart';
export '/viewmodels/complete_booking_page_model.dart';

class CompleteBookingPageWidget extends StatefulWidget {
  const CompleteBookingPageWidget({super.key});

  static String routeName = 'complete_booking_page';
  static String routePath = '/completeBookingPage';

  @override
  State<CompleteBookingPageWidget> createState() =>
      _CompleteBookingPageWidgetState();
}

class _CompleteBookingPageWidgetState extends State<CompleteBookingPageWidget> {
  late CompleteBookingPageModel _model;
  final CompleteBookingPageProvider _provider = CompleteBookingPageProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompleteBookingPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.update(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    _provider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CompleteBookingPageProvider>.value(
      value: _provider,
      child: Consumer<CompleteBookingPageProvider>(
        builder: (context, _, __) => _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        body: Stack(
          alignment: const AlignmentDirectional(-1.0, -1.0),
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0x66000000),
                shape: BoxShape.rectangle,
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 32.0),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: Container(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 40.0,
                              height: 4.0,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(9999.0),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 64.0,
                              height: 64.0,
                              decoration: BoxDecoration(
                                color: const Color(0x1A635BFF),
                                borderRadius: BorderRadius.circular(9999.0),
                                shape: BoxShape.rectangle,
                              ),
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.lock_person_rounded,
                                color: AppTheme.of(context).primary,
                                size: 32.0,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Complete Booking',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .headlineSmall
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .headlineSmall
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: AppTheme.of(context)
                                            .headlineSmall
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                        lineHeight: 1.3,
                                      ),
                                ),
                                Text(
                                  'To continue with full chat, photos, and contact sharing, complete the booking first.',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: AppTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.5,
                                      ),
                                ),
                              ].divide(const SizedBox(height: 4.0)),
                            ),
                          ].divide(const SizedBox(height: 16.0)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F9FC),
                            borderRadius: BorderRadius.circular(16.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.trustBulletModel1,
                                    updateCallback: () => _provider.update(() {}),
                                    child: const TrustBullet4Widget(
                                      label: 'Share photos',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.trustBulletModel2,
                                    updateCallback: () => _provider.update(() {}),
                                    child: const TrustBullet4Widget(
                                      label: 'Share contact details',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.trustBulletModel3,
                                    updateCallback: () => _provider.update(() {}),
                                    child: const TrustBullet4Widget(
                                      label: 'Continue full chat securely',
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Booking Fee',
                                  style: AppTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .titleMedium
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        color: AppTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: AppTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                                Text(
                                  '£5',
                                  style: AppTheme.of(context)
                                      .titleLarge
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleLarge
                                                  .fontStyle,
                                        ),
                                        color: AppTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: AppTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                        lineHeight: 1.3,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outlined,
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  size: 14.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'This helps keep bookings secure for everyone.',
                                    style: AppTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ),
                              ].divide(const SizedBox(width: 4.0)),
                            ),
                          ].divide(const SizedBox(height: 4.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            wrapWithModel(
                              model: _model.buttonModel1,
                              updateCallback: () => _provider.update(() {}),
                              child: const CountinueBookingWidget(
                                content: 'Continue Booking',
                                iconPresent: false,
                                iconEndPresent: false,
                                variant: 'primary',
                                size: 'large',
                                fullWidth: true,
                                loading: false,
                                disabled: false,
                              ),
                            ),
                            wrapWithModel(
                              model: _model.buttonModel2,
                              updateCallback: () => _provider.update(() {}),
                              child: const CountinueBookingWidget(
                                content: 'Not Now',
                                iconPresent: false,
                                iconEndPresent: false,
                                variant: 'ghost',
                                size: 'medium',
                                fullWidth: true,
                                loading: false,
                                disabled: false,
                              ),
                            ),
                          ].divide(const SizedBox(height: 8.0)),
                        ),
                      ].divide(const SizedBox(height: 24.0)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
