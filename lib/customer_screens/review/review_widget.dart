import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/utils/enums/enums.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/user_preview_component/user_preview_component_widget.dart';
import '/widgets/app_expanded_image_view.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/upload_data.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/providers/review_provider.dart';
import '/viewmodels/review_model.dart';
export '/viewmodels/review_model.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({
    super.key,
    required this.name,
    required this.profileUrl,
    required this.jobid,
    required this.tradepersonId,
  });

  final String? name;
  final String? profileUrl;
  final String? jobid;
  final String? tradepersonId;

  static String routeName = 'review';
  static String routePath = '/review';

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  late ReviewModel _model;
  final ReviewProvider _provider = ReviewProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReviewModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.notify());
  }

  @override
  void dispose() {
    _model.dispose();
    _provider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return ChangeNotifierProvider<ReviewProvider>.value(
      value: _provider,
      child: Consumer<ReviewProvider>(
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
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => _provider.notify(),
            child: AppbarComponentWidget(
              title: '',
              showAction: false,
              action: () async {},
              extraWidget: () => UserPreviewComponentWidget(
                name: widget!.name!,
                avatarUrl: widget!.profileUrl!,
              ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          AppTheme.of(context).designToken.spacing.md,
                          0.0,
                          0.0),
                      child: Text(
                        'How was your experience?',
                        textAlign: TextAlign.center,
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
                              fontSize: 24.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: AppTheme.of(context)
                                  .headlineSmall
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ),
                  Text(
                    'Your review helps customers choose trusted trade professionals.',
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.normal,
                            fontStyle: AppTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: AppTheme.of(context).secondaryText,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              AppTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: AppTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Overall Experience',
                            textAlign: TextAlign.start,
                            style: AppTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      AppTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: AppTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                          ),
                          RatingBar.builder(
                            onRatingUpdate: (newValue) => safeSetState(
                                () => _model.overallExperienceValue = newValue),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: AppTheme.of(context).primary,
                            ),
                            direction: Axis.horizontal,
                            initialRating: _model.overallExperienceValue ??=
                                0.0,
                            itemCount: 5,
                            itemSize: 30.0,
                            glowColor: AppTheme.of(context).primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: AppTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Communication',
                            textAlign: TextAlign.start,
                            style: AppTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      AppTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: AppTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                          ),
                          RatingBar.builder(
                            onRatingUpdate: (newValue) => safeSetState(
                                () => _model.communicationValue = newValue),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: AppTheme.of(context).primary,
                            ),
                            direction: Axis.horizontal,
                            initialRating: _model.communicationValue ??= 0.0,
                            itemCount: 5,
                            itemSize: 30.0,
                            glowColor: AppTheme.of(context).primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: AppTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quality of Work ',
                            textAlign: TextAlign.start,
                            style: AppTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      AppTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: AppTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                          ),
                          RatingBar.builder(
                            onRatingUpdate: (newValue) => safeSetState(
                                () => _model.qualityOfWorkValue = newValue),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: AppTheme.of(context).primary,
                            ),
                            direction: Axis.horizontal,
                            initialRating: _model.qualityOfWorkValue ??= 0.0,
                            itemCount: 5,
                            itemSize: 30.0,
                            glowColor: AppTheme.of(context).primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: AppTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Punctuality ',
                            textAlign: TextAlign.start,
                            style: AppTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      AppTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: AppTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                          ),
                          RatingBar.builder(
                            onRatingUpdate: (newValue) => safeSetState(
                                () => _model.punctualityValue = newValue),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: AppTheme.of(context).primary,
                            ),
                            direction: Axis.horizontal,
                            initialRating: _model.punctualityValue ??= 0.0,
                            itemCount: 5,
                            itemSize: 30.0,
                            glowColor: AppTheme.of(context).primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: AppTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Write a Review',
                            style: AppTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      AppTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: AppTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                          ),
                          TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            autofocus: false,
                            enabled: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: false,
                              labelStyle: AppTheme.of(context)
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
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              hintText: 'Tell others about your experience...',
                              hintStyle: AppTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: AppTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context).hint,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: AppTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).primary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: AppTheme.of(context).alternate,
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
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            maxLength: 500,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor:
                                AppTheme.of(context).primaryText,
                            enableInteractiveSelection: true,
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: AppTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Job Completion Images (optional)',
                            style: AppTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      AppTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: AppTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            'Upload up to 2 images',
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
                                  color: AppTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                  lineHeight: 1.3,
                                ),
                          ),
                          AppButton(
                            onPressed: () async {
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                _provider.update(() => _model
                                    .isDataUploading_uploadeddImage = true);
                                var selectedUploadedFiles = <UploadedFile>[];

                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => UploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                            originalFilename:
                                                m.originalFilename,
                                          ))
                                      .toList();
                                } finally {
                                  _model.isDataUploading_uploadeddImage = false;
                                }
                                if (selectedUploadedFiles.length ==
                                    selectedMedia.length) {
                                  _provider.update(() {
                                    _model.uploadedLocalFile_uploadeddImage =
                                        selectedUploadedFiles.first;
                                  });
                                } else {
                                  _provider.notify();
                                  return;
                                }
                              }

                              if (_model.uploadedLocalFile_uploadeddImage !=
                                      null &&
                                  (_model.uploadedLocalFile_uploadeddImage.bytes
                                          ?.isNotEmpty ??
                                      false)) {
                                _provider.addToPhotoUrls(
                                    _model.uploadedLocalFile_uploadeddImage);
                                _provider.notify();
                              }
                            },
                            text: 'Add Photo',
                            icon: Icon(
                              Icons.photo_camera,
                              size: 15.0,
                            ),
                            options: AppButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: AppTheme.of(context).secondary,
                              textStyle: AppTheme.of(context)
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
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          if (_provider.photoUrls.isNotEmpty)
                            Container(
                              height: 100.0,
                              decoration: BoxDecoration(),
                              child: Builder(
                                builder: (context) {
                                  final imges = _provider.photoUrls
                                      .toList()
                                      .take(2)
                                      .toList();

                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imges.length,
                                    separatorBuilder: (_, __) => SizedBox(
                                        width: AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md),
                                    itemBuilder: (context, imgesIndex) {
                                      final imgesItem = imges[imgesIndex];
                                      return Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Container(
                                          width: 100.0,
                                          child: Stack(
                                            alignment: AlignmentDirectional(
                                                -1.0, -1.0),
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          AppExpandedImageView(
                                                        image: Image.memory(
                                                          imgesItem.bytes ??
                                                              Uint8List
                                                                  .fromList([]),
                                                          fit: BoxFit.contain,
                                                        ),
                                                        allowRotation: false,
                                                        tag: 'imageTag',
                                                        useHeroAnimation: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                  tag: 'imageTag',
                                                  transitionOnUserGestures:
                                                      true,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.memory(
                                                      imgesItem.bytes ??
                                                          Uint8List.fromList(
                                                              []),
                                                      width: 100.0,
                                                      height: 100.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: AppIconButton(
                                                  buttonSize: 30.0,
                                                  fillColor:
                                                      AppTheme.of(
                                                              context)
                                                          .accent2,
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: AppTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 14.0,
                                                  ),
                                                  onPressed: () async {
                                                    _provider.removeFromPhotoUrls(
                                                        imgesItem);
                                                    _provider.notify();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: AppButton(
                      onPressed: () async {
                        context.safePop();
                      },
                      text: 'SKIP',
                      options: AppButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Colors.transparent,
                        textStyle:
                            AppTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: AppTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: AppTheme.of(context).primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          0.0,
                          0.0,
                          valueOrDefault<double>(
                            AppConstants.childPadding,
                            0.0,
                          )),
                      child: AppButton(
                        onPressed: () async {
                          {
                            _provider.update(() => _model
                                .isDataUploading_uploadedImageUrls = true);
                            var selectedUploadedFiles = <UploadedFile>[];
                            var selectedMedia = <SelectedFile>[];
                            var downloadUrls = <String>[];
                            try {
                              selectedUploadedFiles = _provider.photoUrls;
                              selectedMedia = selectedFilesFromUploadedFiles(
                                selectedUploadedFiles,
                                storageFolderPath: 'user',
                                isMultiData: true,
                              );
                              downloadUrls = await uploadSupabaseStorageFiles(
                                bucketName: 'general',
                                selectedFiles: selectedMedia,
                              );
                            } finally {
                              _model.isDataUploading_uploadedImageUrls = false;
                            }
                            if (selectedUploadedFiles.length ==
                                    selectedMedia.length &&
                                downloadUrls.length == selectedMedia.length) {
                              _provider.update(() {
                                _model.uploadedLocalFiles_uploadedImageUrls =
                                    selectedUploadedFiles;
                                _model.uploadedFileUrls_uploadedImageUrls =
                                    downloadUrls;
                              });
                            } else {
                              _provider.notify();
                              return;
                            }
                          }

                          _model.addReviewResult =
                              await SupabaseTablesGroup.addReviewCall.call(
                            jobid: widget!.jobid,
                            reviewerId: AppState().userProfileCache.userKey,
                            reviewedUserId: widget!.tradepersonId,
                            comment: _model.textController.text,
                            overallRating:
                                _model.overallExperienceValue?.round(),
                            communicationRating:
                                _model.communicationValue?.round(),
                            qualityRating: _model.qualityOfWorkValue?.round(),
                            punctualityRating: _model.punctualityValue?.round(),
                            imageUrlList:
                                _model.uploadedFileUrls_uploadedImageUrls,
                          );

                          if ((_model.addReviewResult?.succeeded ?? true)) {
                            _model.updateTpRatingRpc = await SupbaseRpcGroup
                                .updateTradePersonRatingCall
                                .call(
                              pTradepersonId: widget!.tradepersonId,
                              authtoken: currentJwtToken,
                            );

                            await action_blocks.toast(
                              context,
                              message: 'Review submitted',
                              type: MessageType.SUCCESS,
                            );
                          } else {
                            await action_blocks.toast(
                              context,
                              message: 'Review submition failed',
                              type: MessageType.ERROR,
                            );
                          }

                          context.safePop();

                          _provider.notify();
                        },
                        text: 'Submit Feedback',
                        icon: Icon(
                          Icons.feedback_outlined,
                          size: 15.0,
                        ),
                        options: AppButtonOptions(
                          width: double.infinity,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: AppTheme.of(context).primary,
                          textStyle:
                              AppTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(
                              AppTheme.of(context)
                                  .designToken
                                  .radius
                                  .lg),
                        ),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 14.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}