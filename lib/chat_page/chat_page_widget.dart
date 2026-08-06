import 'package:my_trade_pal/auth/supabase_auth/helper.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/repositories/supabase/supabase.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/bottom_sheet_attachment_component/bottom_sheet_attachment_component_widget.dart';
import '/widgets/components/countinue_booking/countinue_booking_widget.dart';
import '/widgets/components/empty_list_component/empty_list_component_widget.dart';
import '/widgets/components/loading_text/loading_text_widget.dart';
import '/widgets/components/unlock_chat_dialogue_box_widget.dart';
import '/widgets/components/user_preview_component/user_preview_component_widget.dart';
import '/core/utils/animations.dart';
import '/widgets/app_expanded_image_view.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/utils/upload_data.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/providers/chat_page_provider.dart';
import '/viewmodels/chat_page_model.dart';
export '/viewmodels/chat_page_model.dart';

class ChatPageWidget extends StatefulWidget {
  const ChatPageWidget({
    super.key,
    required this.conversationId,
    required this.username,
    required this.avatarUrl,
    required this.jobid,
    required this.member,
  });

  final String? conversationId;
  final String? username;
  final String? avatarUrl;
  final String? jobid;
  final MembersStruct? member;

  static String routeName = 'chat_page';
  static String routePath = '/chatPage';

