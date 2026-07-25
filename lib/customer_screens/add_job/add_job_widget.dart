import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/job_details_loader/job_details_loader_widget.dart';
import '/widgets/app_drop_down.dart';
import '/widgets/app_expanded_image_view.dart';
import '/widgets/app_icon_button.dart';
import '/widgets/app_place_picker.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/form_field_controller.dart';
import '/core/upload_data.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/providers/add_job_provider.dart';
import '/viewmodels/add_job_model.dart';
export '/viewmodels/add_job_model.dart';

class AddJobWidget extends StatefulWidget {
  const AddJobWidget({
    super.key,
    this.jobData,
    this.location,
  });

  final JobDataStruct? jobData;
  final LocationStruct? location;

  static String routeName = 'add_job';
  static String routePath = '/addJob';

  @override
  State<AddJobWidget> createState() => _AddJobWidgetState();
}

class _AddJobWidgetState extends State<AddJobWidget> {
  late AddJobModel _model;
  final AddJobProvider _provider = AddJobProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddJobModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget!.jobData!.images.isNotEmpty) {
        _provider.existingImages = widget!.jobData!.images.toList().cast<String>();
        _provider.notify();
      }
    });

    _model.jobTitleTextController ??=
        TextEditingController(text: widget!.jobData?.title);
    _model.jobTitleFocusNode ??= FocusNode();

    _model.budgetTextController ??=
        TextEditingController(text: widget!.jobData?.budgetMin?.toString());
    _model.budgetFocusNode ??= FocusNode();

    _model.descriptionTextController ??=
        TextEditingController(text: widget!.jobData?.description);
    _model.descriptionFocusNode ??= FocusNode();

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

    return ChangeNotifierProvider<AddJobProvider>.value(
      value: _provider,
      child: Consumer<AddJobProvider>(
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
              title: widget!.jobData != null ? 'Edit job' : 'Post a New Job',
              showAction: false,
              action: () async {},
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              if (!_provider.loading) {
                return Padding(
                  padding: EdgeInsets.all(valueOrDefault<double>(
                    AppConstants.parentPagePadding,
                    0.0,
                  )),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reach the best local tradespeople. Detail your requirements and set your budget to get started.',
                              style: AppTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: AppTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .bodyLarge
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                            ),
                          ],
                        ),
                        Form(
                          key: _model.formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Job title',
                                    style: AppTheme.of(context)
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
                                  ),
                                  TextFormField(
                                    controller: _model.jobTitleTextController,
                                    focusNode: _model.jobTitleFocusNode,
                                    autofocus: false,
                                    enabled: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: false,
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
                                                .secondaryText,
                                            fontSize: 12.0,
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
                                      hintText: 'e.g., Kitchen Pipe Repair',
                                      hintStyle: AppTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: AppTheme.of(context)
                                                .hint,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context)
                                              .primary,
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
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: AppTheme.of(context)
                                          .alternate,
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
                                        .jobTitleTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ].divide(SizedBox(
                                    height: AppConstants.childSpacing)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Category',
                                        style: AppTheme.of(context)
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
                                      ),
                                    ],
                                  ),
                                  AppDropDown<String>(
                                    controller:
                                        _model.categoryValueController ??=
                                            FormFieldController<String>(
                                      _model.categoryValue ??=
                                          widget!.jobData?.category,
                                    ),
                                    options: AppState().availableServices,
                                    onChanged: (val) => _provider.update(
                                        () => _model.categoryValue = val),
                                    width: double.infinity,
                                    maxHeight: 400.0,
                                    searchHintTextStyle:
                                        AppTheme.of(context)
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
                                    searchTextStyle:
                                        AppTheme.of(context)
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
                                    textStyle: AppTheme.of(context)
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
                                    hintText: 'Select job category',
                                    searchHintText: 'Plumbing..',
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    fillColor: AppTheme.of(context)
                                        .primaryBackground,
                                    elevation: 2.0,
                                    borderColor:
                                        AppTheme.of(context).border,
                                    borderWidth: 0.0,
                                    borderRadius: AppConstants.radius2,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 12.0, 0.0),
                                    hidesUnderline: true,
                                    isOverButton: false,
                                    isSearchable: true,
                                    isMultiSelect: false,
                                  ),
                                ].divide(SizedBox(
                                    height: AppConstants.childSpacing)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Budget',
                                    style: AppTheme.of(context)
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
                                  ),
                                  TextFormField(
                                    controller: _model.budgetTextController,
                                    focusNode: _model.budgetFocusNode,
                                    autofocus: false,
                                    enabled: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: false,
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
                                                .secondaryText,
                                            fontSize: 12.0,
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
                                      hintText: '500',
                                      hintStyle: AppTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  AppTheme.of(context)
                                                      .labelLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xff00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context)
                                              .primary,
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
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: AppTheme.of(context)
                                          .alternate,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.dollarSign,
                                          color: AppTheme.of(context)
                                              .primaryText,
                                          size: 14.0,
                                        ),
                                      ),
                                      prefixIconConstraints: const BoxConstraints(
                                        minWidth: 0,
                                        minHeight: 0,
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
                                        .budgetTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ].divide(const SizedBox(
                                    height: AppConstants.childSpacing)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DETAILED DESCRIPTION',
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
                                  TextFormField(
                                    controller:
                                        _model.descriptionTextController,
                                    focusNode: _model.descriptionFocusNode,
                                    autofocus: false,
                                    enabled: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: false,
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
                                                .secondaryText,
                                            fontSize: 12.0,
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
                                      hintText:
                                          'Describe the scope of work, materials \nneeded, and any specific deadlines...',
                                      hintStyle: AppTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: AppTheme.of(context)
                                                .hint,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context)
                                              .primary,
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
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: AppTheme.of(context)
                                          .alternate,
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
                                    maxLines: null,
                                    minLines: 4,
                                    cursorColor: AppTheme.of(context)
                                        .primaryText,
                                    enableInteractiveSelection: true,
                                    validator: _model
                                        .descriptionTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ].divide(SizedBox(
                                    height: AppConstants.childSpacing)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Number of quotes needed',
                                    style: AppTheme.of(context)
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
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: AppDropDown<String>(
                                          controller: _model
                                                  .quotesDropDownValueController ??=
                                              FormFieldController<String>(
                                            _model.quotesDropDownValue ??=
                                                widget!.jobData?.totalQuotes
                                                    ?.toString(),
                                          ),
                                          options: [
                                            '0',
                                            '1',
                                            '2',
                                            '3',
                                            '4',
                                            '5',
                                            '6',
                                            '7',
                                            '8',
                                            '9',
                                            '10'
                                          ],
                                          onChanged: (val) => _provider.update(() =>
                                              _model.quotesDropDownValue = val),
                                          width: double.infinity,
                                          height: 50.0,
                                          maxHeight: 400.0,
                                          textStyle: AppTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
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
                                          hintText: 'No of quotes',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: AppTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                          fillColor:
                                              AppTheme.of(context)
                                                  .secondaryBackground,
                                          elevation: 2.0,
                                          borderColor:
                                              AppTheme.of(context)
                                                  .border,
                                          borderWidth: 0.0,
                                          borderRadius: AppConstants.radius2,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 12.0, 0.0),
                                          hidesUnderline: true,
                                          isOverButton: false,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          '(Maximum 10 quotes)',
                                          style: AppTheme.of(context)
                                              .labelSmall
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    AppTheme.of(context)
                                                        .info,
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
                                    ].divide(SizedBox(
                                        width: AppConstants.childSpacing)),
                                  ),
                                ].divide(SizedBox(
                                    height: AppConstants.childSpacing)),
                              ),
                              AppPlacePicker(
                                iOSGoogleMapsApiKey:
                                    'AIzaSyB3KAslS8Z5mPjB-KgmwZWAZJ4n8f5gDOY',
                                androidGoogleMapsApiKey:
                                    'AIzaSyB3KAslS8Z5mPjB-KgmwZWAZJ4n8f5gDOY',
                                webGoogleMapsApiKey:
                                    'AIzaSyB3KAslS8Z5mPjB-KgmwZWAZJ4n8f5gDOY',
                                onSelect: (place) async {
                                  _provider.update(
                                      () => _model.placePickerValue = place);
                                },
                                defaultText: 'Select Location',
                                icon: Icon(
                                  Icons.place,
                                  color: AppTheme.of(context).hint,
                                  size: 30.0,
                                ),
                                buttonOptions: AppButtonOptions(
                                  width: double.infinity,
                                  height: 50.0,
                                  color: AppTheme.of(context)
                                      .secondaryBackground,
                                  textStyle: AppTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color:
                                            AppTheme.of(context).hint,
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
                                    color: AppTheme.of(context).border,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              if ((widget!.location != null) &&
                                  (_model.placePickerValue.address == null ||
                                      _model.placePickerValue.address == ''))
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SelectedAddress',
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
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context)
                                            .alternate,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            AppTheme.of(context)
                                                .designToken
                                                .spacing
                                                .md),
                                        child: Text(
                                          widget!.location != null
                                              ? valueOrDefault<String>(
                                                  '${widget!.location?.name},${widget!.location?.address}',
                                                  'unregistered location',
                                                )
                                              : '',
                                          style: AppTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(
                                      height: AppConstants.childSpacing)),
                                ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'JOB SITE PHOTOS',
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
                                          color: AppTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.3,
                                        ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      final selectedMedia = await selectMedia(
                                        imageQuality: 61,
                                        mediaSource: MediaSource.photoGallery,
                                        multiImage: true,
                                      );
                                      if (selectedMedia != null &&
                                          selectedMedia.every((m) =>
                                              validateFileFormat(
                                                  m.storagePath, context))) {
                                        _provider.update(() => _model
                                                .isDataUploading_attachedImageLocal =
                                            true);
                                        var selectedUploadedFiles =
                                            <UploadedFile>[];

                                        try {
                                          selectedUploadedFiles = selectedMedia
                                              .map((m) => UploadedFile(
                                                    name: m.storagePath
                                                        .split('/')
                                                        .last,
                                                    bytes: m.bytes,
                                                    height:
                                                        m.dimensions?.height,
                                                    width: m.dimensions?.width,
                                                    blurHash: m.blurHash,
                                                    originalFilename:
                                                        m.originalFilename,
                                                  ))
                                              .toList();
                                        } finally {
                                          _model.isDataUploading_attachedImageLocal =
                                              false;
                                        }
                                        if (selectedUploadedFiles.length ==
                                            selectedMedia.length) {
                                          _provider.update(() {
                                            _model.uploadedLocalFiles_attachedImageLocal =
                                                selectedUploadedFiles;
                                          });
                                        } else {
                                          _provider.notify();
                                          return;
                                        }
                                      }

                                      if (_model
                                          .uploadedLocalFiles_attachedImageLocal
                                          .isNotEmpty) {
                                        _provider.selectedImages = _model
                                            .uploadedLocalFiles_attachedImageLocal
                                            .toList()
                                            .cast<UploadedFile>();
                                        _provider.notify();
                                      }
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppTheme.of(context)
                                              .accent1,
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          border: Border.all(
                                            color: AppTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              valueOrDefault<double>(
                                            AppConstants.childPadding,
                                            0.0,
                                          )),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_a_photo_rounded,
                                                color:
                                                    AppTheme.of(context)
                                                        .primary,
                                                size: 30.0,
                                              ),
                                              Text(
                                                'Click to add images for reference',
                                                style: AppTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          AppTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 18.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(
                                    height: AppConstants.childSpacing)),
                              ),
                            ]
                                .divide(
                                    SizedBox(height: AppConstants.spacing))
                                .around(
                                    SizedBox(height: AppConstants.spacing)),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            final images = _provider.selectedImages.toList();

                            return Wrap(
                              spacing: AppConstants.childSpacing,
                              runSpacing: AppConstants.childSpacing,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              runAlignment: WrapAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              clipBehavior: Clip.none,
                              children:
                                  List.generate(images.length, (imagesIndex) {
                                final imagesItem = images[imagesIndex];
                                return Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 0.0,
                                      ),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: AppExpandedImageView(
                                              image: Image.memory(
                                                imagesItem.bytes ??
                                                    Uint8List.fromList([]),
                                                fit: BoxFit.contain,
                                              ),
                                              allowRotation: false,
                                              tag: 'imageTag1',
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: 'imageTag1',
                                        transitionOnUserGestures: true,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          child: Image.memory(
                                            imagesItem.bytes ??
                                                Uint8List.fromList([]),
                                            width: 200.0,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                        if (widget!.jobData != null)
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'Please note that after adding new images old images will be removed.',
                              textAlign: TextAlign.center,
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
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.all(AppTheme.of(context)
                              .designToken
                              .spacing
                              .sm),
                          child: Builder(
                            builder: (context) {
                              final existedImages =
                                  _provider.existingImages.toList();

                              return MasonryGridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                itemCount: existedImages.length,
                                shrinkWrap: true,
                                itemBuilder: (context, existedImagesIndex) {
                                  final existedImagesItem =
                                      existedImages[existedImagesIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: AppExpandedImageView(
                                            image: Image.network(
                                              existedImagesItem,
                                              fit: BoxFit.contain,
                                            ),
                                            allowRotation: false,
                                            tag: existedImagesItem,
                                            useHeroAnimation: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: existedImagesItem,
                                      transitionOnUserGestures: true,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          existedImagesItem,
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'BY POSTING, YOU AGREE TO OUR TERMS OF\nSERVICE',
                            textAlign: TextAlign.center,
                            style:
                                AppTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: AppTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
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
                          AppButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Button',
                            options: AppButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: AppTheme.of(context).primary,
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
                        if (widget!.jobData != null
                            ? (widget!.jobData?.status == Status.ACTIVE)
                            : true)
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: AppButton(
                              onPressed: () async {
                                _model.formValidation = true;
                                if (_model.formKey.currentState == null ||
                                    !_model.formKey.currentState!.validate()) {
                                  _provider.update(
                                      () => _model.formValidation = false);
                                  return;
                                }
                                if (_model.categoryValue == null) {
                                  await actions.showToast(
                                    context,
                                    'Job Category is required',
                                    2,
                                  );
                                  _model.formValidation = false;
                                  _provider.notify();
                                  return;
                                }
                                if (_model.quotesDropDownValue == null) {
                                  await actions.showToast(
                                    context,
                                    'Please add total quotes',
                                    2,
                                  );
                                  _model.formValidation = false;
                                  _provider.notify();
                                  return;
                                }
                                if (_model.uploadedLocalFiles_attachedImageLocal
                                    .any((file) =>
                                        file == null ||
                                        (file.bytes?.isEmpty ?? true))) {
                                  await actions.showToast(
                                    context,
                                    'Please upload work images',
                                    2,
                                  );
                                  _model.formValidation = false;
                                  _provider.notify();
                                  return;
                                }
                                if (_model.formValidation!) {
                                  if (_provider.selectedImages.isNotEmpty) {
                                    {
                                      _provider.update(() => _model
                                              .isDataUploading_uploadedImagesUrl =
                                          true);
                                      var selectedUploadedFiles =
                                          <UploadedFile>[];
                                      var selectedMedia = <SelectedFile>[];
                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles =
                                            _provider.selectedImages;
                                        selectedMedia =
                                            selectedFilesFromUploadedFiles(
                                          selectedUploadedFiles,
                                          storageFolderPath: 'user',
                                          isMultiData: true,
                                        );
                                        downloadUrls =
                                            await uploadSupabaseStorageFiles(
                                          bucketName: 'general',
                                          selectedFiles: selectedMedia,
                                        );
                                      } finally {
                                        _model.isDataUploading_uploadedImagesUrl =
                                            false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        _provider.update(() {
                                          _model.uploadedLocalFiles_uploadedImagesUrl =
                                              selectedUploadedFiles;
                                          _model.uploadedFileUrls_uploadedImagesUrl =
                                              downloadUrls;
                                        });
                                      } else {
                                        _provider.notify();
                                        return;
                                      }
                                    }

                                    for (int loop1Index = 0;
                                        loop1Index <
                                            _model
                                                .uploadedFileUrls_uploadedImagesUrl
                                                .length;
                                        loop1Index++) {
                                      final currentLoop1Item = _model
                                              .uploadedFileUrls_uploadedImagesUrl[
                                          loop1Index];
                                      _provider.addToTotalImages(currentLoop1Item);
                                    }
                                  }
                                  if (widget!.jobData == null) {
                                    if (_provider.totalImages.isNotEmpty) {
                                      _model.addPostResult =
                                          await SupbaseRpcGroup.addJobCall.call(
                                        title:
                                            _model.jobTitleTextController.text,
                                        lat: functions.getLatLng(
                                            0, _model.placePickerValue.latLng),
                                        lng: functions.getLatLng(
                                            1, _model.placePickerValue.latLng),
                                        city: _model.placePickerValue.city,
                                        zipCode:
                                            _model.placePickerValue.zipCode,
                                        state: _model.placePickerValue.state,
                                        country:
                                            _model.placePickerValue.country,
                                        userid: currentUserUid,
                                        description: _model
                                            .descriptionTextController.text,
                                        budget: int.tryParse(
                                            _model.budgetTextController.text),
                                        category: _model.categoryValue,
                                        totalQuotes: int.parse(
                                            (_model.quotesDropDownValue!)),
                                        imagesList: _provider.totalImages,
                                        name: _model.placePickerValue.name,
                                        address:
                                            _model.placePickerValue.address,
                                      );

                                      if ((_model.addPostResult?.succeeded ??
                                          true)) {
                                        await Future.wait([
                                          Future(() async {
                                            AppState().updateJobCacheStruct(
                                              (e) => e
                                                ..updateJobs(
                                                  (e) =>
                                                      e.add(JobsListItemStruct(
                                                    id: (_model.addPostResult
                                                                ?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    customerId: currentUserUid,
                                                    title: _model
                                                        .jobTitleTextController
                                                        .text,
                                                    description: _model
                                                        .descriptionTextController
                                                        .text,
                                                    budgetMin: double.tryParse(
                                                        _model
                                                            .budgetTextController
                                                            .text),
                                                    category:
                                                        _model.categoryValue,
                                                    images: _provider.totalImages,
                                                    createdAt:
                                                        getCurrentTimestamp
                                                            .toString(),
                                                  )),
                                                ),
                                            );
                                            AppState().update(() {});
                                          }),
                                          Future(() async {
                                            await actions.showToast(
                                              context,
                                              'Job Posted',
                                              2,
                                            );
                                          }),
                                          Future(() async {
                                            context.safePop();
                                          }),
                                        ]);
                                      } else {
                                        await actions.showToast(
                                          context,
                                          'Failed to post job',
                                          2,
                                        );
                                      }
                                    } else {
                                      await actions.showToast(
                                        context,
                                        'Please upload work images',
                                        2,
                                      );
                                    }
                                  } else {
                                    _model.updateJob = await SupbaseRpcGroup
                                        .updateJobRpcCall
                                        .call(
                                      jobId: widget!.jobData?.id,
                                      userId: currentUserUid,
                                      title: _model.jobTitleTextController.text,
                                      description:
                                          _model.descriptionTextController.text,
                                      budget: int.tryParse(
                                          _model.budgetTextController.text),
                                      category: _model.categoryValue,
                                      totalQuotes: _model.quotesDropDownValue,
                                      imagesList: _provider.totalImages.isNotEmpty
                                          ? _provider.totalImages
                                          : _provider.existingImages,
                                      address: _model.placePickerValue.address,
                                      name: _model.placePickerValue.name,
                                      country: _model.placePickerValue.country,
                                      state: _model.placePickerValue.state,
                                      zipCode: _model.placePickerValue.zipCode,
                                      city: _model.placePickerValue.city,
                                      lat: functions.getLatLng(
                                          0, _model.placePickerValue.latLng),
                                      lng: functions.getLatLng(
                                          1, _model.placePickerValue.latLng),
                                    );

                                    if ((_model.updateJob?.succeeded ?? true)) {
                                      await Future.wait([
                                        Future(() async {
                                          await actions.showToast(
                                            context,
                                            'Job updated',
                                            2,
                                          );
                                        }),
                                        Future(() async {
                                          context.safePop();
                                        }),
                                        Future(() async {
                                          await action_blocks.createJobActivity(
                                            context,
                                            jobid: widget!.jobData?.id,
                                            userid: currentUserUid,
                                            type: JobActivities.JOB_UPDATED,
                                          );
                                        }),
                                      ]);
                                    } else {
                                      await actions.showToast(
                                        context,
                                        'Failed to update job',
                                        2,
                                      );
                                    }
                                  }
                                }

                                _provider.notify();
                              },
                              text: widget!.jobData != null
                                  ? 'Update Job'
                                  : 'Post Job',
                              icon: Icon(
                                Icons.send_outlined,
                                size: 15.0,
                              ),
                              options: AppButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconAlignment: IconAlignment.end,
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: AppTheme.of(context).primary,
                                textStyle: AppTheme.of(context)
                                    .titleSmall
                                    .override(
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
                        Material(
                          color: Colors.transparent,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppTheme.of(context)
                                    .designToken
                                    .radius
                                    .md),
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).accent2,
                              boxShadow: [
                                AppTheme.of(context)
                                    .designToken
                                    .shadow
                                    .sm
                              ],
                              borderRadius: BorderRadius.circular(
                                  AppTheme.of(context)
                                      .designToken
                                      .radius
                                      .md),
                              border: Border.all(
                                color: AppTheme.of(context).alternate,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(valueOrDefault<double>(
                                AppConstants.spacing,
                                0.0,
                              )),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppIconButton(
                                        borderRadius: 8.0,
                                        buttonSize: 42.0,
                                        fillColor: AppTheme.of(context)
                                            .success,
                                        icon: Icon(
                                          Icons.tips_and_updates_outlined,
                                          color:
                                              AppTheme.of(context).info,
                                          size: 24.0,
                                        ),
                                        onPressed: () {
                                          print('IconButton pressed ...');
                                        },
                                      ),
                                      Text(
                                        'Pro Tips',
                                        style: AppTheme.of(context)
                                            .labelLarge
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  AppTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ].divide(SizedBox(
                                        width: AppConstants.childPadding)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check_circle_outlined,
                                        color: AppTheme.of(context)
                                            .success,
                                        size: 18.0,
                                      ),
                                      Text(
                                        'Detailed descriptions get 40% more\nquotes from top traders.',
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
                                              color:
                                                  AppTheme.of(context)
                                                      .primaryText,
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
                                      ),
                                    ].divide(SizedBox(
                                        width: AppConstants.childPadding)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check_circle_outlined,
                                        color: AppTheme.of(context)
                                            .success,
                                        size: 18.0,
                                      ),
                                      Text(
                                        'Adding photos helps traders estimate\ncosts more accurately.',
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
                                              color:
                                                  AppTheme.of(context)
                                                      .primaryText,
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
                                      ),
                                    ].divide(SizedBox(
                                        width: AppConstants.childPadding)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check_circle_outlined,
                                        color: AppTheme.of(context)
                                            .success,
                                        size: 18.0,
                                      ),
                                      Text(
                                        'Fair pricing attracts vetted professionals\nfaster.',
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
                                              color:
                                                  AppTheme.of(context)
                                                      .primaryText,
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
                                      ),
                                    ].divide(SizedBox(
                                        width: AppConstants.childPadding)),
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
                      ]
                          .divide(SizedBox(height: AppConstants.spacing))
                          .addToEnd(SizedBox(height: 80.0)),
                    ),
                  ),
                );
              } else {
                return wrapWithModel(
                  model: _model.jobDetailsLoaderModel,
                  updateCallback: () => _provider.notify(),
                  child: JobDetailsLoaderWidget(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}