import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/customer_navbar_model.dart';
export '/viewmodels/customer_navbar_model.dart';

/// can you create a navbar that has room for 5 icons, each one with a text
/// field below
class CustomerNavbarWidget extends StatefulWidget {
  const CustomerNavbarWidget({
    super.key,
    required this.selectedIndex,
  });

  final int? selectedIndex;

  @override
  State<CustomerNavbarWidget> createState() => _CustomerNavbarWidgetState();
}

class _CustomerNavbarWidgetState extends State<CustomerNavbarWidget> {
  late CustomerNavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerNavbarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        color: AppTheme.of(context).primaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 0.0,
            color: AppTheme.of(context).border,
            offset: const Offset(
              0.0,
              -1.0,
            ),
            spreadRadius: 0.0,
          )
        ],
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.goNamed(
                  CustomerDashboardWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': const TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              },
              child: Container(
                height: 50.0,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_rounded,
                      color: widget!.selectedIndex == 0
                          ? AppTheme.of(context).primary
                          : AppTheme.of(context).secondaryText,
                      size: 26.0,
                    ),
                    Text(
                      'Home',
                      style: AppTheme.of(context).labelSmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontStyle: AppTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: widget!.selectedIndex == 3
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).secondaryText,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w300,
                            fontStyle: AppTheme.of(context)
                                .labelSmall
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.goNamed(
                  CustomerInboxWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': const TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              },
              child: Container(
                height: 50.0,
                decoration: const BoxDecoration(),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_rounded,
                            color: widget!.selectedIndex == 1
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).secondaryText,
                            size: 26.0,
                          ),
                          Text(
                            'Chats',
                            style: AppTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w300,
                                    fontStyle: AppTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: widget!.selectedIndex == 3
                                      ? AppTheme.of(context).primary
                                      : AppTheme.of(context)
                                          .secondaryText,
                                  fontSize: 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: AppTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      if (AppState().totalMessagesCount > 0)
                        Container(
                          width: 14.0,
                          height: 14.0,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF3B30),
                            shape: BoxShape.circle,
                          ),
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                AppState().totalMessagesCount.toString(),
                                '0',
                              ),
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
                                    fontSize: 10.0,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.goNamed(
                  CustomerProfileWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': const TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              },
              child: Container(
                height: 50.0,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_3,
                      color: widget!.selectedIndex == 2
                          ? AppTheme.of(context).primary
                          : AppTheme.of(context).secondaryText,
                      size: 26.0,
                    ),
                    Text(
                      'Profile',
                      style: AppTheme.of(context).labelSmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontStyle: AppTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: widget!.selectedIndex == 4
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).secondaryText,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w300,
                            fontStyle: AppTheme.of(context)
                                .labelSmall
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
