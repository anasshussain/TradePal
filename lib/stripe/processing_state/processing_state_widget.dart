import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '/providers/processing_state_provider.dart';
import '/viewmodels/processing_state_model.dart';
export '/viewmodels/processing_state_model.dart';

class ProcessingStateWidget extends StatefulWidget {
  const ProcessingStateWidget({super.key});

  static String routeName = 'ProcessingState';
  static String routePath = '/processingState';

  @override
  State<ProcessingStateWidget> createState() => _ProcessingStateWidgetState();
}

class _ProcessingStateWidgetState extends State<ProcessingStateWidget> {
  late ProcessingStateModel _model;
  final ProcessingStateProvider _provider = ProcessingStateProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProcessingStateModel());

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
    return ChangeNotifierProvider<ProcessingStateProvider>.value(
      value: _provider,
      child: Consumer<ProcessingStateProvider>(
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
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_rounded,
                            color: AppTheme.of(context).secondaryText,
                            size: 14.0,
                          ),
                          Text(
                            'SwiftPay Secure Checkout',
                            style: AppTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.3,
                                ),
                          ),
                        ].divide(SizedBox(width: 4.0)),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      children: [
                        Container(
                          width: 84.0,
                          height: 84.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0xFFF6F9FC),
                              width: 3.0,
                            ),
                          ),
                        ),
                        CircularPercentIndicator(
                          percent: 0.0,
                          radius: 42.0,
                          lineWidth: 4.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: AppTheme.of(context).primary,
                          backgroundColor:
                              AppTheme.of(context).alternate,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Processing payment',
                          style: AppTheme.of(context)
                              .headlineSmall
                              .override(
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
                                lineHeight: 1.3,
                              ),
                        ),
                        Text(
                          'Please don\'t close this window or refresh the page.',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color:
                                    AppTheme.of(context).secondaryText,
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
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ].divide(SizedBox(height: 32.0)),
                ),
              ),
              Spacer(),
              Container(
                width: 320.0,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: AppTheme.of(context).alternate,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Container(
                    child: Column(
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
                              'Total amount',
                              style: AppTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                            Text(
                              '\$142.00',
                              style: AppTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: AppTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: AppTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 16.0,
                          thickness: 1.0,
                          indent: 0.0,
                          endIndent: 0.0,
                          color: AppTheme.of(context).alternate,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 32.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F9FC),
                                borderRadius: BorderRadius.circular(4.0),
                                shape: BoxShape.rectangle,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.credit_card_rounded,
                                color: AppTheme.of(context).primaryText,
                                size: 14.0,
                              ),
                            ),
                            Text(
                              'Visa •••• 4242',
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
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Powered by',
                          style: AppTheme.of(context)
                              .labelSmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: AppTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                                color:
                                    AppTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .labelSmall
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .labelSmall
                                    .fontStyle,
                                lineHeight: 1.3,
                              ),
                        ),
                        SvgPicture.network(
                          'https://cdn.simpleicons.org/stripe/4f566b.svg',
                          width: 16.0,
                          height: 16.0,
                          fit: BoxFit.contain,
                        ),
                      ].divide(SizedBox(width: 4.0)),
                    ),
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
