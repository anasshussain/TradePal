import '/widgets/components/action_tile3/action_tile3_widget.dart';
import '/widgets/components/cancel_button/cancel_button_widget.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/bottom_sheet_attachment_component_model.dart';
export '/viewmodels/bottom_sheet_attachment_component_model.dart';

class BottomSheetAttachmentComponentWidget extends StatefulWidget {
  const BottomSheetAttachmentComponentWidget({
    super.key,
    this.onPhotoTapped,
  });

  final Future Function()? onPhotoTapped;

  @override
  State<BottomSheetAttachmentComponentWidget> createState() =>
      _BottomSheetAttachmentComponentWidgetState();
}

class _BottomSheetAttachmentComponentWidgetState
    extends State<BottomSheetAttachmentComponentWidget> {
  late BottomSheetAttachmentComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomSheetAttachmentComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional(-1.0, -1.0),
      children: [
        Align(
          alignment: AlignmentDirectional(0.0, 1.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 32.0, 24.0, 32.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: Container(
                        alignment: AlignmentDirectional(0.0, 0.0),
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Share Content',
                          style: AppTheme.of(context)
                              .titleLarge
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: AppTheme.of(context)
                                      .titleLarge
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                                color: AppTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .titleLarge
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .titleLarge
                                    .fontStyle,
                                lineHeight: 1.3,
                              ),
                        ),
                        AppIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          fillColor: Colors.transparent,
                          icon: Icon(
                            Icons.close_rounded,
                            color: AppTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await widget.onPhotoTapped?.call();
                                },
                                child: wrapWithModel(
                                  model: _model.actionTileModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ActionTile3Widget(
                                    bgColor: Color(0x1A635BFF),
                                    icon: Icon(
                                      Icons.photo_library_rounded,
                                      color:
                                          AppTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                    iconColor:
                                        AppTheme.of(context).primary,
                                    label: 'Photos',
                                  ),
                                ),
                              ),
                            ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                              Expanded(
                                flex: 1,
                                child: wrapWithModel(
                                  model: _model.actionTileModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ActionTile3Widget(
                                    bgColor: Color(0x1A00D4FF),
                                    icon: Icon(
                                      Icons.photo_camera_rounded,
                                      color:
                                          AppTheme.of(context).tertiary,
                                      size: 24.0,
                                    ),
                                    iconColor:
                                        AppTheme.of(context).tertiary,
                                    label: 'Camera',
                                  ),
                                ),
                              ),
                            Expanded(
                              flex: 1,
                              child: wrapWithModel(
                                model: _model.actionTileModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: ActionTile3Widget(
                                  bgColor:
                                      AppTheme.of(context).alternate,
                                  icon: Icon(
                                    Icons.description_rounded,
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  iconColor:
                                      AppTheme.of(context).alternate,
                                  label: 'Document',
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 16.0)),
                        ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                              ))
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.actionTileModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ActionTile3Widget(
                                      bgColor: Color(0x1ADF1B41),
                                      icon: Icon(
                                        Icons.location_on_rounded,
                                        color:
                                            AppTheme.of(context).error,
                                        size: 24.0,
                                      ),
                                      iconColor:
                                          AppTheme.of(context).error,
                                      label: 'Location',
                                    ),
                                  ),
                                ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.actionTileModel5,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ActionTile3Widget(
                                      bgColor: Color(0x1AFFB84D),
                                      icon: Icon(
                                        Icons.person_rounded,
                                        color: AppTheme.of(context)
                                            .warning,
                                        size: 24.0,
                                      ),
                                      iconColor:
                                          AppTheme.of(context).warning,
                                      label: 'Contact',
                                    ),
                                  ),
                                ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.actionTileModel6,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ActionTile3Widget(
                                      bgColor: Color(0x1A0A2540),
                                      icon: Icon(
                                        Icons.bar_chart_rounded,
                                        color: AppTheme.of(context)
                                            .secondary,
                                        size: 24.0,
                                      ),
                                      iconColor: AppTheme.of(context)
                                          .secondary,
                                      label: 'Poll',
                                    ),
                                  ),
                                ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Files',
                            style: AppTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: AppTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration(milliseconds: 0),
                                      fadeOutDuration:
                                          Duration(milliseconds: 0),
                                      imageUrl:
                                          'https://dimg.dreamflow.cloud/v1/image/modern%20architecture%20building',
                                      fit: BoxFit.cover,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration(milliseconds: 0),
                                      fadeOutDuration:
                                          Duration(milliseconds: 0),
                                      imageUrl:
                                          'https://dimg.dreamflow.cloud/v1/image/abstract%20blue%20gradient%20texture',
                                      fit: BoxFit.cover,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration(milliseconds: 0),
                                      fadeOutDuration:
                                          Duration(milliseconds: 0),
                                      imageUrl:
                                          'https://dimg.dreamflow.cloud/v1/image/forest%20mountains%20landscape',
                                      fit: BoxFit.cover,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration(milliseconds: 0),
                                      fadeOutDuration:
                                          Duration(milliseconds: 0),
                                      imageUrl:
                                          'https://dimg.dreamflow.cloud/v1/image/minimalist%20interior%20design',
                                      fit: BoxFit.cover,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration(milliseconds: 0),
                                      fadeOutDuration:
                                          Duration(milliseconds: 0),
                                      imageUrl:
                                          'https://dimg.dreamflow.cloud/v1/image/city%20street%20at%20night',
                                      fit: BoxFit.cover,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: wrapWithModel(
                          model: _model.buttonModel,
                          updateCallback: () => safeSetState(() {}),
                          child: CancelButtonWidget(
                            content: 'Cancel',
                            iconPresent: false,
                            iconEndPresent: false,
                            variant: 'ghost',
                            size: 'large',
                            fullWidth: true,
                            loading: false,
                            disabled: false,
                          ),
                        ),
                      ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      Container(
                        height: 16.0,
                      ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