  @override
  State<ChatPageWidget> createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget>
    with TickerProviderStateMixin {
  late ChatPageModel _model;
  final ChatPageProvider _provider = ChatPageProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    debugPrint('DEBUG jobid: ${widget.jobid}');
    _model = createModel(context, () => ChatPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _provider.loading = true;
      _provider.isProposalPaid = false;
      _provider.notify();
      await Future.wait([
        Future(() async {
          await actions.unsubscribe(
            'messages',
          );
          await Future.delayed(
            const Duration(
              milliseconds: 200,
            ),
          );
          await Future.wait([
            Future(() async {
              await actions.subscribe(
                'messages',
                'conversation_id',
                widget!.conversationId!,
                'insert',
                    () async {
                  _provider.update(() => _model.apiRequestCompleter = null);
                  await _model.waitForApiRequestCompleted();
                },
              );
            }),
            Future(() async {
              _model.getJobDetail =
              await SupabaseTablesGroup.getJobDetailsCall.call(
                jobId: widget!.jobid,
              );

              if ((_model.getJobDetail?.succeeded ?? true)) {
                _provider.jobData = ((_model.getJobDetail?.jsonBody ?? '')
                    .toList()
                    .map<JobDataStruct?>(JobDataStruct.maybeFromMap)
                    .toList() as Iterable<JobDataStruct?>)
                    .withoutNulls
                    ?.firstOrNull;
                _provider.isAssigned = ((_model.getJobDetail?.jsonBody ?? '')
                    .toList()
                    .map<JobDataStruct?>(JobDataStruct.maybeFromMap)
                    .toList() as Iterable<JobDataStruct?>)
                    .withoutNulls
                    ?.firstOrNull
                    ?.assignedTradespersonId ==
                    widget!.member?.id;
                _provider.notify();
              }
            }),
          ]);
          _provider.loading = false;
          _provider.notify();
        }),
        Future(() async {
          if (AppState().userProfileCache.userRole == 2) {
            _model.paymentStatusRes =
            await SupabaseTablesGroup.getProposalPaymentCall.call(
              jobId: widget!.jobid,
              tradepersonId: currentUserUid,
            );

            if ((_model.paymentStatusRes?.succeeded ?? true)) {
              if (SupabaseTablesGroup.getProposalPaymentCall.paymentStatus(
                (_model.paymentStatusRes?.jsonBody ?? ''),
              ) ==
                  PaymentStatus.paid.name) {
                _provider.isProposalPaid = true;
                _provider.notify();
              } else {
                await Future.wait([
                  Future(() async {
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: const AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(dialogContext).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: UnlockChatDialogueBoxWidget(
                              jobid: widget!.jobid!,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ]);
              }
              await actions.unsubscribe(
                'proposal_payments',
              );
              await Future.delayed(
                const Duration(
                  milliseconds: 200,
                ),
              );
              await actions.subscribe(
                'proposal_payments',
                'stripe_payment_intent_id',
                getJsonField(
                  (_model.paymentStatusRes?.jsonBody ?? ''),
                  r'''$.stripe_payment_intent_id''',
                ).toString(),
                'update',
                    () async {
                  _provider.notify();
                },
              );
            }
          }
        }),
      ]);
    });

    _model.messageTextFieldTextController ??= TextEditingController();
    _model.messageTextFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 500.0.ms,
            begin: const Offset(0.0, -10.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, -28.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOutQuint,
            delay: 0.0.ms,
            duration: 800.0.ms,
            color: AppTheme.of(context).hint,
            angle: 0.524,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.notify());
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      await actions.unsubscribe(
        'messages',
      );
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

    return ChangeNotifierProvider<ChatPageProvider>.value(
      value: _provider,
      child: Consumer<ChatPageProvider>(
        builder: (context, _, __) => _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          extendBodyBehindAppBar: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppTheme.of(context).primaryBackground,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
            title: wrapWithModel(
              model: _model.appbarComponentModel,
              updateCallback: () => _provider.notify(),
              child: AppbarComponentWidget(
                title: '',
                showAction: false,
                action: () async {},
                extraWidget: () => UserPreviewComponentWidget(
                  name: widget!.username!,
                  avatarUrl: widget!.avatarUrl!,
                ),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.of(context).secondaryBackground,
                  AppTheme.of(context).primaryBackground,
                ],
                stops: const [0.0, 0.35],
              ),
            ),
            child: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Builder(
                        builder: (context) {
                          if ((_model.getJobDetail?.succeeded ?? true)) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  JobDetailsWidget.routeName,
                                  queryParameters: {
                                    'jobId': serializeParam(
                                      widget!.jobid,
                                      ParamType.String,
                                    ),
                                    'jobView': serializeParam(
                                      JobDetailsView.chat,
                                      ParamType.Enum,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 8.0, 12.0, 0.0),
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color: AppTheme.of(context)
                                        .primary
                                        .withOpacity(0.16),
                                    width: 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 14.0,
                                      color: AppTheme.of(context)
                                          .primaryText
                                          .withOpacity(0.05),
                                      offset: const Offset(0.0, 4.0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(valueOrDefault<double>(
                                    AppConstants.childPadding,
                                    0.0,
                                  )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      6.0),
                                                  decoration: BoxDecoration(
                                                    color: AppTheme.of(context)
                                                        .primary
                                                        .withOpacity(0.12),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.tools,
                                                    color: AppTheme.of(context)
                                                        .primary,
                                                    size: 13.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RichText(
                                                    textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Discussing:',
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
                                                            fontSize:
                                                            12.0,
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
                                                        ),
                                                        TextSpan(
                                                          text: valueOrDefault<
                                                              String>(
                                                            _provider
                                                                .jobData?.title,
                                                            '....',
                                                          ),
                                                          style:
                                                          AppTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                            font: GoogleFonts
                                                                .manrope(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontStyle: AppTheme.of(
                                                                  context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                            ),
                                                            fontSize:
                                                            12.0,
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontStyle: AppTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                          ),
                                                        )
                                                      ],
                                                      style: AppTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                        font: GoogleFonts
                                                            .manrope(
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
                                                  ),
                                                ),
                                              ].divide(const SizedBox(
                                                  width:
                                                  AppConstants.childSpacing)),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            const EdgeInsetsDirectional
                                                .fromSTEB(
                                                10.0, 4.0, 10.0, 4.0),
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context)
                                                  .secondary
                                                  .withOpacity(0.12),
                                              borderRadius:
                                              BorderRadius.circular(20.0),
                                            ),
                                            child: Text(
                                              'View details',
                                              style: AppTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                  AppTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                                ),
                                                color: AppTheme.of(context)
                                                    .secondary,
                                                fontSize: 11.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: AppTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                            ),
                                          ),
                                        ]
                                            .divide(const SizedBox(
                                            width: AppConstants.childSpacing))
                                            .around(const SizedBox(
                                            width:
                                            AppConstants.childSpacing)),
                                      ),
                                      if ((AppState().userProfileCache.userRole ==
                                          1) &&
                                          (_provider.jobData != null) &&
                                          ((_provider.jobData?.status ==
                                              Status.ACTIVE) ||
                                              (_provider.jobData?.status ==
                                                  Status.IN_PROGRESS)))
                                        Container(
                                          decoration: const BoxDecoration(),
                                          child: AppButton(
                                            onPressed: () async {
                                              if (_provider.jobData?.status ==
                                                  Status.IN_PROGRESS) {
                                                _model.jobCompletedRes =
                                                await SupabaseTablesGroup
                                                    .updateJobStatusCall
                                                    .call(
                                                  params:
                                                  'id=eq.${widget!.jobid}',
                                                  payloadJson: <String, String?>{
                                                    'status':
                                                    Status.COMPLETED.name,
                                                  },
                                                );

                                                if ((_model.jobCompletedRes
                                                    ?.succeeded ??
                                                    true)) {
                                                  await action_blocks
                                                      .insertNotifications(
                                                    context,
                                                    title: 'Job Completed',
                                                    message:
                                                    'The Customer has marked your job as completed. Please review the work and confirm completion.',
                                                    type: NotificationType
                                                        .APPLICATION.name,
                                                    userId: currentUserUid,
                                                    referenceId: widget!.jobid,
                                                    recieverid:
                                                    widget!.member?.id,
                                                    extraData: <String, dynamic>{
                                                      'member': <String, dynamic>{
                                                        'username':
                                                        widget!.username,
                                                        'avatarurl':
                                                        widget!.avatarUrl,
                                                        'jobid': widget!.jobid,
                                                        'member_id':
                                                        widget!.member?.id,
                                                        'member_name':
                                                        widget!.member?.name,
                                                        'member_avatar': widget!
                                                            .member?.avatarUrl,
                                                      },
                                                    },
                                                  );
                                                  _model.completedJobNotificationRes =
                                                  await SupabaseEdgeFunctionsGroup
                                                      .sendPushNotificationCall
                                                      .call(
                                                    deviceToken: widget!
                                                        .member?.deviceToken,
                                                    title: 'Job Completed',
                                                    body:
                                                    'The Customer has marked your job as completed. Please review the work and confirm completion.',
                                                    dataJson: {},
                                                  );

                                                  _provider.jobData = ((_model
                                                      .jobCompletedRes
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
                                                      ?.firstOrNull;
                                                  _provider.notify();
                                                }
                                              } else if (_provider
                                                  .jobData?.status ==
                                                  Status.ACTIVE) {
                                                _model.jobAssignedRes =
                                                await SupabaseTablesGroup
                                                    .updateJobStatusCall
                                                    .call(
                                                  params:
                                                  'id=eq.${widget!.jobid}',
                                                  payloadJson: <String, String?>{
                                                    'assigned_tradesperson_id':
                                                    widget!.member?.id,
                                                    'status':
                                                    Status.IN_PROGRESS.name,
                                                  },
                                                );

                                                if ((_model.jobAssignedRes
                                                    ?.succeeded ??
                                                    true)) {
                                                  await action_blocks
                                                      .insertNotifications(
                                                    context,
                                                    title: 'Job Assigned',
                                                    message:
                                                    'Congratulations! A customer has assigned this job to you. Review the details and get started.',
                                                    type: NotificationType
                                                        .APPLICATION.name,
                                                    userId: currentUserUid,
                                                    referenceId: widget!.jobid,
                                                    recieverid:
                                                    widget!.member?.id,
                                                    extraData: <String, dynamic>{
                                                      'member': <String, dynamic>{
                                                        'username':
                                                        widget!.username,
                                                        'avatarurl':
                                                        widget!.avatarUrl,
                                                        'jobid': widget!.jobid,
                                                        'member_id':
                                                        widget!.member?.id,
                                                        'member_name':
                                                        widget!.member?.name,
                                                        'member_avatar': widget!
                                                            .member?.avatarUrl,
                                                      },
                                                    },
                                                  );
                                                  _model.assignedNotificationRes =
                                                  await SupabaseEdgeFunctionsGroup
                                                      .sendPushNotificationCall
                                                      .call(
                                                    deviceToken: widget!
                                                        .member?.deviceToken,
                                                    title: 'Job Assigned',
                                                    body:
                                                    'Congratulations! A customer has assigned this job to you. Review the details and get started.',
                                                    dataJson: {},
                                                  );

                                                  _provider.jobData = ((_model
                                                      .jobAssignedRes
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
                                                      ?.firstOrNull;
                                                  _provider.isAssigned = true;
                                                  _provider.notify();
                                                }
                                              }

                                              _provider.notify();
                                            },
                                            text: _provider.jobData?.status ==
                                                Status.IN_PROGRESS
                                                ? 'Complete job'
                                                : 'Assign to job',
                                            options: AppButtonOptions(
                                              width: 300.0,
                                              height: 50.0,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(16.0, 0.0, 16.0, 0.0),
                                              iconPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                              color: _provider.jobData?.status ==
                                                  Status.IN_PROGRESS
                                                  ? AppTheme.of(context).success
                                                  : AppTheme.of(context).primary,
                                              textStyle: AppTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                  AppTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                                  fontStyle:
                                                  AppTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                                ),
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                AppTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                                fontStyle:
                                                AppTheme.of(context)
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
                                        ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation2']!),
                                    ].divide(const SizedBox(
                                        height: AppConstants.childSpacing)),
                                  ),
                                ),
                              ),
                            ).animateOnPageLoad(
                                animationsMap['containerOnPageLoadAnimation1']!);
                          } else {
                            return Container(
                              width: 0.0,
                              height: 0.0,
                              decoration: const BoxDecoration(),
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (!_provider.loading) {
                              return Visibility(
                                visible:
                                (AppState().userProfileCache.userRole == 1) ||
                                    ((AppState().userProfileCache.userRole ==
                                        2) &&
                                        (_provider.isProposalPaid == true)) ||
                                    (AppState().paidJobId == widget!.jobid),
                                child: Padding(
                                  padding: EdgeInsets.all(valueOrDefault<double>(
                                    AppConstants.parentPagePadding,
                                    0.0,
                                  )),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: (_model.apiRequestCompleter ??=
                                    Completer<ApiCallResponse>()
                                      ..complete(SupabaseTablesGroup
                                          .getMessagesCall
                                          .call(
                                        conversationId:
                                        widget!.conversationId,
                                      )))
                                        .future,
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40.0,
                                            height: 40.0,
                                            child: SpinKitFadingCube(
                                              color: AppTheme.of(context).primary,
                                              size: 40.0,
                                            ),
                                          ),
                                        );
                                      }
                                      final listViewGetMessagesResponse =
                                      snapshot.data!;

                                      return Builder(
                                        builder: (context) {
                                          final messages =
                                              (listViewGetMessagesResponse
                                                  .jsonBody
                                                  .toList()
                                                  .map<MessagesStruct?>(
                                                  MessagesStruct
                                                      .maybeFromMap)
                                                  .toList()
                                              as Iterable<
                                                  MessagesStruct?>)
                                                  .withoutNulls
                                                  ?.toList() ??
                                                  [];
                                          if (messages.isEmpty) {
                                            return EmptyListComponentWidget(
                                              icon: Icon(
                                                Icons.chat,
                                                color:
                                                AppTheme.of(context).accent4,
                                                size: 40.0,
                                              ),
                                              title: 'No messages yet',
                                              description:
                                              'Start a conversation to see your messages here',
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              0,
                                              valueOrDefault<double>(
                                                _model.uploadedLocalFile_locallyUploadedImage !=
                                                    null &&
                                                    (_model
                                                        .uploadedLocalFile_locallyUploadedImage
                                                        .bytes
                                                        ?.isNotEmpty ??
                                                        false)
                                                    ? 150.0
                                                    : 70.0,
                                                80.0,
                                              ),
                                            ),
                                            reverse: true,
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: messages.length,
                                            separatorBuilder: (_, __) =>
                                            const SizedBox(
                                                height: AppConstants
                                                    .childPadding),
                                            itemBuilder:
                                                (context, messagesIndex) {
                                              final messagesItem =
                                              messages[messagesIndex];
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  if (AppState()
                                                      .userProfileCache
                                                      .userKey !=
                                                      messagesItem.senderId)
                                                    Row(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .end,
                                                      children: [
                                                        Container(
                                                          width: 26.0,
                                                          height: 26.0,
                                                          clipBehavior:
                                                          Clip.antiAlias,
                                                          decoration:
                                                          BoxDecoration(
                                                            shape:
                                                            BoxShape.circle,
                                                            border: Border.all(
                                                              color: AppTheme.of(
                                                                  context)
                                                                  .alternate,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Image.network(
                                                            valueOrDefault<
                                                                String>(
                                                              widget!.avatarUrl,
                                                              'https://picsum.photos/seed/380/100',
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8.0),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                const AlignmentDirectional(
                                                                    -1.0,
                                                                    0.0),
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation: 0.0,
                                                                  shape:
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                      topLeft: const Radius
                                                                          .circular(
                                                                          4.0),
                                                                      topRight: const Radius.circular(
                                                                          18.0),
                                                                      bottomLeft: const Radius
                                                                          .circular(
                                                                          18.0),
                                                                      bottomRight: const Radius
                                                                          .circular(
                                                                          18.0),
                                                                    ),
                                                                  ),
                                                                  child: Container(
                                                                    constraints:
                                                                    BoxConstraints(
                                                                      maxWidth:
                                                                      MediaQuery.of(
                                                                          context)
                                                                          .size
                                                                          .width *
                                                                          0.72,
                                                                    ),
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: AppTheme.of(
                                                                          context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                        topLeft:
                                                                        Radius
                                                                            .circular(
                                                                            4.0),
                                                                        topRight:
                                                                        Radius
                                                                            .circular(
                                                                            18.0),
                                                                        bottomLeft:
                                                                        Radius
                                                                            .circular(
                                                                            18.0),
                                                                        bottomRight:
                                                                        Radius
                                                                            .circular(
                                                                            18.0),
                                                                      ),
                                                                      border:
                                                                      Border.all(
                                                                        color: AppTheme
                                                                            .of(
                                                                            context)
                                                                            .alternate
                                                                            .withOpacity(
                                                                            0.7),
                                                                        width: 1.0,
                                                                      ),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          blurRadius:
                                                                          10.0,
                                                                          color: AppTheme.of(
                                                                              context)
                                                                              .primaryText
                                                                              .withOpacity(
                                                                              0.05),
                                                                          offset:
                                                                          const Offset(
                                                                              0.0,
                                                                              3.0),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          14.0,
                                                                          10.0,
                                                                          14.0,
                                                                          10.0),
                                                                      child: Column(
                                                                        mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          if (messagesItem
                                                                              .messageType ==
                                                                              'image')
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets
                                                                                  .only(
                                                                                  bottom: 6.0),
                                                                              child:
                                                                              InkWell(
                                                                                splashColor:
                                                                                Colors.transparent,
                                                                                focusColor:
                                                                                Colors.transparent,
                                                                                hoverColor:
                                                                                Colors.transparent,
                                                                                highlightColor:
                                                                                Colors.transparent,
                                                                                onTap:
                                                                                    () async {
                                                                                  await Navigator
                                                                                      .push(
                                                                                    context,
                                                                                    PageTransition(
                                                                                      type: PageTransitionType.fade,
                                                                                      child: AppExpandedImageView(
                                                                                        image: Image.network(
                                                                                          valueOrDefault<String>(
                                                                                            messagesItem.imageUrl,
                                                                                            'https://picsum.photos/seed/380/600',
                                                                                          ),
                                                                                          fit: BoxFit.contain,
                                                                                        ),
                                                                                        allowRotation: false,
                                                                                        tag: valueOrDefault<String>(
                                                                                          messagesItem.imageUrl,
                                                                                          'https://picsum.photos/seed/380/600' + '$messagesIndex',
                                                                                        ),
                                                                                        useHeroAnimation: true,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child:
                                                                                Hero(
                                                                                  tag: valueOrDefault<
                                                                                      String>(
                                                                                    messagesItem.imageUrl,
                                                                                    'https://picsum.photos/seed/380/600' +
                                                                                        '$messagesIndex',
                                                                                  ),
                                                                                  transitionOnUserGestures:
                                                                                  true,
                                                                                  child:
                                                                                  ClipRRect(
                                                                                    borderRadius:
                                                                                    BorderRadius.circular(14.0),
                                                                                    child:
                                                                                    Image.network(
                                                                                      valueOrDefault<String>(
                                                                                        messagesItem.imageUrl,
                                                                                        'https://picsum.photos/seed/380/600',
                                                                                      ),
                                                                                      height: 200.0,
                                                                                      width: double.infinity,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          Text(
                                                                            messagesItem
                                                                                .content,
                                                                            style: AppTheme.of(
                                                                                context)
                                                                                .bodyLarge
                                                                                .override(
                                                                              font:
                                                                              GoogleFonts.manrope(
                                                                                fontWeight:
                                                                                AppTheme.of(context).bodyLarge.fontWeight,
                                                                                fontStyle:
                                                                                AppTheme.of(context).bodyLarge.fontStyle,
                                                                              ),
                                                                              fontSize:
                                                                              14.5,
                                                                              letterSpacing:
                                                                              0.0,
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
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    4.0,
                                                                    3.0,
                                                                    0.0,
                                                                    0.0),
                                                                child: Text(
                                                                  valueOrDefault<String>(
                                                                    functions
                                                                        .formatDateTime(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          messagesItem
                                                                              .createdAt,
                                                                          'created at ',
                                                                        )),
                                                                    'created at',
                                                                  ),
                                                                  style:
                                                                  AppTheme.of(context)
                                                                      .labelSmall
                                                                      .override(
                                                                    font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                      fontWeight: AppTheme.of(
                                                                          context)
                                                                          .labelSmall
                                                                          .fontWeight,
                                                                      fontStyle: AppTheme.of(
                                                                          context)
                                                                          .labelSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                    10.0,
                                                                    letterSpacing:
                                                                    0.0,
                                                                    fontWeight: AppTheme.of(
                                                                        context)
                                                                        .labelSmall
                                                                        .fontWeight,
                                                                    fontStyle: AppTheme.of(
                                                                        context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  if (AppState()
                                                      .userProfileCache
                                                      .userKey ==
                                                      messagesItem.senderId)
                                                    Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                          AlignmentDirectional(
                                                              valueOrDefault<
                                                                  double>(
                                                                currentUserUid ==
                                                                    messagesItem
                                                                        .senderId
                                                                    ? 1.0
                                                                    : -1.0,
                                                                0.0,
                                                              ),
                                                              0.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor: Colors
                                                                .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                ReviewWidget
                                                                    .routeName,
                                                                queryParameters: {
                                                                  'name':
                                                                  serializeParam(
                                                                    widget!
                                                                        .username,
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                  'profileUrl':
                                                                  serializeParam(
                                                                    widget!
                                                                        .avatarUrl,
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                  'jobid':
                                                                  serializeParam(
                                                                    widget!.jobid,
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                  'tradepersonId':
                                                                  serializeParam(
                                                                    widget!.member
                                                                        ?.id,
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 0.0,
                                                              shape:
                                                              const RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                                  topRight:
                                                                  Radius
                                                                      .circular(
                                                                      4.0),
                                                                  topLeft:
                                                                  Radius
                                                                      .circular(
                                                                      18.0),
                                                                  bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                      18.0),
                                                                  bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                      18.0),
                                                                ),
                                                              ),
                                                              child: Container(
                                                                constraints:
                                                                BoxConstraints(
                                                                  maxWidth:
                                                                  MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .width *
                                                                      0.72,
                                                                ),
                                                                decoration:
                                                                BoxDecoration(
                                                                  gradient:
                                                                  LinearGradient(
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                    colors: [
                                                                      AppTheme.of(
                                                                          context)
                                                                          .primary,
                                                                      AppTheme.of(
                                                                          context)
                                                                          .primary
                                                                          .withOpacity(
                                                                          0.85),
                                                                    ],
                                                                  ),
                                                                  borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                    topRight:
                                                                    Radius
                                                                        .circular(
                                                                        4.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                        18.0),
                                                                    bottomLeft: Radius
                                                                        .circular(
                                                                        18.0),
                                                                    bottomRight: Radius
                                                                        .circular(
                                                                        18.0),
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                      10.0,
                                                                      color: AppTheme.of(
                                                                          context)
                                                                          .primary
                                                                          .withOpacity(
                                                                          0.25),
                                                                      offset:
                                                                      const Offset(
                                                                          0.0,
                                                                          3.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      14.0,
                                                                      10.0,
                                                                      14.0,
                                                                      10.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      if (messagesItem
                                                                          .messageType ==
                                                                          'image')
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets.only(bottom: 6.0),
                                                                          child:
                                                                          InkWell(
                                                                            splashColor:
                                                                            Colors.transparent,
                                                                            focusColor:
                                                                            Colors.transparent,
                                                                            hoverColor:
                                                                            Colors.transparent,
                                                                            highlightColor:
                                                                            Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              await Navigator.push(
                                                                                context,
                                                                                PageTransition(
                                                                                  type: PageTransitionType.fade,
                                                                                  child: AppExpandedImageView(
                                                                                    image: Image.network(
                                                                                      valueOrDefault<String>(
                                                                                        messagesItem.imageUrl,
                                                                                        'https://picsum.photos/seed/380/600',
                                                                                      ),
                                                                                      fit: BoxFit.contain,
                                                                                    ),
                                                                                    allowRotation: false,
                                                                                    tag: valueOrDefault<String>(
                                                                                      messagesItem.imageUrl,
                                                                                      'https://picsum.photos/seed/380/600' + '$messagesIndex',
                                                                                    ),
                                                                                    useHeroAnimation: true,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                            Hero(
                                                                              tag: valueOrDefault<String>(
                                                                                messagesItem.imageUrl,
                                                                                'https://picsum.photos/seed/380/600' + '$messagesIndex',
                                                                              ),
                                                                              transitionOnUserGestures:
                                                                              true,
                                                                              child:
                                                                              ClipRRect(
                                                                                borderRadius: BorderRadius.circular(14.0),
                                                                                child: Image.network(
                                                                                  valueOrDefault<String>(
                                                                                    messagesItem.imageUrl,
                                                                                    'https://picsum.photos/seed/380/600',
                                                                                  ),
                                                                                  height: 200.0,
                                                                                  width: double.infinity,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      Text(
                                                                        messagesItem
                                                                            .content,
                                                                        style: AppTheme.of(
                                                                            context)
                                                                            .bodyLarge
                                                                            .override(
                                                                          font:
                                                                          GoogleFonts.manrope(
                                                                            fontWeight: AppTheme.of(context).bodyLarge.fontWeight,
                                                                            fontStyle: AppTheme.of(context).bodyLarge.fontStyle,
                                                                          ),
                                                                          color:
                                                                          AppTheme.of(context).messageText,
                                                                          fontSize:
                                                                          14.5,
                                                                          letterSpacing:
                                                                          0.0,
                                                                          fontWeight:
                                                                          AppTheme.of(context).bodyLarge.fontWeight,
                                                                          fontStyle:
                                                                          AppTheme.of(context).bodyLarge.fontStyle,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                          AlignmentDirectional(
                                                              valueOrDefault<
                                                                  double>(
                                                                currentUserUid ==
                                                                    messagesItem
                                                                        .senderId
                                                                    ? 1.0
                                                                    : -1.0,
                                                                0.0,
                                                              ),
                                                              0.0),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0.0,
                                                                3.0,
                                                                4.0,
                                                                0.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                functions
                                                                    .formatDateTime(
                                                                    messagesItem
                                                                        .createdAt),
                                                                'created at',
                                                              ),
                                                              style: AppTheme.of(
                                                                  context)
                                                                  .labelSmall
                                                                  .override(
                                                                font:
                                                                GoogleFonts
                                                                    .inter(
                                                                  fontWeight: AppTheme.of(
                                                                      context)
                                                                      .labelSmall
                                                                      .fontWeight,
                                                                  fontStyle: AppTheme.of(
                                                                      context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight: AppTheme.of(
                                                                    context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                                fontStyle: AppTheme.of(
                                                                    context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ].divide(const SizedBox(
                                                    height: AppConstants
                                                        .childPadding)),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return wrapWithModel(
                                model: _model.loadingTextModel,
                                updateCallback: () => _provider.notify(),
                                child: const LoadingTextWidget(),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryBackground,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20.0,
                            color: AppTheme.of(context)
                                .primaryText
                                .withOpacity(0.10),
                            offset: const Offset(
                              0.0,
                              -4.0,
                            ),
                          )
                        ],
                        border: Border(
                          top: BorderSide(
                            color:
                            AppTheme.of(context).alternate.withOpacity(0.6),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Builder(
                        builder: (context) {
                          if (_provider.jobData != null) {
                            return Builder(
                              builder: (context) {
                                if (_provider.jobData?.status !=
                                    Status.COMPLETED) {
                                  return Padding(
                                    padding:
                                    EdgeInsets.all(valueOrDefault<double>(
                                      AppConstants.childPadding,
                                      0.0,
                                    )),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (_model.uploadedLocalFile_locallyUploadedImage !=
                                            null &&
                                            (_model.uploadedLocalFile_locallyUploadedImage
                                                .bytes?.isNotEmpty ??
                                                false))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Stack(
                                                alignment:
                                                const AlignmentDirectional(
                                                    1.0, -1.0),
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12.0),
                                                    child: Image.memory(
                                                      _model.uploadedLocalFile_locallyUploadedImage
                                                          .bytes ??
                                                          Uint8List.fromList([]),
                                                      width: 80.0,
                                                      height: 70.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                    const AlignmentDirectional(
                                                        1.12, -1.07),
                                                    child: AppIconButton(
                                                      borderRadius: 8.0,
                                                      buttonSize: 30.0,
                                                      fillColor:
                                                      const Color(0xFF747685),
                                                      icon: Icon(
                                                        Icons.close,
                                                        color:
                                                        AppTheme.of(context)
                                                            .info,
                                                        size: 14.0,
                                                      ),
                                                      onPressed: () async {
                                                        _provider.update(() {
                                                          _model.isDataUploading_locallyUploadedImage =
                                                          false;
                                                          _model.uploadedLocalFile_locallyUploadedImage =
                                                              UploadedFile(
                                                                  bytes: Uint8List
                                                                      .fromList(
                                                                      []),
                                                                  originalFilename:
                                                                  '');
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            AppIconButton(
                                              borderRadius: 22.0,
                                              buttonSize: 44.0,
                                              fillColor: AppTheme.of(context)
                                                  .alternate,
                                              disabledColor:
                                              AppTheme.of(context).alternate,
                                              disabledIconColor:
                                              AppTheme.of(context).hint,
                                              icon: Icon(
                                                Icons.add_rounded,
                                                color:
                                                AppTheme.of(context).primary,
                                                size: 24.0,
                                              ),
                                              onPressed:
                                              (_model.messageTextFieldTextController
                                                  .text !=
                                                  null &&
                                                  _model.messageTextFieldTextController
                                                      .text !=
                                                      '')
                                                  ? null
                                                  : () async {
                                                if (_provider
                                                    .isAssigned) {
                                                  await showModalBottomSheet(
                                                    isScrollControlled:
                                                    true,
                                                    backgroundColor:
                                                    Colors
                                                        .transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(
                                                              context)
                                                              .unfocus();
                                                          FocusManager
                                                              .instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                              context),
                                                          child:
                                                          BottomSheetAttachmentComponentWidget(
                                                            onPhotoTapped:
                                                                () async {
                                                              final selectedMedia =
                                                              await selectMediaWithSourceBottomSheet(
                                                                context:
                                                                context,
                                                                allowPhoto:
                                                                true,
                                                              );
                                                              if (selectedMedia !=
                                                                  null &&
                                                                  selectedMedia.every((m) => validateFileFormat(
                                                                      m.storagePath,
                                                                      context))) {
                                                                _provider.update(() =>
                                                                _model.isDataUploading_locallyUploadedImage =
                                                                true);
                                                                var selectedUploadedFiles =
                                                                <UploadedFile>[];

                                                                try {
                                                                  selectedUploadedFiles = selectedMedia
                                                                      .map((m) => UploadedFile(
                                                                    name: m.storagePath.split('/').last,
                                                                    bytes: m.bytes,
                                                                    height: m.dimensions?.height,
                                                                    width: m.dimensions?.width,
                                                                    blurHash: m.blurHash,
                                                                    originalFilename: m.originalFilename,
                                                                  ))
                                                                      .toList();
                                                                } finally {
                                                                  _model.isDataUploading_locallyUploadedImage =
                                                                  false;
                                                                }
                                                                if (selectedUploadedFiles.length ==
                                                                    selectedMedia.length) {
                                                                  _provider
                                                                      .update(() {
                                                                    _model.uploadedLocalFile_locallyUploadedImage =
                                                                        selectedUploadedFiles.first;
                                                                  });
                                                                } else {
                                                                  _provider
                                                                      .update(() {});
                                                                  return;
                                                                }
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      _provider.update(
                                                              () {}));
                                                } else {
                                                  context.pushNamed(
                                                      CompleteBookingDialogWidget
                                                          .routeName);
                                                }
                                              },
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                controller: _model
                                                    .messageTextFieldTextController,
                                                focusNode: _model
                                                    .messageTextFieldFocusNode,
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
                                                    color:
                                                    AppTheme.of(context)
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
                                                  hintText: 'Type a message...',
                                                  hintStyle: AppTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontStyle:
                                                      AppTheme.of(context)
                                                          .labelMedium
                                                          .fontStyle,
                                                    ),
                                                    color:
                                                    AppTheme.of(context)
                                                        .hint,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    fontStyle:
                                                    AppTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                                  ),
                                                  contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 12.0,
                                                      16.0, 12.0),
                                                  enabledBorder:
                                                  OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: AppTheme.of(context)
                                                          .alternate,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        24.0),
                                                  ),
                                                  focusedBorder:
                                                  OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: AppTheme.of(context)
                                                          .primary,
                                                      width: 1.4,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        24.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: AppTheme.of(context)
                                                          .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        24.0),
                                                  ),
                                                  focusedErrorBorder:
                                                  OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: AppTheme.of(context)
                                                          .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        24.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: AppTheme.of(context)
                                                      .primaryBackground,
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
                                                    .messageTextFieldTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                            Builder(
                                              builder: (context) => Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      AppTheme.of(context)
                                                          .primary,
                                                      AppTheme.of(context)
                                                          .primary
                                                          .withOpacity(0.8),
                                                    ],
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 10.0,
                                                      color: AppTheme.of(context)
                                                          .primary
                                                          .withOpacity(0.35),
                                                      offset:
                                                      const Offset(0.0, 3.0),
                                                    ),
                                                  ],
                                                ),
                                                child: AppIconButton(
                                                  borderRadius: 24.0,
                                                  buttonSize: 48.0,
                                                  fillColor: Colors.transparent,
                                                  icon: Icon(
                                                    Icons.send_rounded,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground,
                                                    size: 22.0,
                                                  ),
                                                  showLoadingIndicator: true,
                                                  onPressed: () async {
                                                    if ((AppState()
                                                        .userProfileCache
                                                        .userRole ==
                                                        1) ||
                                                        ((AppState()
                                                            .userProfileCache
                                                            .userRole ==
                                                            2) &&
                                                            (_provider
                                                                .isProposalPaid ==
                                                                true))) {
                                                      if (functions.canSendMessage(
                                                          _model
                                                              .messageTextFieldTextController
                                                              .text,
                                                          _provider.isAssigned)) {
                                                        if (_model.uploadedLocalFile_locallyUploadedImage !=
                                                            null &&
                                                            (_model
                                                                .uploadedLocalFile_locallyUploadedImage
                                                                .bytes
                                                                ?.isNotEmpty ??
                                                                false)) {
                                                          {
                                                            _provider.update(() =>
                                                            _model.isDataUploading_uploadedFileImagePath =
                                                            true);
                                                            var selectedUploadedFiles =
                                                            <UploadedFile>[];
                                                            var selectedMedia =
                                                            <SelectedFile>[];
                                                            var downloadUrls =
                                                            <String>[];
                                                            try {
                                                              selectedUploadedFiles = _model
                                                                  .uploadedLocalFile_locallyUploadedImage
                                                                  .bytes!
                                                                  .isNotEmpty
                                                                  ? [
                                                                _model
                                                                    .uploadedLocalFile_locallyUploadedImage
                                                              ]
                                                                  : <UploadedFile>[];
                                                              selectedMedia =
                                                                  selectedFilesFromUploadedFiles(
                                                                    selectedUploadedFiles,
                                                                    storageFolderPath:
                                                                    'user',
                                                                  );
                                                              downloadUrls =
                                                              await uploadSupabaseStorageFiles(
                                                                bucketName:
                                                                'general',
                                                                selectedFiles:
                                                                selectedMedia,
                                                              );
                                                            } finally {
                                                              _model.isDataUploading_uploadedFileImagePath =
                                                              false;
                                                            }
                                                            if (selectedUploadedFiles
                                                                .length ==
                                                                selectedMedia
                                                                    .length &&
                                                                downloadUrls
                                                                    .length ==
                                                                    selectedMedia
                                                                        .length) {
                                                              _provider.update(() {
                                                                _model.uploadedLocalFile_uploadedFileImagePath =
                                                                    selectedUploadedFiles
                                                                        .first;
                                                                _model.uploadedFileUrl_uploadedFileImagePath =
                                                                    downloadUrls
                                                                        .first;
                                                              });
                                                            } else {
                                                              _provider.notify();
                                                              return;
                                                            }
                                                          }
                                                        }
                                                        if ((_model.uploadedLocalFile_locallyUploadedImage !=
                                                            null &&
                                                            (_model
                                                                .uploadedLocalFile_locallyUploadedImage
                                                                .bytes
                                                                ?.isNotEmpty ??
                                                                false)) ||
                                                            (_model.messageTextFieldTextController
                                                                .text !=
                                                                null &&
                                                                _model.messageTextFieldTextController
                                                                    .text !=
                                                                    '')) {
                                                          _model.sendMessage =
                                                          await SupbaseRpcGroup
                                                              .sendMessageCall
                                                              .call(
                                                            conversationId: widget!
                                                                .conversationId,
                                                            senderId:
                                                            currentUserUid,
                                                            content: _model
                                                                .messageTextFieldTextController
                                                                .text,
                                                            messageType:
                                                            valueOrDefault<
                                                                String>(
                                                              _model.uploadedLocalFile_locallyUploadedImage !=
                                                                  null &&
                                                                  (_model
                                                                      .uploadedLocalFile_locallyUploadedImage
                                                                      .bytes
                                                                      ?.isNotEmpty ??
                                                                      false)
                                                                  ? 'image'
                                                                  : 'text',
                                                              'text',
                                                            ),
                                                            imageUrl: _model.uploadedLocalFile_locallyUploadedImage !=
                                                                null &&
                                                                (_model
                                                                    .uploadedLocalFile_locallyUploadedImage
                                                                    .bytes
                                                                    ?.isNotEmpty ??
                                                                    false)
                                                                ? _model
                                                                .uploadedFileUrl_uploadedFileImagePath
                                                                : '',
                                                          );

                                                          if ((_model.sendMessage
                                                              ?.succeeded ??
                                                              true)) {
                                                            Future(() async {
                                                              final message = _model
                                                                  .messageTextFieldTextController
                                                                  .text
                                                                  .trim();

                                                              final notificationBody =
                                                              message.length >
                                                                  100
                                                                  ? '${message.substring(0, 100)}...'
                                                                  : message;
                                                              await action_blocks
                                                                  .insertNotifications(
                                                                context,
                                                                title:
                                                                'New Message from ${AppState().userProfileCache.name}',
                                                                message:
                                                                notificationBody,
                                                                type:
                                                                NotificationType
                                                                    .CHAT.name,
                                                                userId: AppState()
                                                                    .userProfileCache
                                                                    .userKey,
                                                                referenceId: widget!
                                                                    .conversationId,
                                                                recieverid: widget!
                                                                    .member?.id,
                                                                extraData: <String,
                                                                    dynamic>{
                                                                  'member': <String,
                                                                      dynamic>{
                                                                    'username':
                                                                    AppState()
                                                                        .userProfileCache
                                                                        .name,
                                                                    'avatarurl': AppState()
                                                                        .userProfileCache
                                                                        .avatarUrl,
                                                                    'jobid': widget!
                                                                        .jobid,
                                                                    'member_id':
                                                                    AppState()
                                                                        .userProfileCache
                                                                        .userKey,
                                                                  },
                                                                },
                                                              );
                                                            });
                                                            Future(() async {
                                                              final message = _model
                                                                  .messageTextFieldTextController
                                                                  .text
                                                                  .trim();

                                                              final notificationBody =
                                                              message.length >
                                                                  100
                                                                  ? '${message.substring(0, 100)}...'
                                                                  : message;
                                                              _model.messageNotificationRes =
                                                              await SupabaseEdgeFunctionsGroup
                                                                  .sendPushNotificationCall
                                                                  .call(
                                                                deviceToken: widget!
                                                                    .member
                                                                    ?.deviceToken,
                                                                title:
                                                                'New Message from ${AppState().userProfileCache.name}',
                                                                body:
                                                                notificationBody,
                                                                dataJson: {},
                                                              );
                                                            });

                                                            await Future.wait([
                                                              Future(() async {
                                                                _provider
                                                                    .update(() {
                                                                  _model
                                                                      .messageTextFieldTextController
                                                                      ?.clear();
                                                                });
                                                              }),
                                                              Future(() async {
                                                                _provider
                                                                    .update(() {
                                                                  _model.isDataUploading_locallyUploadedImage =
                                                                  false;
                                                                  _model.uploadedLocalFile_locallyUploadedImage = UploadedFile(
                                                                      bytes: Uint8List
                                                                          .fromList(
                                                                          []),
                                                                      originalFilename:
                                                                      '');
                                                                });
                                                              }),
                                                            ]);
                                                          }
                                                        }
                                                      } else {
                                                        await showDialog(
                                                          context: context,
                                                          builder: (dialogContext) {
                                                            return Dialog(
                                                              elevation: 0,
                                                              insetPadding:
                                                              EdgeInsets.zero,
                                                              backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                              alignment: const AlignmentDirectional(
                                                                  0.0, 0.0)
                                                                  .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                              child:
                                                              GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                      dialogContext)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child:
                                                                const CountinueBookingWidget(),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                    } else {
                                                      await showDialog(
                                                        context: context,
                                                        builder: (dialogContext) {
                                                          return Dialog(
                                                            elevation: 0,
                                                            insetPadding:
                                                            EdgeInsets.zero,
                                                            backgroundColor:
                                                            Colors.transparent,
                                                            alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0)
                                                                .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                    dialogContext)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child:
                                                              UnlockChatDialogueBoxWidget(
                                                                jobid:
                                                                widget!.jobid!,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }

                                                    _provider.notify();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ].divide(const SizedBox(
                                              width: AppConstants.childSpacing)),
                                        ),
                                      ].divide(const SizedBox(
                                          height: AppConstants.childSpacing)),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.all(valueOrDefault<double>(
                                        AppConstants.childPadding,
                                        0.0,
                                      )),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                color:
                                                AppTheme.of(context).success,
                                                size: 24.0,
                                              ),
                                              Align(
                                                alignment:
                                                const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  'This job has been completed',
                                                  style: AppTheme.of(context)
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
                                                    AppTheme.of(context)
                                                        .success,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    AppTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                    fontStyle:
                                                    AppTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                                  ),
                                                ),
                                              ),
                                            ].divide(const SizedBox(
                                                width:
                                                AppConstants.childSpacing)),
                                          ),
                                          if ((AppState()
                                              .userProfileCache
                                              .userRole ==
                                              1) &&
                                              !_model.paymentCompleted)
                                            AppButton(
                                              onPressed: _model
                                                  .isProcessingPayment
                                                  ? () async {}
                                                  : () async {
                                                print(
                                                    "make payment tapped");
                                                _model.isProcessingPayment =
                                                true;

                                                print(
                                                    " _model.isProcessingPayment ${_model.isProcessingPayment}");
                                                _provider.notify();

                                                final acceptedApplications =
                                                await ApplicationsTable()
                                                    .querySingleRow(
                                                  queryFn: (q) => q
                                                      .eqOrNull('job_id',
                                                      widget!.jobid)
                                                      .eqOrNull(
                                                      'status',
                                                      Status.ACCEPTED
                                                          .name),
                                                );
                                                print(
                                                    "accepted applications are ${acceptedApplications}");
                                                final quoteAmount =
                                                    acceptedApplications
                                                        .firstOrNull
                                                        ?.quoteAmount;
                                                print(
                                                    "quoteAmount is ${quoteAmount}");
                                                if (quoteAmount == null) {
                                                  _model.isProcessingPayment =
                                                  false;
                                                  _provider.notify();
                                                  await actions.showToast(
                                                    context,
                                                    'Unable to find the accepted quote for this job.',
                                                    2,
                                                  );
                                                  return;
                                                }

                                                final stripeCustomerId =
                                                await currentUserStripeCustomerId;
                                                print(
                                                    "stripeCustomerId is ${stripeCustomerId} and job id is ${widget.jobid} and current jwt is ${currentJwtToken}\n customer email is ${currentUserEmail}\n current user id is ${currentUserUid}\n tp id is ${widget!.member?.id}");
                                                _model.createPaymentIntentRes =
                                                await CreatePaymentIntentCall
                                                    .call(
                                                  jobId: widget!.jobid,
                                                  token: currentJwtToken,
                                                  stripeCustomerId:
                                                  stripeCustomerId,
                                                  customerEmail:
                                                  currentUserEmail,
                                                  userId: currentUserUid,
                                                  tradepersonId:
                                                  widget!.member?.id,
                                                  amount:
                                                  (quoteAmount * 100)
                                                      .round(),
                                                );

                                                final success =
                                                CreatePaymentIntentCall
                                                    .success(_model
                                                    .createPaymentIntentRes
                                                    ?.jsonBody);

                                                if (success == true) {
                                                  final clientSecret =
                                                  CreatePaymentIntentCall
                                                      .clientSecret(_model
                                                      .createPaymentIntentRes
                                                      ?.jsonBody);
                                                  final returnedCustomerId =
                                                  CreatePaymentIntentCall
                                                      .customerId(_model
                                                      .createPaymentIntentRes
                                                      ?.jsonBody);
                                                  final ephemeralKey =
                                                  CreatePaymentIntentCall
                                                      .ephemeralKey(_model
                                                      .createPaymentIntentRes
                                                      ?.jsonBody);
                                                  final paymentIntentId =
                                                  CreatePaymentIntentCall
                                                      .paymentIntentId(
                                                      _model
                                                          .createPaymentIntentRes
                                                          ?.jsonBody);

                                                  if (clientSecret !=
                                                      null &&
                                                      returnedCustomerId !=
                                                          null &&
                                                      ephemeralKey !=
                                                          null) {
                                                    final paymentSuccess =
                                                    await actions
                                                        .makePayment(
                                                      clientSecret:
                                                      clientSecret,
                                                      customerId:
                                                      returnedCustomerId,
                                                      ephemeralKey:
                                                      ephemeralKey,
                                                    );

                                                    if (paymentSuccess) {
                                                      _model.paymentCompleted =
                                                      true;
                                                      await actions
                                                          .showToast(
                                                        context,
                                                        'Payment successful',
                                                        2,
                                                      );

                                                      if (paymentIntentId !=
                                                          null) {
                                                        _model.releaseFundsRes =
                                                        await ReleaseFundsCall
                                                            .call(
                                                          paymentIntentId:
                                                          paymentIntentId,
                                                          token:
                                                          currentJwtToken,
                                                        );

                                                        final releaseFundsSuccess =
                                                        ReleaseFundsCall
                                                            .success(_model
                                                            .releaseFundsRes
                                                            ?.jsonBody);

                                                        if (releaseFundsSuccess !=
                                                            true) {
                                                          final releaseFundsError =
                                                              ReleaseFundsCall.error(
                                                                  _model
                                                                      .releaseFundsRes
                                                                      ?.jsonBody) ??
                                                                  'Please contact support.';
                                                          print(
                                                              'Release funds failed: $releaseFundsError');
                                                          await actions
                                                              .showToast(
                                                            context,
                                                            'Payment received, but releasing funds to the tradesperson failed: $releaseFundsError',
                                                            3,
                                                          );
                                                        }
                                                      }
                                                    } else {
                                                      await actions
                                                          .showToast(
                                                        context,
                                                        'Payment failed',
                                                        2,
                                                      );
                                                    }
                                                  } else {
                                                    await actions.showToast(
                                                      context,
                                                      'Unable to start payment. Please try again.',
                                                      2,
                                                    );
                                                  }
                                                } else {
                                                  await actions.showToast(
                                                    context,
                                                    'Unable to start payment. Please try again.',
                                                    2,
                                                  );
                                                }

                                                _model.isProcessingPayment =
                                                false;
                                                _provider.notify();
                                              },
                                              text: _model.isProcessingPayment
                                                  ? 'Processing...'
                                                  : 'Make Payment',
                                              options: AppButtonOptions(
                                                width: 200.0,
                                                height: 44.0,
                                                padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                                color:
                                                AppTheme.of(context).primary,
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
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  AppTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                                  fontStyle:
                                                  AppTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                                ),
                                                elevation: 0.0,
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                            ),
                                        ].divide(const SizedBox(
                                            height: AppConstants.childSpacing)),
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          } else {
                            return Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).secondaryBackground,
                              ),
                            ).animateOnPageLoad(
                                animationsMap['containerOnPageLoadAnimation3']!);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}