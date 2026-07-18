import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/attachment_option_component_model.dart';
export '/viewmodels/attachment_option_component_model.dart';

class AttachmentOptionComponentWidget extends StatefulWidget {
  const AttachmentOptionComponentWidget({
    super.key,
    required this.action,
  });

  final Future Function()? action;

  @override
  State<AttachmentOptionComponentWidget> createState() =>
      _AttachmentOptionComponentWidgetState();
}

class _AttachmentOptionComponentWidgetState
    extends State<AttachmentOptionComponentWidget> {
  late AttachmentOptionComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttachmentOptionComponentModel());

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
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
              AppTheme.of(context).designToken.radius.md),
          topRight: Radius.circular(
              AppTheme.of(context).designToken.radius.md),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
          boxShadow: [AppTheme.of(context).designToken.shadow.sm],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
                AppTheme.of(context).designToken.radius.md),
            topRight: Radius.circular(
                AppTheme.of(context).designToken.radius.md),
          ),
          border: Border.all(
            color: AppTheme.of(context).alternate,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await widget.action?.call();
                },
                child: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AppIconButton(
                        borderRadius: 0.0,
                        buttonSize: 50.0,
                        fillColor: Colors.transparent,
                        icon: FaIcon(
                          FontAwesomeIcons.image,
                          color: AppTheme.of(context).primary,
                          size: 34.0,
                        ),
                        onPressed: () async {
                          await widget.action?.call();
                        },
                      ),
                      Text(
                        'Photos',
                        style:
                            AppTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppIconButton(
                      borderRadius: 0.0,
                      buttonSize: 50.0,
                      fillColor: Colors.transparent,
                      icon: FaIcon(
                        FontAwesomeIcons.fileAlt,
                        color: AppTheme.of(context).secondary,
                        size: 34.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                    Text(
                      'Files',
                      style: AppTheme.of(context).labelMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: AppTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: AppTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: AppTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
