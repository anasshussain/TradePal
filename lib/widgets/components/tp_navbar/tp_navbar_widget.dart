import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/tp_navbar_model.dart';
export '/viewmodels/tp_navbar_model.dart';

class TpNavbarWidget extends StatefulWidget {
  const TpNavbarWidget({
    super.key,
    required this.selectedIndex,
  });

  final int? selectedIndex;

  @override
  State<TpNavbarWidget> createState() => _TpNavbarWidgetState();
}

class _TpNavbarWidgetState extends State<TpNavbarWidget> {
  late TpNavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TpNavbarModel());

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
            offset: Offset(
              0.0,
              -1.0,
            ),
            spreadRadius: 0.0,
          )
        ],
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  BrowseJobsWidget.routeName,
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
                      Icons.list,
                      color: widget!.selectedIndex == 0
                          ? AppTheme.of(context).primary
                          : AppTheme.of(context).secondaryText,
                      size: 26.0,
                    ),
                    Text(
                      'Browse',
                      style: AppTheme.of(context).labelSmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle: AppTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: widget!.selectedIndex == 0
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).secondaryText,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
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
                  TpMyJobsWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              },
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work_rounded,
                      color: widget!.selectedIndex == 1
                          ? AppTheme.of(context).primary
                          : AppTheme.of(context).secondaryText,
                      size: 26.0,
                    ),
                    Text(
                      'My jobs',
                      style: AppTheme.of(context).labelSmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle: AppTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: widget!.selectedIndex == 1
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).secondaryText,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
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
                  TpInboxWidget.routeName,
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
                decoration: BoxDecoration(),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_rounded,
                            color: widget!.selectedIndex == 2
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
                                    fontWeight: FontWeight.w500,
                                    fontStyle: AppTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: widget!.selectedIndex == 2
                                      ? AppTheme.of(context).primary
                                      : AppTheme.of(context)
                                          .secondaryText,
                                  fontSize: 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
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
                  TraderProfileWidget.routeName,
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
                      color: widget!.selectedIndex == 3
                          ? AppTheme.of(context).primary
                          : AppTheme.of(context).secondaryText,
                      size: 26.0,
                    ),
                    Text(
                      'Profie',
                      style: AppTheme.of(context).labelSmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle: AppTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: widget!.selectedIndex == 3
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).secondaryText,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
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
