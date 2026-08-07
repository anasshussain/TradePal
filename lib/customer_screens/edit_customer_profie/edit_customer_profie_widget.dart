import 'package:cached_network_image/cached_network_image.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/widgets/app_uk_phone_prefix.dart';
import '/core/utils/upload_data.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/edit_customer_profie_provider.dart';
import '/viewmodels/edit_customer_profie_model.dart';
export '/viewmodels/edit_customer_profie_model.dart';

/// The backend stores unset address fields as a literal "EMPTY"/"empty"
/// placeholder string rather than null, with inconsistent casing across
/// fields. Comparing case-/whitespace-insensitively catches all of them so
/// the placeholder never leaks into a text field as real-looking text.
String _stripEmptyPlaceholder(String value) =>
    value.trim().toLowerCase() == 'empty' ? '' : value;

class EditCustomerProfieWidget extends StatefulWidget {
  const EditCustomerProfieWidget({super.key});

  static String routeName = 'edit_customer_profie';
  static String routePath = '/edit_customer_profile';

  @override
  State<EditCustomerProfieWidget> createState() =>
      _EditCustomerProfieWidgetState();
}

class _EditCustomerProfieWidgetState extends State<EditCustomerProfieWidget> {
  late EditCustomerProfieModel _model;
  final EditCustomerProfieProvider _provider = EditCustomerProfieProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasChanges = false;

  void _markChanged() {
    if (!_hasChanges) {
      _hasChanges = true;
      _provider.notify();
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditCustomerProfieModel());

    _model.textController1 ??=
        TextEditingController(text: AppState().userProfileCache.name);
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??=
        TextEditingController(text: AppState().userProfileCache.email);
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??=
        TextEditingController(text: AppState().userProfileCache.phone);
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.streetTextController ??= TextEditingController(
        text: _stripEmptyPlaceholder(AppState().userProfileCache.street));
    _model.streetFocusNode ??= FocusNode();

    _model.streetadressTextController ??= TextEditingController(
        text:
            _stripEmptyPlaceholder(AppState().userProfileCache.streetaddress));
    _model.streetadressFocusNode ??= FocusNode();
    _model.postalcodeTextController ??= TextEditingController(
        text: _stripEmptyPlaceholder(AppState().userProfileCache.zipcode));
    _model.postalcodeFocusNode ??= FocusNode();

    _model.textController1!.addListener(_markChanged);
    _model.textController3!.addListener(_markChanged);
    _model.streetTextController!.addListener(_markChanged);
    _model.streetadressTextController!.addListener(_markChanged);
    _model.postalcodeTextController!.addListener(_markChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.notify());
  }

