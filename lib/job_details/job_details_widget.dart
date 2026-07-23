import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/job_details_loader/job_details_loader_widget.dart';
import '/widgets/components/job_location_component/job_location_component_widget.dart';
import '/widgets/components/tradeperson_preview/tradeperson_preview_widget.dart';
import '/widgets/app_choice_chips.dart';
import '/widgets/app_expanded_image_view.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/form_field_controller.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/providers/job_details_provider.dart';
import '/viewmodels/job_details_model.dart';
export '/viewmodels/job_details_model.dart';

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
  final JobDetailsProvider _provider = JobDetailsProvider();

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
        _provider.fetchedJob = ((_model.getJobDetails?.jsonBody ?? '')
                .toList()
                .map<JobDataStruct?>(JobDataStruct.maybeFromMap)
                .toList() as Iterable<JobDataStruct?>)
            .withoutNulls
            ?.firstOrNull;
        _provider.notify();
        if (_provider.fetchedJob?.customerId == currentUserUid) {
          _model.getApplicationList =
              await SupabaseTablesGroup.getSubmittedProposalsCall.call(
            params:
                'select=*,jobs!inner(*),users(device_token,total_reviews,average_rating)&job_id=eq.${widget!.jobId}&jobs.customer_id=eq.${currentUserUid}',
          );

          if ((_model.getApplicationList?.succeeded ?? true)) {
            _provider.loading = false;
            _provider.proposalsList = ((_model.getApplicationList?.jsonBody ?? '')
                    .toList()
                    .map<ProposalListStruct?>(ProposalListStruct.maybeFromMap)
                    .toList() as Iterable<ProposalListStruct?>)
                .withoutNulls
                .toList()
                .cast<ProposalListStruct>();
            _provider.notify();
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
                    _provider.isPaymentPaid = true;
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
                      _provider.user = ((_model.getUser?.jsonBody ?? '')
                              .toList()
                              .map<UserStruct?>(UserStruct.maybeFromMap)
                              .toList() as Iterable<UserStruct?>)
                          .withoutNulls
                          ?.firstOrNull;
                      _provider.notify();
                    }
                  }),
                ]);
              } else {
                _provider.isPaymentPaid = false;
              }
            }
            _provider.isProposalSubmitted = true;
            _provider.loading = false;
            _provider.notify();
          } else {
            _provider.isProposalSubmitted = false;
            _provider.loading = false;
            _provider.notify();
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

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.notify());
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
    _provider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return ChangeNotifierProvider<JobDetailsProvider>.value(
      value: _provider,
      child: Consumer<JobDetailsProvider>(
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
              title: 'Job Details',
              showAction: (_provider.fetchedJob?.customerId == currentUserUid) &&
                  (_provider.fetchedJob?.status == Status.ACTIVE),
              actionIcon: Icon(
                Icons.edit_rounded,
                color: AppTheme.of(context).secondaryText,
                size: 26.0,
              ),
              action: () async {
                context.pushNamed(
                  AddJobWidget.routeName,
                  queryParameters: {
                    'jobData': serializeParam(
                      _provider.fetchedJob,
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
              if (!_provider.loading!) {
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                _provider.fetchedJob?.category,
                                'Unknown category',
                              ),
                              style: AppTheme.of(context)
                                  .bodySmall
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: AppTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: AppTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(
                              width: AppConstants.parentPagePadding)),
                        ),
                        Text(
                          valueOrDefault<String>(
                            _provider.fetchedJob?.title,
                            'Unknown Title',
                          ),
                          style: AppTheme.of(context)
                              .displaySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: AppTheme.of(context)
                                      .displaySmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .displaySmall
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: AppTheme.of(context)
                                    .displaySmall
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .displaySmall
                                    .fontStyle,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: AppTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            Text(
                              dateTimeFormat(
                                  "relative",
                                  functions.convertDateStringtoDateTIme(
                                      _provider.fetchedJob!.createdAt)),
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(
                              width: AppTheme.of(context)
                                  .designToken
                                  .spacing
                                  .sm)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.currency_pound,
                              color: AppTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            Text(
                              'Fixed Price: ${valueOrDefault<String>(
                                _provider.fetchedJob?.budgetMin?.toString(),
                                'Unknown category',
                              )}',
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(
                              width: AppTheme.of(context)
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
                                  AppTheme.of(context)
                                      .designToken
                                      .radius
                                      .md),
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context)
                                    .secondaryBackground,
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
                                  AppConstants.childPadding,
                                  0.0,
                                )),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SCOPE OF WORK',
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
                                    Text(
                                      _provider.fetchedJob!.description,
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
                                    ),
                                  ].divide(SizedBox(
                                      height: AppConstants.childSpacing)),
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
                                  AppTheme.of(context)
                                      .designToken
                                      .radius
                                      .lg),
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(
                                    AppTheme.of(context)
                                        .designToken
                                        .radius
                                        .lg),
                                border: Border.all(
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(valueOrDefault<double>(
                                  AppConstants.childPadding,
                                  0.0,
                                )),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GALLERY',
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
                                    Builder(
                                      builder: (context) {
                                        final images = _provider.fetchedJob?.images
                                                ?.toList() ??
                                            [];

                                        return Wrap(
                                          spacing: AppConstants.childSpacing,
                                          runSpacing:
                                              AppConstants.childSpacing,
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
                                                        AppExpandedImageView(
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
                                      height: AppConstants.childSpacing)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        wrapWithModel(
                          model: _model.jobLocationComponentModel,
                          updateCallback: () => _provider.notify(),
                          child: JobLocationComponentWidget(
                            locatioId: _provider.fetchedJob!.locationId,
                          ),
                        ),
                        if (_provider.fetchedJob?.customerId != currentUserUid)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.of(context).primary,
                                      AppTheme.of(context).secondary
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(-1.0, 0.14),
                                    end: AlignmentDirectional(1.0, -0.14),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        AppTheme.of(context)
                                            .designToken
                                            .radius
                                            .lg),
                                    topRight: Radius.circular(
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
                                    color: AppTheme.of(context)
                                        .secondaryBackground,
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
                                      color: AppTheme.of(context)
                                          .alternate,
                                    ),
                                  ),
                                  child: Form(
                                    key: _model.formKey,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(valueOrDefault<double>(
                                        AppConstants.parentPagePadding,
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
                                                style: AppTheme.of(
                                                        context)
                                                    .titleLarge
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          AppTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Text(
                                                'Secure this project by providing your best\nquote and timeline.',
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
                                            ].divide(SizedBox(
                                                height:
                                                    AppTheme.of(context)
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
                                                    AppTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                          letterSpacing: 0.0,
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
                                                  labelStyle: AppTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  hintText: '100',
                                                  hintStyle: AppTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
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
                                                          AppTheme.of(
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
                                                          AppTheme.of(
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
                                                      AppTheme.of(
                                                              context)
                                                          .alternate,
                                                  prefixIcon: Icon(
                                                    Icons
                                                        .currency_pound_outlined,
                                                    color: AppTheme.of(
                                                            context)
                                                        .secondaryText,
                                                  ),
                                                ),
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
                                                cursorColor:
                                                    AppTheme.of(context)
                                                        .primaryText,
                                                enableInteractiveSelection:
                                                    true,
                                                validator: _model
                                                    .quoteTextFieldTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ].divide(SizedBox(
                                                height:
                                                    AppTheme.of(context)
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
                                                    AppTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                          letterSpacing: 0.0,
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
                                              ),
                                              AppChoiceChips(
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
                                                      AppTheme.of(
                                                              context)
                                                          .primary,
                                                  textStyle: AppTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
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
                                                                .info,
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
                                                  iconColor:
                                                      AppTheme.of(
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
                                                      AppTheme.of(
                                                              context)
                                                          .accent1,
                                                  textStyle: AppTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
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
                                                                .secondaryText,
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
                                                    AppTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .md)),
                                          ),
                                          Text(
                                            'COVER LETTER / QUOTE DETAILS',
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
                                          Container(
                                            width: double.infinity,
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  AppTheme.of(context)
                                                      .alternate,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  AppTheme.of(context)
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
                                                    labelStyle: AppTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                AppTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                AppTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: AppTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
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
                                                    hintStyle: AppTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                AppTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: AppTheme
                                                                  .of(context)
                                                              .hint,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              AppTheme.of(
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
                                                  style: AppTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
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
                                                  maxLines: 5,
                                                  cursorColor:
                                                      AppTheme.of(
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
                                          if (!_provider.isProposalSubmitted! &&
                                              (widget!.jobView !=
                                                  JobDetailsView.chat))
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: AppButton(
                                                onPressed: () async {
                                                  _model.formResult = true;
                                                  if (_model.formKey
                                                              .currentState ==
                                                          null ||
                                                      !_model
                                                          .formKey.currentState!
                                                          .validate()) {
                                                    _provider.update(() => _model
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
                                                              AppState()
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
                                                            deviceToken: _provider
                                                                .fetchedJob
                                                                ?.customer
                                                                ?.deviceToken,
                                                            title:
                                                                'New Proposal Received',
                                                            body:
                                                                '${AppState().userProfileCache.name} has sent a job proposal',
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

                                                  _provider.notify();
                                                },
                                                text: 'Submit Proposal',
                                                icon: const Icon(
                                                  Icons.send,
                                                  size: 30.0,
                                                ),
                                                options: AppButtonOptions(
                                                  width: 300.0,
                                                  height: 50.0,
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconAlignment:
                                                      IconAlignment.end,
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: AppTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: AppTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppTheme.of(
                                                                  context)
                                                              .designToken
                                                              .radius
                                                              .lg),
                                                ),
                                              ),
                                            ),
                                          if (((AppState()
                                                          .userProfileCache
                                                          .userRole ==
                                                      2) &&
                                                  ((_provider.isProposalSubmitted ==
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
                                                  (_provider.isPaymentPaid ==
                                                      true)) ||
                                              (AppState().paidJobId ==
                                                  widget!.jobId))
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: AppButton(
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
                                                                id: _provider
                                                                    .user?.id,
                                                                name: _provider
                                                                    .user?.name,
                                                                avatarUrl: _provider
                                                                    .user
                                                                    ?.avatarUrl,
                                                                deviceToken: _provider
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
                                                              _provider.user?.id,
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
                                                          deviceToken: _provider
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

                                                  _provider.notify();
                                                },
                                                text: 'Chat',
                                                icon: const Icon(
                                                  Icons.message_rounded,
                                                  size: 30.0,
                                                ),
                                                options: AppButtonOptions(
                                                  width: 300.0,
                                                  height: 50.0,
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: Colors.transparent,
                                                  textStyle: AppTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            AppTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderSide: BorderSide(
                                                    color: AppTheme.of(
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
                                          if (_provider.isProposalSubmitted ??
                                              true)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: AppButton(
                                                onPressed:
                                                    _provider.isProposalSubmitted!
                                                        ? null
                                                        : () {
                                                            print(
                                                                'Button pressed ...');
                                                          },
                                                text: valueOrDefault<String>(
                                                  () {
                                                    if ((_provider.isProposalSubmitted ==
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
                                                    } else if ((_provider
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
                                                options: AppButtonOptions(
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
                                                      AppTheme.of(
                                                              context)
                                                          .primary,
                                                  color: AppTheme.of(
                                                          context)
                                                      .alternate,
                                                  textStyle: AppTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            AppTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppTheme.of(
                                                                  context)
                                                              .designToken
                                                              .radius
                                                              .lg),
                                                ),
                                              ),
                                            ),
                                          if ((_provider.isProposalSubmitted ==
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
                                              child: AppButton(
                                                onPressed: (_provider
                                                            .isPaymentPaid! ||
                                                        (AppState()
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

                                                        _provider.notify();
                                                      },
                                                text: _provider.isPaymentPaid! ||
                                                        (AppState()
                                                                .paidJobId ==
                                                            widget!.jobId)
                                                    ? 'Payment Paid'
                                                    : 'Pay now',
                                                options: AppButtonOptions(
                                                  width: 300.0,
                                                  height: 50.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: AppTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: AppTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
                                                          fontWeight:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              AppTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            AppTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderSide: BorderSide(
                                                    color: AppTheme.of(
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
                                                    AppTheme.of(context)
                                                        .designToken
                                                        .spacing
                                                        .xl))
                                            .addToEnd(SizedBox(
                                                height: AppConstants
                                                    .parentPagePadding)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (_provider.proposalsList.isNotEmpty)
                          Builder(
                            builder: (context) {
                              final proposals = _provider.proposalsList.toList();

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: proposals.length,
                                separatorBuilder: (_, __) => SizedBox(
                                    height: AppTheme.of(context)
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
                                        _provider.updateProposalsListAtIndex(
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
                                        _provider.notify();
                                      }

                                      _provider.notify();
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
                                            _provider.updateProposalsListAtIndex(
                                              proposalsIndex,
                                              (e) => e
                                                ..status = Status.ACCEPTED.name,
                                            );
                                            _provider.notify();
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

                                      _provider.notify();
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
                                            _provider.updateProposalsListAtIndex(
                                              proposalsIndex,
                                              (e) => e
                                                ..status = Status.REJECTED.name,
                                            );
                                            _provider.notify();
                                          }),
                                        ]);
                                      }
                                      _provider.notify();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                      ]
                          .divide(const SizedBox(height: AppConstants.childSpacing))
                          .addToEnd(const SizedBox(height: 80.0)),
                    ),
                  ),
                );
              } else {
                return wrapWithModel(
                  model: _model.jobDetailsLoaderModel,
                  updateCallback: () => _provider.notify(),
                  child: const JobDetailsLoaderWidget(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}