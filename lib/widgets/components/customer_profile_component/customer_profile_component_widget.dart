import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/customer_profile_component_model.dart';
export '/viewmodels/customer_profile_component_model.dart';

class CustomerProfileComponentWidget extends StatefulWidget {
  const CustomerProfileComponentWidget({
    super.key,
    required this.icon,
    String? title,
    String? description,
    required this.onTap,
    Color? boxColor,
    bool? showSwitchBtn,
  })  : this.title = title ?? 'title',
        this.description = description ?? 'description',
        this.boxColor = boxColor ?? const Color(0xFF214FC7),
        this.showSwitchBtn = showSwitchBtn ?? false;

  final Widget? icon;
  final String title;
  final String description;
  final Future Function()? onTap;
  final Color boxColor;
  final bool showSwitchBtn;

  @override
  State<CustomerProfileComponentWidget> createState() =>
      _CustomerProfileComponentWidgetState();
}

class _CustomerProfileComponentWidgetState
    extends State<CustomerProfileComponentWidget> {
  late CustomerProfileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerProfileComponentModel());

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
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
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
                        color: widget!.boxColor,
                        borderRadius:
                            BorderRadius.circular(valueOrDefault<double>(
                          AppConstants.radius1,
                          0.0,
                        )),
                      ),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: widget!.icon!,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget!.title,
                        'title',
                      ),
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
                      valueOrDefault<String>(
                        widget!.description,
                        'description',
                      ),
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
                      height:
                          AppTheme.of(context).designToken.spacing.xs)),
                ),
              ].divide(SizedBox(
                  width: AppTheme.of(context).designToken.spacing.md)),
            ),
            if (widget!.showSwitchBtn != true)
              Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.of(context).primaryText,
                size: 24.0,
              ),
          ],
        ),
      ),
    );
  }
}
