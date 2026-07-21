import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/sign_in_provider_model.dart';
export '/viewmodels/sign_in_provider_model.dart';

class SignInProviderWidget extends StatefulWidget {
  const SignInProviderWidget({
    super.key,
    this.icon,
    this.title,
    this.action,
    this.width,
    this.color,
  });

  final Widget? icon;
  final String? title;
  final Future Function()? action;
  final double? width;
  final Color? color;

  @override
  State<SignInProviderWidget> createState() => _SignInProviderWidgetState();
}

class _SignInProviderWidgetState extends State<SignInProviderWidget> {
  late SignInProviderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignInProviderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            await widget.action?.call();
          },
          child: Container(
            width: valueOrDefault<double>(
              widget!.width,
              400.0,
            ),
            height: 50.0,
            constraints: BoxConstraints(
              maxWidth: 300.0,
            ),
            decoration: BoxDecoration(
              color: valueOrDefault<Color>(
                widget!.color,
                AppTheme.of(context).alternate,
              ),
              borderRadius: BorderRadius.circular(
                  AppTheme.of(context).designToken.radius.lg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget!.icon!,
                Text(
                  valueOrDefault<String>(
                    widget!.title,
                    'title',
                  ),
                  style: AppTheme.of(context).labelMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontStyle: AppTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            AppTheme.of(context).labelMedium.fontStyle,
                      ),
                ),
              ].divide(SizedBox(width: AppConstants.childPadding)),
            ),
          ),
        ),
      ],
    );
  }
}
