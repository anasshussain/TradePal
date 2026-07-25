import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/stripe_connect_account_success_provider.dart';
import '/viewmodels/stripe_connect_account_success_model.dart';
export '/viewmodels/stripe_connect_account_success_model.dart';

class StripeConnectAccountSuccessWidget extends StatefulWidget {
  const StripeConnectAccountSuccessWidget({super.key});

  static String routeName = 'stripe_connectAccount_success';
  static String routePath = '/stripeConnectAccountSuccess';

  @override
  State<StripeConnectAccountSuccessWidget> createState() =>
      _StripeConnectAccountSuccessWidgetState();
}

class _StripeConnectAccountSuccessWidgetState
    extends State<StripeConnectAccountSuccessWidget> {
  late StripeConnectAccountSuccessModel _model;
  final StripeConnectAccountSuccessProvider _provider = StripeConnectAccountSuccessProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StripeConnectAccountSuccessModel());

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
    return ChangeNotifierProvider<StripeConnectAccountSuccessProvider>.value(
      value: _provider,
      child: Consumer<StripeConnectAccountSuccessProvider>(
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
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).success,
                        shape: BoxShape.circle,
                      ),
                      child: const Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 60.0,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Stripe Connected!',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context)
                              .headlineLarge
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: AppTheme.of(context)
                                      .headlineLarge
                                      .fontStyle,
                                ),
                                color: AppTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: AppTheme.of(context)
                                    .headlineLarge
                                    .fontStyle,
                              ),
                        ),
                        Text(
                          'Your Stripe account has been successfully connected. You can now start accepting payments from your customers.',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context)
                              .bodyLarge
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: AppTheme.of(context)
                                      .bodyLarge
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                ),
                                color:
                                    AppTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .bodyLarge
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodyLarge
                                    .fontStyle,
                                lineHeight: 1.5,
                              ),
                        ),
                      ].divide(const SizedBox(height: 16.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              AppTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: AppTheme.of(context).success,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Payment Processing',
                                    style: AppTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ].divide(const SizedBox(width: 12.0)),
                              ),
                              Text(
                                'Accept credit cards, debit cards, and digital wallets',
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
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              Divider(
                                thickness: 1.0,
                                color: AppTheme.of(context).alternate,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.security,
                                    color: AppTheme.of(context).success,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Secure Transactions',
                                    style: AppTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ].divide(const SizedBox(width: 12.0)),
                              ),
                              Text(
                                'Industry-leading security and fraud protection',
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
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              Divider(
                                thickness: 1.0,
                                color: AppTheme.of(context).alternate,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.analytics,
                                    color: AppTheme.of(context).success,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Real-time Analytics',
                                    style: AppTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ].divide(const SizedBox(width: 12.0)),
                              ),
                              Text(
                                'Track payments and revenue in your dashboard',
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
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(const SizedBox(height: 12.0)),
                          ),
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(height: 32.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
