import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/password_changed_success_page_model.dart';
export '/viewmodels/password_changed_success_page_model.dart';

/// create a succes page after changing the password
///
class PasswordChangedSuccessPageWidget extends StatefulWidget {
  const PasswordChangedSuccessPageWidget({super.key});

  static String routeName = 'password_changed_success_page';
  static String routePath = '/passwordChangedSuccessPage';

  @override
  State<PasswordChangedSuccessPageWidget> createState() =>
      _PasswordChangedSuccessPageWidgetState();
}

class _PasswordChangedSuccessPageWidgetState
    extends State<PasswordChangedSuccessPageWidget> {
  late PasswordChangedSuccessPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PasswordChangedSuccessPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      color: Color(0x1A4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green,
                      size: 52.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                  child: Text(
                    'Password Changed!',
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontStyle: AppTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: AppTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: Text(
                    'Your password has been updated successfully. You can now use your new password to sign in to your account.',
                    textAlign: TextAlign.center,
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
                          fontStyle:
                              AppTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.6,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: const BoxDecoration(
                              color: Color(0x1A4CAF50),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lock_outlined,
                              color: Colors.green,
                              size: 22.0,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Security Tip',
                                  style: AppTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: AppTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 0.0),
                                  child: Text(
                                    'Never share your password with anyone. Use a unique password for each account.',
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
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ].divide(const SizedBox(width: 16.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