  @override
  void dispose() {
    _model.textController1?.removeListener(_markChanged);
    _model.textController3?.removeListener(_markChanged);
    _model.streetTextController?.removeListener(_markChanged);
    _model.streetadressTextController?.removeListener(_markChanged);
    _model.postalcodeTextController?.removeListener(_markChanged);
    _model.dispose();
    _provider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return ChangeNotifierProvider<EditCustomerProfieProvider>.value(
      value: _provider,
      child: Consumer<EditCustomerProfieProvider>(
        builder: (context, _, __) => _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    String _resolveAvatarUrl() {
      final uploaded = _model.uploadedFileUrl_uploaded;
      if (uploaded != null && uploaded.trim().isNotEmpty) {
        return uploaded;
      }
      final cached = AppState().userProfileCache.avatarUrl;
      if (cached.trim().isNotEmpty) {
        return cached;
      }
      return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpRGUcBVltEkFutN21fIqebRvrgP7fOv4CjcNwuka3BtXR_-jhpd7GheJ_RkvMtSsnsA8&usqp=CAU';
    }

    final bool _canSave = _hasChanges && !_model.isDataUploading_uploaded;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => _provider.notify(),
            child: AppbarComponentWidget(
              title: 'Edit Profile',
              showAction: false,
              actionIcon: null,
              action: () async {},
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          // top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(valueOrDefault<double>(
                  AppConstants.parentPagePadding,
                  0.0,
                )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        children: [
                          Material(
                            color: Colors.transparent,
                            elevation: 4.0,
                            shadowColor: Colors.black.withOpacity(0.25),
                            shape: const CircleBorder(),
                            child: Container(
                              width: 128.0,
                              height: 128.0,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).secondaryBackground,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: _model.uploadedLocalFile_uploaded
                                            ?.bytes !=
                                        null
                                    ? Image.memory(
                                        _model
                                            .uploadedLocalFile_uploaded!.bytes!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                          Icons.person,
                                          size: 50.0,
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        key: ValueKey(_resolveAvatarUrl()),
                                        imageUrl: _resolveAvatarUrl(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                            width: 24.0,
                                            height: 24.0,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                              color:
                                                  AppTheme.of(context).primary,
                                            ),
                                          ),
                                        ),
                                        errorWidget:
                                            (context, url, error) => Icon(
                                          Icons.person,
                                          size: 50.0,
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.34, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 97.0, 7.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  final selectedMedia = await selectMedia(
                                    storageFolderPath: 'user',
                                    mediaSource: MediaSource.photoGallery,
                                    multiImage: false,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    final localFile = UploadedFile(
                                      name: selectedMedia.first.storagePath
                                          .split('/')
                                          .last,
                                      bytes: selectedMedia.first.bytes,
                                      height: selectedMedia
                                          .first.dimensions?.height,
                                      width:
                                          selectedMedia.first.dimensions?.width,
                                      blurHash: selectedMedia.first.blurHash,
                                      originalFilename:
                                          selectedMedia.first.originalFilename,
                                    );

                                    // Turant UI update — koi wait nahi
                                    _provider.update(() {
                                      _model.uploadedLocalFile_uploaded =
                                          localFile;
                                      _model.isDataUploading_uploaded = true;
                                      _hasChanges = true;
                                    });

                                    uploadSupabaseStorageFiles(
                                      bucketName: 'general',
                                      selectedFiles: selectedMedia,
                                    ).then((downloadUrls) {
                                      if (downloadUrls.isNotEmpty) {
                                        _provider.update(() {
                                          _model.uploadedFileUrl_uploaded =
                                              downloadUrls.first;
                                          _model.isDataUploading_uploaded =
                                              false;
                                        });
                                      } else {
                                        _provider.update(() => _model
                                            .isDataUploading_uploaded = false);
                                      }
                                    });
                                  }
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 3.0,
                                  shadowColor: Colors.black.withOpacity(0.3),
                                  shape: const CircleBorder(),
                                  child: Container(
                                    width: 32.0,
                                    height: 32.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: const Icon(
                                      Icons.photo_camera_outlined,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Material(
                        color: Colors.transparent,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppTheme.of(context).designToken.radius.lg),
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(
                                AppTheme.of(context).designToken.radius.lg),
                            border: Border.all(
                              color: AppTheme.of(context).alternate,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                AppTheme.of(context).designToken.spacing.xl),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, -1.0),
                                  child: Text(
                                    'FULL NAME',
                                    style: AppTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: AppTheme.of(context)
                                                .labelSmall
                                                .fontWeight,
                                            fontStyle: AppTheme.of(context)
                                                .labelSmall
                                                .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: AppTheme.of(context)
                                              .labelSmall
                                              .fontWeight,
                                          fontStyle: AppTheme.of(context)
                                              .labelSmall
                                              .fontStyle,
                                        ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 54.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).alternate,
                                      borderRadius: BorderRadius.circular(0.0),
                                      border: Border.all(
                                        color: AppTheme.of(context).alternate,
                                      ),
                                    ),
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .sm),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model.textController1,
                                            focusNode:
                                                _model.textFieldFocusNode1,
                                            autofocus: false,
                                            enabled: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle: AppTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          AppTheme.of(context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: AppTheme.of(context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                              hintText: 'name',
                                              hintStyle: AppTheme.of(context).labelMedium.override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                                  ),
                                                  color: AppTheme.of(context).hint,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            style: AppTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.manrope(
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                            cursorColor: AppTheme.of(context)
                                                .primaryText,
                                            enableInteractiveSelection: true,
                                            validator: _model
                                                .textController1Validator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md,
                                        0.0,
                                        0.0),
                                    child: Text(
                                      'EMAIL ADDRESS',
                                      style: AppTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: AppTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: AppTheme.of(context)
                                                .labelSmall
                                                .fontWeight,
                                            fontStyle: AppTheme.of(context)
                                                .labelSmall
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 54.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).alternate,
                                      borderRadius: BorderRadius.circular(0.0),
                                      border: Border.all(
                                        color: AppTheme.of(context).alternate,
                                      ),
                                    ),
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .sm),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model.textController2,
                                            focusNode:
                                                _model.textFieldFocusNode2,
                                            autofocus: false,
                                            enabled: true,
                                            readOnly: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          AppTheme.of(context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              hintText: 'email',
                                              hintStyle: AppTheme.of(context).labelMedium.override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                                  ),
                                                  color: AppTheme.of(context).hint,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            style: AppTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.manrope(
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                            cursorColor: AppTheme.of(context)
                                                .primaryText,
                                            enableInteractiveSelection: true,
                                            validator: _model
                                                .textController2Validator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md,
                                        0.0,
                                        0.0),
                                    child: Text(
                                      'Email cannot be changed manually. Contact support for assistance.',
                                      style: AppTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: AppTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: AppTheme.of(context)
                                                .labelSmall
                                                .fontWeight,
                                            fontStyle: AppTheme.of(context)
                                                .labelSmall
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md,
                                        0.0,
                                        0.0),
                                    child: Text(
                                      'PHONE NUMBER',
                                      style: AppTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: AppTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: AppTheme.of(context)
                                                .labelSmall
                                                .fontWeight,
                                            fontStyle: AppTheme.of(context)
                                                .labelSmall
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 54.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).alternate,
                                      borderRadius: BorderRadius.circular(0.0),
                                      border: Border.all(
                                        color: AppTheme.of(context).alternate,
                                      ),
                                    ),
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .sm),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model.textController3,
                                            focusNode:
                                                _model.textFieldFocusNode3,
                                            autofocus: false,
                                            enabled: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              prefixIcon:
                                                  const AppUkPhonePrefix(),
                                              prefixIconConstraints:
                                                  const BoxConstraints(
                                                      minWidth: 0,
                                                      minHeight: 0),
                                              labelStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          AppTheme.of(context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              hintText: 'phone',
                                              hintStyle: AppTheme.of(context).labelMedium.override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                                  ),
                                                  color: AppTheme.of(context).hint,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            style: AppTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.manrope(
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                            cursorColor: AppTheme.of(context)
                                                .primaryText,
                                            enableInteractiveSelection: true,
                                            validator: _model
                                                .textController3Validator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(
                                  height: AppTheme.of(context)
                                      .designToken
                                      .spacing
                                      .md)),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppTheme.of(context).designToken.radius.lg),
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(
                                AppTheme.of(context).designToken.radius.lg),
                            border: Border.all(
                              color: AppTheme.of(context).alternate,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                AppTheme.of(context).designToken.spacing.xl),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: AppTheme.of(context).accent1,
                                      size: 24.0,
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                          -1.0, -1.0),
                                      child: Text(
                                        'SERVICE ADDRESS',
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
                                              letterSpacing: 0.0,
                                              fontWeight: AppTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ].divide(SizedBox(
                                      width: AppTheme.of(context)
                                          .designToken
                                          .spacing
                                          .sm)),
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        AppTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md,
                                        0.0,
                                        0.0),
                                    child: Text(
                                      'STREET',
                                      style: AppTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: AppTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: AppTheme.of(context)
                                                .labelSmall
                                                .fontWeight,
                                            fontStyle: AppTheme.of(context)
                                                .labelSmall
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 54.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).alternate,
                                      borderRadius: BorderRadius.circular(0.0),
                                      border: Border.all(
                                        color: AppTheme.of(context).alternate,
                                      ),
                                    ),
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .sm),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller:
                                                _model.streetTextController,
                                            focusNode: _model.streetFocusNode,
                                            autofocus: false,
                                            enabled: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          AppTheme.of(context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              hintStyle: AppTheme.of(context).labelMedium.override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                                  ),
                                                  color: AppTheme.of(context).hint,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            style: AppTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.manrope(
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                            cursorColor: AppTheme.of(context)
                                                .primaryText,
                                            enableInteractiveSelection: true,
                                            validator: _model
                                                .streetTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0,
                                      AppTheme.of(context)
                                          .designToken
                                          .spacing
                                          .md,
                                      0.0,
                                      0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    -1.0, -1.0),
                                            child: Text(
                                              'STREET ADDRESS',
                                              style: AppTheme.of(context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          AppTheme.of(context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                            child: Container(
                                              width: 130.0,
                                              height: 54.0,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context)
                                                    .alternate,
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                border: Border.all(
                                                  color: AppTheme.of(context)
                                                      .alternate,
                                                ),
                                              ),
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0.0, 0.0),
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      AppTheme.of(context)
                                                          .designToken
                                                          .spacing
                                                          .sm),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .streetadressTextController,
                                                      focusNode: _model
                                                          .streetadressFocusNode,
                                                      autofocus: false,
                                                      enabled: true,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            AppTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintStyle: AppTheme.of(context).labelMedium.override(
                                                            font: GoogleFonts.inter(
                                                              fontWeight: FontWeight.normal,
                                                              fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                                            ),
                                                            color: AppTheme.of(context).hint,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.normal,
                                                            fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: AppTheme.of(
                                                                    context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: AppTheme.of(
                                                                    context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                      style:
                                                          AppTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .manrope(
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: AppTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: AppTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                      cursorColor:
                                                          AppTheme.of(context)
                                                              .primaryText,
                                                      enableInteractiveSelection:
                                                          true,
                                                      validator: _model
                                                          .streetadressTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(
                                            height: AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .md)),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    -1.0, -1.0),
                                            child: Text(
                                              'POSTAL CODE',
                                              style: AppTheme.of(context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          AppTheme.of(context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                            child: Container(
                                              width: 130.0,
                                              height: 54.0,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context)
                                                    .alternate,
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                border: Border.all(
                                                  color: AppTheme.of(context)
                                                      .alternate,
                                                ),
                                              ),
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0.0, 0.0),
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      AppTheme.of(context)
                                                          .designToken
                                                          .spacing
                                                          .sm),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .postalcodeTextController,
                                                      focusNode: _model
                                                          .postalcodeFocusNode,
                                                      autofocus: false,
                                                      enabled: true,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            AppTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight: AppTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintStyle: AppTheme.of(context).labelMedium.override(
                                                            font: GoogleFonts.inter(
                                                              fontWeight: FontWeight.normal,
                                                              fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                                            ),
                                                            color: AppTheme.of(context).hint,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.normal,
                                                            fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: AppTheme.of(
                                                                    context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: AppTheme.of(
                                                                    context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                      style:
                                                          AppTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .manrope(
                                                                  fontWeight: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: AppTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: AppTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                      cursorColor:
                                                          AppTheme.of(context)
                                                              .primaryText,
                                                      enableInteractiveSelection:
                                                          true,
                                                      validator: _model
                                                          .postalcodeTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(
                                            height: AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .md)),
                                      ),
                                    ],
                                  ),
                                ),
                              ].divide(SizedBox(
                                  height: AppTheme.of(context)
                                      .designToken
                                      .spacing
                                      .md)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            AppTheme.of(context).designToken.spacing.md,
                            0.0,
                            0.0),
                        child: AppButton(
                          onPressed: !_canSave
                              ? null
                              : () async {
                                  _model.updateUserResult =
                                      await SupabaseTablesGroup.updateUserCall
                                          .call(
                                    profileImage: _model
                                                    .uploadedFileUrl_uploaded !=
                                                null &&
                                            _model.uploadedFileUrl_uploaded !=
                                                ''
                                        ? _model.uploadedFileUrl_uploaded
                                        : AppState().userProfileCache.avatarUrl,
                                    userId: currentUserUid,
                                    name: _model.textController1.text,
                                    phone: _model.textController3.text,
                                    street: _model.streetTextController.text,
                                    zipcode:
                                        _model.postalcodeTextController.text,
                                    streetAddress:
                                        _model.streetadressTextController.text,
                                  );

                                  if ((_model.updateUserResult?.succeeded ??
                                      true)) {
                                    await Future.wait([
                                      Future(() async {
                                        AppState().updateUserProfileCacheStruct(
                                          (e) => e
                                            ..avatarUrl =
                                                _model.uploadedFileUrl_uploaded !=
                                                            null &&
                                                        _model.uploadedFileUrl_uploaded !=
                                                            ''
                                                    ? _model
                                                        .uploadedFileUrl_uploaded
                                                    : AppState()
                                                        .userProfileCache
                                                        .avatarUrl
                                            ..name = _model.textController1.text
                                            ..phone =
                                                _model.textController3.text
                                            ..street =
                                                _model.streetTextController.text
                                            ..zipcode = _model
                                                .postalcodeTextController.text
                                            ..streetaddress = _model
                                                .streetadressTextController
                                                .text,
                                        );
                                        _provider.notify();
                                      }),
                                      Future(() async {
                                        await actions.showToast(
                                          context,
                                          'updated successfully',
                                          2,
                                        );
                                      }),
                                      Future(() async {
                                        context.goNamed(
                                          CustomerProfileWidget.routeName,
                                          extra: <String, dynamic>{
                                            '__transition_info__':
                                                const TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      }),
                                    ]);
                                  } else {
                                    await actions.showToast(
                                      context,
                                      'update failed',
                                      2,
                                    );
                                  }
                                  _provider.notify();
                                },
                          text: 'Save',
                          options: AppButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: _canSave
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).alternate,
                            textStyle: AppTheme.of(context).titleSmall.override(
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
                                  fontStyle:
                                      AppTheme.of(context).titleSmall.fontStyle,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(
                                AppTheme.of(context).designToken.radius.lg),
                          ),
                        ),
                      ),
                    ]
                        .divide(
                            const SizedBox(height: AppConstants.childSpacing))
                        .addToEnd(const SizedBox(height: 50.0)),
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
