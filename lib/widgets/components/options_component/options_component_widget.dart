import '/auth/supabase_auth/auth_util.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/options_component_model.dart';
export '/viewmodels/options_component_model.dart';

class OptionsComponentWidget extends StatefulWidget {
  const OptionsComponentWidget({
    super.key,
    this.widget,
  });

  final Widget Function()? widget;

  @override
  State<OptionsComponentWidget> createState() => _OptionsComponentWidgetState();
}

class _OptionsComponentWidgetState extends State<OptionsComponentWidget> {
  late OptionsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionsComponentModel());

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
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Container(
        width: 100.0,
        constraints: BoxConstraints(
          minHeight: 50.0,
        ),
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  GoRouter.of(context).prepareAuthEvent();
                  await authManager.signOut();
                  GoRouter.of(context).clearRedirectLocation();

                  await action_blocks.clearAppData(context);

                  context.goNamedAuth(
                    HomeWidget.routeName,
                    context.mounted,
                    extra: <String, dynamic>{
                      '__transition_info__': TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 400),
                      ),
                    },
                  );
                },
                child: Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(valueOrDefault<double>(
                      AppConstants.radius3,
                      0.0,
                    )),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      'Logout',
                      style: AppTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.manrope(
                              fontWeight: AppTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 12.0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
