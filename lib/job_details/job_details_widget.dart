import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/job_details_loader/job_details_loader_widget.dart';
import '/components/job_location_component/job_location_component_widget.dart';
import '/components/tradeperson_preview/tradeperson_preview_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'job_details_model.dart';
export 'job_details_model.dart';

class JobDetailsWidget extends StatefulWidget {
  const JobDetailsWidget({
    super.key,
    required this.jobId,
    required this.jobView,
  });

  final String? jobId;
  final JobDetailsView? jobView;

  static String routeName = 'job_details';
  static String routePath = '/jobDetails';

  @override
  State<JobDetailsWidget> createState() => _JobDetailsWidgetState();
}

class _JobDetailsWidgetState extends State<JobDetailsWidget> {
  late JobDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JobDetailsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.getJobDetails = await SupabaseTablesGroup.getJobDetailsCall.call(
        jobId: widget!.jobId,
      );

      if ((_model.getJobDetails?.succeeded ?? true)) {
        _model.fetchedJob = ((_model.getJobDetails?.jsonBody ?? '')
                .toList()
                .map<JobDataStruct?>(JobDataStruct.maybeFromMap)
                .toList() as Iterable<JobDataStruct?>)
            .withoutNulls
            ?.firstOrNull;
        safeSetState(() {});
        if (_model.fetchedJob?.customerId == currentUserUid) {
          _model.getApplicationList =
              await SupabaseTablesGroup.getSubmittedProposalsCall.call(
            params:
                'select=*,jobs!inner(*),users(device_token,total_reviews,average_rating)&job_id=eq.${widget!.jobId}&jobs.customer_id=eq.${currentUserUid}',
          );

          if ((_model.getApplicationList?.succeeded ?? true)) {
            _model.loading = false;
            _model.proposalsList = ((_model.getApplicationList?.jsonBody ?? '')
                    .toList()
                    .map<ProposalListStruct?>(ProposalListStruct.maybeFromMap)
                    .toList() as Iterable<ProposalListStruct?>)
                .withoutNulls
                .toList()
                .cast<ProposalListStruct>();
            safeSetState(() {});
          }
        } else {
          _model.getSubmittedJobData =
              await SupabaseTablesGroup.getSubmittedProposalsCall.call(
            params:
                'tradesperson_id=eq.${currentUserUid}&job_id=eq.${((_model.getJobDetails?.jsonBody ?? '').toList().map<JobDataStruct?>(JobDataStruct.maybeFromMap).toList() as Iterable<JobDataStruct?>).withoutNulls?.firstOrNull?.id}',
          );

          if (((_model.getSubmittedJobData?.jsonBody ?? '')
                  .toList()
                  .map<SubmittedProposalStruct?>(
                      SubmittedProposalStruct.maybeFromMap)
                  .toList() as Iterable<SubmittedProposalStruct?>)
              .withoutNulls
              .isNotEmpty) {
            _model.paymentStatus =
                await SupabaseTablesGroup.getProposalPaymentCall.call(
              jobId: widget!.jobId,
              tradepersonId: currentUserUid,
            );

            if ((_model.paymentStatus?.succeeded ?? true)) {
              if (SupabaseTablesGroup.getProposalPaymentCall.paymentStatus(
                    (_model.paymentStatus?.jsonBody ?? ''),
                  ) ==
                  PaymentStatus.paid.name) {
                await Future.wait([
                  Future(() async {
                    _model.isPaymentPaid = true;
                  }),
                  Future(() async {
                    _model.getUser = await SupabaseTablesGroup.getUserCall.call(
                      userId: ((_model.getJobDetails?.jsonBody ?? '')
                              .toList()
                              .map<JobDataStruct?>(JobDataStruct.maybeFromMap)
                              .toList() as Iterable<JobDataStruct?>)
                          .withoutNulls
                          ?.firstOrNull
                          ?.customerId,
                    );

                    if ((_model.getUser?.succeeded ?? true)) {
                      _model.user = ((_model.getUser?.jsonBody ?? '')
                              .toList()
                              .map<UserStruct?>(UserStruct.maybeFromMap)
                              .toList() as Iterable<UserStruct?>)
                          .withoutNulls
                          ?.firstOrNull;
                      safeSetState(() {});
                    }
                  }),
                ]);
              } else {
                _model.isPaymentPaid = false;
              }
            }
            _model.isProposalSubmitted = true;
            _model.loading = false;
            safeSetState(() {});
          } else {
            _model.isProposalSubmitted = false;
            _model.loading = false;
            safeSetState(() {});
          }
        }
      } else {
        await actions.showToast(
          context,
          'Failed to load details',
          2,
        );
      }
    });

    _model.quoteTextFieldTextController ??= TextEditingController();
    _model.quoteTextFieldFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      await actions.unsubscribe(
        'proposal_payments',
      );
    }();

    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: AppbarComponentWidget(
              title: 'Job Details',
              showAction: (_model.fetchedJob?.customerId == currentUserUid) &&
                  (_model.fetchedJob?.status == Status.ACTIVE),
              actionIcon: Icon(
                Icons.edit_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 26.0,
              ),
              action: () async {
                context.pushNamed(
                  AddJobWidget.routeName,
                  queryParameters: {
                    'jobData': serializeParam(
                      _model.fetchedJob,
                      ParamType.DataStruct,
                    ),
                    'location': serializeParam(
                      _model.jobLocationComponentModel.location,
                      ParamType.DataStruct,
                    ),
                  }.withoutNulls,
                  extra: <String, dynamic>{
                    '__transition_info__': TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.rightToLeft,
                    ),
                  },
                );
              },
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              if (!_model.loading!) {
                return Padding(
                  padding: EdgeInsets.all(valueOrDefault<double>(
                    FFAppConstants.parentPagePadding,
                    0.0,
                  )),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                _model.fetchedJob?.category,
                                'Unknown category',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(
                              width: FFAppConstants.parentPagePadding)),
                        ),
                        Text(
                          valueOrDefault<String>(
                            _model.fetchedJob?.title,
                            'Unknown Title',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .fontStyle,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            Text(
                              dateTimeFormat(
                                  "relative",
                                  functions.convertDateStringtoDateTIme(
                                      _model.fetchedJob!.createdAt)),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(
                              width: FlutterFlowTheme.of(context)
                                  .designToken
                                  .spacing
                                  .sm)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.currency_pound,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            Text(
                              'Fixed Price: ${valueOrDefault<String>(
                                _model.fetchedJob?.budgetMin?.toString(),
                                'Unknown category',
                              )}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(
                              width: FlutterFlowTheme.of(context)
                                  .designToken
                                  .spacing
                                  .sm)),
                        ),
                        Flexible(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .radius
                                      .md),
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(valueOrDefault<double>(
                                  FFAppConstants.childPadding,
                                  0.0,
                                )),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SCOPE OF WORK',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Text(
                                      _model.fetchedJob!.description,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.manrope(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(
                                      height: FFAppConstants.childSpacing)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .radius
                                      .lg),
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .lg),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(valueOrDefault<double>(
                                  FFAppConstants.childPadding,
                                  0.0,
                                )),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GALLERY',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final images = _model.fetchedJob?.images
                                                ?.toList() ??
                                            [];

                                        return Wrap(
                                          spacing: FFAppConstants.childSpacing,
                                          runSpacing:
                                              FFAppConstants.childSpacing,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          runAlignment: WrapAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          children: List.generate(images.length,
                                              (imagesIndex) {
                                            final imagesItem =
                                                images[imagesIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child:
                                                        FlutterFlowExpandedImageView(
                                                      image: CachedNetworkImage(
                                                        fadeInDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    300),
                                                        fadeOutDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    300),
                                                        imageUrl: imagesItem,
                                                        fit: BoxFit.contain,
                                                        errorWidget: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(
                                                          'assets/images/error_image.svg',
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                      allowRotation: false,
                                                      tag: imagesItem,
                                                      useHeroAnimation: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Hero(
                                                tag: imagesItem,
                                                transitionOnUserGestures: true,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(
                                                        milliseconds: 300),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 300),
                                                    imageUrl: imagesItem,
                                                    width: 100.0,
                                                    height: 100.0,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      'assets/images/error_image.svg',
                                                      width: 100.0,
                                                      height: 100.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  ].divide(SizedBox(
                                      height: FFAppConstants.childSpacing)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        wrapWithModel(
                          model: _model.jobLocationComponentModel,
                          updateCallback: () => safeSetState(() {}),
                          child: JobLocationComponentWidget(
                            locatioId: _model.fetchedJob!.locationId,
                          ),
                        ),
                        if (_model.fetchedJob?.customerId != currentUserUid)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      FlutterFlowTheme.of(context).primary,
                                      FlutterFlowTheme.of(context).secondary
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(-1.0, 0.14),
                                    end: AlignmentDirectional(1.0, -0.14),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .lg),
                                    topRight: Radius.circular(
                                        FlutterFlowTheme.of(context)
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
                                      FlutterFlowTheme.of(context)
                                          .designToken
                                          .radius
                                          .md),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      FlutterFlowTheme.of(context)
                                          .designToken
                                          .shadow
                                          .sm
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .md),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                  ),
                                  child: Form(
                                    key: _model.formKey,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(valueOrDefault<double>(
                                        FFAppConstants.parentPagePadding,
                                        0.0,
                                      )),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Submit Proposal',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleLarge
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Text(
                                                'Secure this project by providing your best\nquote and timeline.',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ].divide(SizedBox(
                                                height:
                                                    FlutterFlowTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .md)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'YOUR PROPOSED QUOTE',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                              ),
                                              TextFormField(
                                                controller: _model
                                                    .quoteTextFieldTextController,
                                                focusNode: _model
                                                    .quoteTextFieldFocusNode,
                                                autofocus: false,
                                                enabled: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  hintText: '100',
                                                  hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  prefixIcon: Icon(
                                                    Icons
                                                        .currency_pound_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                  ),
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                cursorColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                enableInteractiveSelection:
                                                    true,
                                                validator: _model
                                                    .quoteTextFieldTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ].divide(SizedBox(
                                                height:
                                                    FlutterFlowTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .md)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'ESTIMATED TIMELINE',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                              ),
                                              FlutterFlowChoiceChips(
                                                options: [
                                                  ChipData('0-3 days'),
                                                  ChipData('3-5 days'),
                                                  ChipData('1 Week'),
                                                  ChipData('2-3 Weeks')
                                                ],
                                                onChanged: (val) =>
                                                    safeSetState(() => _model
                                                            .choiceChipsValue =
                                                        val?.firstOrNull),
                                                selectedChipStyle: ChipStyle(
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                  iconSize: 16.0,
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                unselectedChipStyle: ChipStyle(
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .accent1,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                  iconColor: Colors.transparent,
                                                  iconSize: 16.0,
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                chipSpacing: 8.0,
                                                rowSpacing: 8.0,
                                                multiselect: false,
                                                alignment: WrapAlignment.start,
                                                controller: _model
                                                        .choiceChipsValueController ??=
                                                    FormFieldController<
                                                        List<String>>(
                                                  [],
                                                ),
                                                wrapped: true,
                                              ),
                                            ].divide(SizedBox(
                                                height:
                                                    FlutterFlowTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .md)),
                                          ),
                                          Text(
                                            'COVER LETTER / QUOTE DETAILS',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.manrope(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  FlutterFlowTheme.of(context)
                                                      .designToken
                                                      .spacing
                                                      .md),
                                              child: Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: _model
                                                      .descriptionTextController,
                                                  focusNode: _model
                                                      .descriptionFocusNode,
                                                  autofocus: false,
                                                  enabled: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                    hintText:
                                                        'Describe your experience with similar high-end ${valueOrDefault<String>(
                                                      SupabaseTablesGroup
                                                          .getJobDetailsCall
                                                          .title(
                                                        (_model.getJobDetails
                                                                ?.jsonBody ??
                                                            ''),
                                                      ),
                                                      'title',
                                                    )}',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .hint,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                  maxLines: 5,
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  enableInteractiveSelection:
                                                      true,
                                                  validator: _model
                                                      .descriptionTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (!_model.isProposalSubmitted! &&
                                              (widget!.jobView !=
                                                  JobDetailsView.chat))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  _model.formResult = true;
                                                  if (_model.formKey
                                                              .currentState ==
                                                          null ||
                                                      !_model
                                                          .formKey.currentState!
                                                          .validate()) {
                                                    safeSetState(() => _model
                                                        .formResult = false);
                                                    return;
                                                  }
                                                  if (_model.formResult!) {
                                                    _model.submitProposalAPi =
                                                        await SupabaseTablesGroup
                                                            .submitProposalCall
                                                            .call(
                                                      jobId: widget!.jobId,
                                                      tradespersonId:
                                                          currentUserUid,
                                                      message: _model
                                                          .descriptionTextController
                                                          .text,
                                                      quoteAmount: int.tryParse(
                                                          _model
                                                              .quoteTextFieldTextController
                                                              .text),
                                                      duration: _model
                                                          .choiceChipsValue,
                                                      status:
                                                          Status.PENDING.name,
                                                    );

                                                    if ((_model
                                                            .submitProposalAPi
                                                            ?.succeeded ??
                                                        true)) {
                                                      await Future.wait([
                                                        Future(() async {
                                                          await action_blocks
                                                              .insertNotifications(
                                                            context,
                                                            title:
                                                                'New Proposal Recieved',
                                                            message:
                                                                '${valueOrDefault<String>(
                                                              FFAppState()
                                                                  .userProfileCache
                                                                  .name,
                                                              'You',
                                                            )} has sent a job proposal',
                                                            type:
                                                                NotificationType
                                                                    .PROPOSAL
                                                                    .name,
                                                            userId:
                                                                currentUserUid,
                                                            referenceId: ((_model
                                                                            .getJobDetails
                                                                            ?.jsonBody ??
                                                                        '')
                                                                    .toList()
                                                                    .map<JobDataStruct?>(
                                                                        JobDataStruct
                                                                            .maybeFromMap)
                                                                    .toList() as Iterable<JobDataStruct?>)
                                                                .withoutNulls
                                                                ?.firstOrNull
                                                                ?.id,
                                                            recieverid: ((_model
                                                                            .getJobDetails
                                                                            ?.jsonBody ??
                                                                        '')
                                                                    .toList()
                                                                    .map<JobDataStruct?>(
                                                                        JobDataStruct
                                                                            .maybeFromMap)
                                                                    .toList() as Iterable<JobDataStruct?>)
                                                                .withoutNulls
                                                                ?.firstOrNull
                                                                ?.customerId,
                                                            extraData: <String,
                                                                dynamic>{
                                                              'member': <String,
                                                                  String>{
                                                                'username':
                                                                    '\"\"',
                                                                'avatarurl':
                                                                    '\"\"',
                                                                'jobid': '\"\"',
                                                                'member_id':
                                                                    '\"\"',
                                                                'member_name':
                                                                    '\"\"',
                                                                'member_avatar':
                                                                    '\"\"',
                                                              },
                                                            },
                                                          );
                                                        }),
                                                        Future(() async {
                                                          _model.assignedNotificationOutput =
                                                              await SupabaseEdgeFunctionsGroup
                                                                  .sendPushNotificationCall
                                                                  .call(
                                                            deviceToken: _model
                                                                .fetchedJob
                                                                ?.customer
                                                                ?.deviceToken,
                                                            title:
                                                                'New Proposal Received',
                                                            body:
                                                                '${FFAppState().userProfileCache.name} has sent a job proposal',
                                                            dataJson: {},
                                                          );
                                                        }),
                                                        Future(() async {
                                                          await actions
                                                              .showToast(
                                                            context,
                                                            'Proposal Submitted',
                                                            2,
                                                          );
                                                        }),
                                                      ]);
                                                      context.safePop();
                                                    } else {
                                                      await actions.showToast(
                                                        context,
                                                        'Failed to submit proposal, please try again later',
                                                        2,
                                                      );
                                                    }
                                                  }

                                                  safeSetState(() {});
                                                },
                                                text: 'Submit Proposal',
                                                icon: Icon(
                                                  Icons.send,
                                                  size: 30.0,
                                                ),
                                                options: FFButtonOptions(
                                                  width: 300.0,
                                                  height: 50.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconAlignment:
                                                      IconAlignment.end,
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .designToken
                                                              .radius
                                                              .lg),
                                                ),
                                              ),
                                            ),
                                          if (((FFAppState()
                                                          .userProfileCache
                                                          .userRole ==
                                                      2) &&
                                                  ((_model.isProposalSubmitted ==
                                                          true) &&
                                                      (((_model.getSubmittedJobData
                                                                              ?.jsonBody ??
                                                                          '')
                                                                      .toList()
                                                                      .map<SubmittedProposalStruct?>(
                                                                          SubmittedProposalStruct
                                                                              .maybeFromMap)
                                                                      .toList()
                                                                  as Iterable<
                                                                      SubmittedProposalStruct?>)
                                                              .withoutNulls
                                                              ?.firstOrNull
                                                              ?.status ==
                                                          Status.ACCEPTED
                                                              .name)) &&
                                                  (widget!.jobView !=
                                                      JobDetailsView.chat) &&
                                                  (_model.isPaymentPaid ==
                                                      true)) ||
                                              (FFAppState().paidJobId ==
                                                  widget!.jobId))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  _model.startChat =
                                                      await SupbaseRpcGroup
                                                          .getConversationBetweenUsersCall
                                                          .call(
                                                    userA: currentUserUid,
                                                    userB: ((_model.getJobDetails
                                                                        ?.jsonBody ??
                                                                    '')
                                                                .toList()
                                                                .map<JobDataStruct?>(
                                                                    JobDataStruct
                                                                        .maybeFromMap)
                                                                .toList()
                                                            as Iterable<
                                                                JobDataStruct?>)
                                                        .withoutNulls
                                                        ?.firstOrNull
                                                        ?.customerId,
                                                    jobId: widget!.jobId,
                                                  );

                                                  if ((_model.startChat
                                                          ?.succeeded ??
                                                      true)) {
                                                    await Future.wait([
                                                      Future(() async {
                                                        context.pushNamed(
                                                          ChatPageWidget
                                                              .routeName,
                                                          queryParameters: {
                                                            'conversationId':
                                                                serializeParam(
                                                              StartChatStruct.maybeFromMap((_model
                                                                          .startChat
                                                                          ?.jsonBody ??
                                                                      ''))
                                                                  ?.conversationId,
                                                              ParamType.String,
                                                            ),
                                                            'username':
                                                                serializeParam(
                                                              currentUserUid !=
                                                                      StartChatStruct.maybeFromMap((_model.startChat?.jsonBody ??
                                                                              ''))
                                                                          ?.userA
                                                                          ?.id
                                                                  ? StartChatStruct.maybeFromMap(
                                                                          (_model.startChat?.jsonBody ??
                                                                              ''))
                                                                      ?.userA
                                                                      ?.name
                                                                  : StartChatStruct.maybeFromMap(
                                                                          (_model.startChat?.jsonBody ??
                                                                              ''))
                                                                      ?.userB
                                                                      ?.name,
                                                              ParamType.String,
                                                            ),
                                                            'avatarUrl':
                                                                serializeParam(
                                                              currentUserUid !=
                                                                      StartChatStruct.maybeFromMap((_model.startChat?.jsonBody ??
                                                                              ''))
                                                                          ?.userA
                                                                          ?.id
                                                                  ? StartChatStruct.maybeFromMap(
                                                                          (_model.startChat?.jsonBody ??
                                                                              ''))
                                                                      ?.userA
                                                                      ?.avatarUrl
                                                                  : StartChatStruct.maybeFromMap(
                                                                          (_model.startChat?.jsonBody ??
                                                                              ''))
                                                                      ?.userB
                                                                      ?.avatarUrl,
                                                              ParamType.String,
                                                            ),
                                                            'jobid':
                                                                serializeParam(
                                                              widget!.jobId,
                                                              ParamType.String,
                                                            ),
                                                            'member':
                                                                serializeParam(
                                                              MembersStruct(
                                                                id: _model
                                                                    .user?.id,
                                                                name: _model
                                                                    .user?.name,
                                                                avatarUrl: _model
                                                                    .user
                                                                    ?.avatarUrl,
                                                                deviceToken: _model
                                                                    .user
                                                                    ?.deviceToken,
                                                              ),
                                                              ParamType
                                                                  .DataStruct,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      }),
                                                      Future(() async {
                                                        await action_blocks
                                                            .insertNotifications(
                                                          context,
                                                          title:
                                                              'Conversation Started by Trade Person',
                                                          message:
                                                              'Conversation started on this job: ${((_model.getJobDetails?.jsonBody ?? '').toList().map<JobDataStruct?>(JobDataStruct.maybeFromMap).toList() as Iterable<JobDataStruct?>).withoutNulls?.firstOrNull?.title}',
                                                          type: NotificationType
                                                              .APPLICATION.name,
                                                          userId:
                                                              currentUserUid,
                                                          referenceId:
                                                              widget!.jobId,
                                                          recieverid:
                                                              _model.user?.id,
                                                          extraData: <String,
                                                              dynamic>{
                                                            'member': <String,
                                                                String?>{
                                                              'username':
                                                                  '\"\"',
                                                              'avatarurl':
                                                                  '\"\"',
                                                              'jobid': '\"\"',
                                                              'member_id':
                                                                  '\"\"',
                                                              'member_name':
                                                                  '\"\"',
                                                              'member_avatar':
                                                                  '\"\"',
                                                            },
                                                          },
                                                        );
                                                      }),
                                                      Future(() async {
                                                        _model.messageNotificationRes =
                                                            await SupabaseEdgeFunctionsGroup
                                                                .sendPushNotificationCall
                                                                .call(
                                                          deviceToken: _model
                                                              .user
                                                              ?.deviceToken,
                                                          title:
                                                              'Conversation Started by Trade Person',
                                                          body:
                                                              'Conversation started on this job: ${((_model.getJobDetails?.jsonBody ?? '').toList().map<JobDataStruct?>(JobDataStruct.maybeFromMap).toList() as Iterable<JobDataStruct?>).withoutNulls?.firstOrNull?.title}',
                                                          dataJson: {},
                                                        );
                                                      }),
                                                    ]);
                                                  }

                                                  safeSetState(() {});
                                                },
                                                text: 'Chat',
                                                icon: Icon(
                                                  Icons.message_rounded,
                                                  size: 30.0,
                                                ),
                                                options: FFButtonOptions(
                                                  width: 300.0,
                                                  height: 50.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: Colors.transparent,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                          if (_model.isProposalSubmitted ??
                                              true)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed:
                                                    _model.isProposalSubmitted!
                                                        ? null
                                                        : () {
                                                            print(
                                                                'Button pressed ...');
                                                          },
                                                text: valueOrDefault<String>(
                                                  () {
                                                    if ((_model.isProposalSubmitted ==
                                                            true) &&
                                                        (((_model.getSubmittedJobData?.jsonBody ?? '')
                                                                        .toList()
                                                                        .map<SubmittedProposalStruct?>(SubmittedProposalStruct
                                                                            .maybeFromMap)
                                                                        .toList()
                                                                    as Iterable<
                                                                        SubmittedProposalStruct?>)
                                                                .withoutNulls
                                                                ?.firstOrNull
                                                                ?.status ==
                                                            Status.ACCEPTED
                                                                .name)) {
                                                      return 'Accepted';
                                                    } else if ((_model
                                                                .isProposalSubmitted ==
                                                            true) &&
                                                        (((_model.getSubmittedJobData?.jsonBody ??
                                                                        '')
                                                                    .toList()
                                                                    .map<SubmittedProposalStruct?>(SubmittedProposalStruct.maybeFromMap)
                                                                    .toList() as Iterable<SubmittedProposalStruct?>)
                                                                .withoutNulls
                                                                ?.firstOrNull
                                                                ?.status ==
                                                            Status.REJECTED.name)) {
                                                      return 'Rejected';
                                                    } else {
                                                      return 'Already Proposed';
                                                    }
                                                  }(),
                                                  'Already Proposed',
                                                ),
                                                icon: Icon(
                                                  Icons.check_circle_rounded,
                                                  size: 30.0,
                                                ),
                                                options: FFButtonOptions(
                                                  width: 300.0,
                                                  height: 50.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .designToken
                                                              .radius
                                                              .lg),
                                                ),
                                              ),
                                            ),
                                          if ((_model.isProposalSubmitted ==
                                                  true) &&
                                              (((_model.getSubmittedJobData
                                                                      ?.jsonBody ??
                                                                  '')
                                                              .toList()
                                                              .map<SubmittedProposalStruct?>(
                                                                  SubmittedProposalStruct
                                                                      .maybeFromMap)
                                                              .toList()
                                                          as Iterable<
                                                              SubmittedProposalStruct?>)
                                                      .withoutNulls
                                                      ?.firstOrNull
                                                      ?.status ==
                                                  Status.ACCEPTED.name))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: (_model
                                                            .isPaymentPaid! ||
                                                        (FFAppState()
                                                                .paidJobId ==
                                                            widget!.jobId))
                                                    ? null
                                                    : () async {
                                                        await actions
                                                            .unsubscribe(
                                                          'proposal_payments',
                                                        );
                                                        _model.paymentIntentResponse =
                                                            await CreatePaymentFeeCall
                                                                .call(
                                                          jobId: widget!.jobId,
                                                          token:
                                                              currentJwtToken,
                                                        );

                                                        if ((_model
                                                                .paymentIntentResponse
                                                                ?.succeeded ??
                                                            true)) {
                                                          await Future.delayed(
                                                            Duration(
                                                              milliseconds: 100,
                                                            ),
                                                          );
                                                          await actions
                                                              .subscribe(
                                                            'proposal_payments',
                                                            'stripe_payment_intent_id',
                                                            CreatePaymentFeeCall
                                                                .paymentIntentId(
                                                              (_model.paymentIntentResponse
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            )!,
                                                            'update',
                                                            () async {},
                                                          );
                                                          _model.paymentRes =
                                                              await actions
                                                                  .makePayment(
                                                            getJsonField(
                                                              (_model.paymentIntentResponse
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$.client_secret''',
                                                            ).toString(),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                text: _model.isPaymentPaid! ||
                                                        (FFAppState()
                                                                .paidJobId ==
                                                            widget!.jobId)
                                                    ? 'Payment Paid'
                                                    : 'Pay now',
                                                options: FFButtonOptions(
                                                  width: 300.0,
                                                  height: 50.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                        ]
                                            .divide(SizedBox(
                                                height:
                                                    FlutterFlowTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .xl))
                                            .addToEnd(SizedBox(
                                                height: FFAppConstants
                                                    .parentPagePadding)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (_model.proposalsList.isNotEmpty)
                          Builder(
                            builder: (context) {
                              final proposals = _model.proposalsList.toList();

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: proposals.length,
                                separatorBuilder: (_, __) => SizedBox(
                                    height: FlutterFlowTheme.of(context)
                                        .designToken
                                        .spacing
                                        .md),
                                itemBuilder: (context, proposalsIndex) {
                                  final proposalsItem =
                                      proposals[proposalsIndex];
                                  return TradepersonPreviewWidget(
                                    key: Key(
                                        'Keyw4o_${proposalsIndex}_of_${proposals.length}'),
                                    proposalsItem: proposalsItem,
                                    jobViewType: widget!.jobView!,
                                    callback: () async {
                                      _model.updateApiResult =
                                          await SupabaseTablesGroup
                                              .getSubmittedProposalsCall
                                              .call(
                                        params:
                                            'select=*,jobs!inner(*)&job_id=eq.${widget!.jobId}&jobs.customer_id=eq.${currentUserUid}',
                                      );

                                      if ((_model.updateApiResult?.succeeded ??
                                          true)) {
                                        _model.updateProposalsListAtIndex(
                                          proposalsIndex,
                                          (e) => e
                                            ..tradespersonId = (((_model
                                                                    .updateApiResult
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toList()
                                                            .map<SubmittedProposalStruct?>(
                                                                SubmittedProposalStruct
                                                                    .maybeFromMap)
                                                            .toList()
                                                        as Iterable<
                                                            SubmittedProposalStruct?>)
                                                    .withoutNulls
                                                    ?.elementAtOrNull(
                                                        proposalsIndex))
                                                ?.tradespersonId
                                            ..jobId = (((_model.updateApiResult
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toList()
                                                            .map<SubmittedProposalStruct?>(
                                                                SubmittedProposalStruct
                                                                    .maybeFromMap)
                                                            .toList()
                                                        as Iterable<
                                                            SubmittedProposalStruct?>)
                                                    .withoutNulls
                                                    ?.elementAtOrNull(
                                                        proposalsIndex))
                                                ?.jobId
                                            ..message = (((_model.updateApiResult
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toList()
                                                            .map<SubmittedProposalStruct?>(
                                                                SubmittedProposalStruct
                                                                    .maybeFromMap)
                                                            .toList()
                                                        as Iterable<
                                                            SubmittedProposalStruct?>)
                                                    .withoutNulls
                                                    ?.elementAtOrNull(
                                                        proposalsIndex))
                                                ?.message
                                            ..id = (((_model.updateApiResult
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toList()
                                                            .map<SubmittedProposalStruct?>(
                                                                SubmittedProposalStruct
                                                                    .maybeFromMap)
                                                            .toList()
                                                        as Iterable<
                                                            SubmittedProposalStruct?>)
                                                    .withoutNulls
                                                    ?.elementAtOrNull(
                                                        proposalsIndex))
                                                ?.id
                                            ..quoteAmount = (((_model
                                                                    .updateApiResult
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toList()
                                                            .map<SubmittedProposalStruct?>(
                                                                SubmittedProposalStruct
                                                                    .maybeFromMap)
                                                            .toList()
                                                        as Iterable<
                                                            SubmittedProposalStruct?>)
                                                    .withoutNulls
                                                    ?.elementAtOrNull(
                                                        proposalsIndex))
                                                ?.quoteAmount
                                            ..status = (((_model.updateApiResult
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toList()
                                                            .map<SubmittedProposalStruct?>(
                                                                SubmittedProposalStruct
                                                                    .maybeFromMap)
                                                            .toList()
                                                        as Iterable<
                                                            SubmittedProposalStruct?>)
                                                    .withoutNulls
                                                    ?.elementAtOrNull(
                                                        proposalsIndex))
                                                ?.status
                                            ..createdAt = (((_model.updateApiResult
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toList()
                                                            .map<SubmittedProposalStruct?>(
                                                                SubmittedProposalStruct
                                                                    .maybeFromMap)
                                                            .toList()
                                                        as Iterable<
                                                            SubmittedProposalStruct?>)
                                                    .withoutNulls
                                                    ?.elementAtOrNull(
                                                        proposalsIndex))
                                                ?.createdAt
                                            ..duration = (((_model.updateApiResult
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toList()
                                                            .map<SubmittedProposalStruct?>(
                                                                SubmittedProposalStruct
                                                                    .maybeFromMap)
                                                            .toList()
                                                        as Iterable<
                                                            SubmittedProposalStruct?>)
                                                    .withoutNulls
                                                    ?.elementAtOrNull(
                                                        proposalsIndex))
                                                ?.duration,
                                        );
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    onAccept: () async {
                                      _model.proposalAcceptedRes =
                                          await SupabaseTablesGroup
                                              .updateProposalStatusCall
                                              .call(
                                        status: Status.ACCEPTED.name,
                                        applicationId: proposalsItem.id,
                                      );

                                      if ((_model
                                              .proposalAcceptedRes?.succeeded ??
                                          true)) {
                                        await Future.wait([
                                          Future(() async {
                                            await action_blocks
                                                .insertNotifications(
                                              context,
                                              title:
                                                  'Congratulations Proposal Accepted',
                                              message:
                                                  'Complete your payment to start chatting with the customer.',
                                              type: NotificationType
                                                  .APPLICATION.name,
                                              userId: currentUserUid,
                                              referenceId: proposalsItem.jobId,
                                              recieverid:
                                                  proposalsItem.tradespersonId,
                                              extraData: <String, dynamic>{
                                                'member': <String, String?>{
                                                  'username': '\"\"',
                                                  'avatarurl': '\"\"',
                                                  'jobid': '\"\"',
                                                  'member_id': '\"\"',
                                                  'member_name': '\"\"',
                                                  'member_avatar': '\"\"',
                                                },
                                              },
                                            );
                                          }),
                                          Future(() async {
                                            _model.acceptedNotificationRes =
                                                await SupabaseEdgeFunctionsGroup
                                                    .sendPushNotificationCall
                                                    .call(
                                              deviceToken: proposalsItem
                                                  .users.deviceToken,
                                              title:
                                                  'Congratulations Proposal Accepted',
                                              body:
                                                  'Complete your payment to start chatting with the customer.',
                                              dataJson: {},
                                            );
                                          }),
                                          Future(() async {
                                            _model.updateProposalsListAtIndex(
                                              proposalsIndex,
                                              (e) => e
                                                ..status = Status.ACCEPTED.name,
                                            );
                                            safeSetState(() {});
                                          }),
                                          Future(() async {
                                            await actions.showToast(
                                              context,
                                              'Proposal accepted',
                                              2,
                                            );
                                          }),
                                        ]);
                                      }

                                      safeSetState(() {});
                                    },
                                    onReject: () async {
                                      _model.proposalRejectedRes =
                                          await SupabaseTablesGroup
                                              .updateProposalStatusCall
                                              .call(
                                        status: Status.REJECTED.name,
                                        applicationId: proposalsItem.id,
                                      );

                                      if ((_model
                                              .proposalRejectedRes?.succeeded ??
                                          true)) {
                                        await Future.wait([
                                          Future(() async {
                                            await actions.showToast(
                                              context,
                                              'Proposal rejected',
                                              2,
                                            );
                                          }),
                                          Future(() async {
                                            await action_blocks
                                                .insertNotifications(
                                              context,
                                              title:
                                                  'Proposal Rejected. Keep Applying!',
                                              message:
                                                  'No worries! There are many other jobs available. Try again.',
                                              type: NotificationType
                                                  .APPLICATION.name,
                                              userId: currentUserUid,
                                              referenceId: proposalsItem.jobId,
                                              recieverid:
                                                  proposalsItem.tradespersonId,
                                              extraData: <String, dynamic>{
                                                'member': <String, String?>{
                                                  'username': '\"\"',
                                                  'avatarurl': '\"\"',
                                                  'jobid': '\"\"',
                                                  'member_id': '\"\"',
                                                  'member_name': '\"\"',
                                                  'member_avatar': '\"\"',
                                                },
                                              },
                                            );
                                          }),
                                          Future(() async {
                                            _model.rejectedNotificationOutput =
                                                await SupabaseEdgeFunctionsGroup
                                                    .sendPushNotificationCall
                                                    .call(
                                              deviceToken: proposalsItem
                                                  .users.deviceToken,
                                              title:
                                                  'Proposal Rejected. Keep Applying!',
                                              body:
                                                  'No worries! There are many other jobs available. Try again.',
                                              dataJson: {},
                                            );
                                          }),
                                          Future(() async {
                                            _model.updateProposalsListAtIndex(
                                              proposalsIndex,
                                              (e) => e
                                                ..status = Status.REJECTED.name,
                                            );
                                            safeSetState(() {});
                                          }),
                                        ]);
                                      }

                                      safeSetState(() {});
                                    },
                                  );
                                },
                              );
                            },
                          ),
                      ]
                          .divide(SizedBox(height: FFAppConstants.childSpacing))
                          .addToEnd(SizedBox(height: 80.0)),
                    ),
                  ),
                );
              } else {
                return wrapWithModel(
                  model: _model.jobDetailsLoaderModel,
                  updateCallback: () => safeSetState(() {}),
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
