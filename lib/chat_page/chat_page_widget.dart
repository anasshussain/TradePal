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
import '/core/animations.dart';
import '/widgets/app_expanded_image_view.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/upload_data.dart';
import 'dart:math';
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
import '/viewmodels/chat_page_model.dart';
export '/viewmodels/chat_page_model.dart';

/// create a simple 2 way real time chat page with no picture icons
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loading = true;
      _model.isProposalPaid = false;
      safeSetState(() {});
      await Future.wait([
        Future(() async {
          await actions.unsubscribe(
            'messages',
          );
          await Future.delayed(
            Duration(
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
                  safeSetState(() => _model.apiRequestCompleter = null);
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
                _model.jobData = ((_model.getJobDetail?.jsonBody ?? '')
                        .toList()
                        .map<JobDataStruct?>(JobDataStruct.maybeFromMap)
                        .toList() as Iterable<JobDataStruct?>)
                    .withoutNulls
                    ?.firstOrNull;
                _model.isAssigned = ((_model.getJobDetail?.jsonBody ?? '')
                            .toList()
                            .map<JobDataStruct?>(JobDataStruct.maybeFromMap)
                            .toList() as Iterable<JobDataStruct?>)
                        .withoutNulls
                        ?.firstOrNull
                        ?.assignedTradespersonId ==
                    widget!.member?.id;
                safeSetState(() {});
              }
            }),
          ]);
          _model.loading = false;
          safeSetState(() {});
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
                _model.isProposalPaid = true;
                safeSetState(() {});
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
                          alignment: AlignmentDirectional(0.0, 0.0)
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
                Duration(
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
                  safeSetState(() {});
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
            begin: Offset(0.0, -10.0),
            end: Offset(0.0, 0.0),
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
            begin: Offset(0.0, -28.0),
            end: Offset(0.0, 0.0),
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

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Builder(
      builder: (context) => GestureDetector(
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
              updateCallback: () => safeSetState(() {}),
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
            actions: [],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
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
                              decoration: BoxDecoration(
                                color: Color(0x8CDCE4E8),
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
                                              FaIcon(
                                                FontAwesomeIcons.tools,
                                                color: AppTheme.of(context)
                                                    .primary,
                                                size: 16.0,
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
                                                          _model.jobData?.title,
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
                                            ].divide(SizedBox(
                                                width:
                                                    AppConstants.childSpacing)),
                                          ),
                                        ),
                                        Text(
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
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                        ),
                                      ]
                                          .divide(SizedBox(
                                              width: AppConstants.childSpacing))
                                          .around(SizedBox(
                                              width:
                                                  AppConstants.childSpacing)),
                                    ),
                                    if ((AppState().userProfileCache.userRole ==
                                            1) &&
                                        (_model.jobData != null) &&
                                        ((_model.jobData?.status ==
                                                Status.ACTIVE) ||
                                            (_model.jobData?.status ==
                                                Status.IN_PROGRESS)))
                                      Container(
                                        decoration: BoxDecoration(),
                                        child: AppButton(
                                          onPressed: () async {
                                            if (_model.jobData?.status ==
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

                                                _model.jobData = ((_model
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
                                                safeSetState(() {});
                                              }
                                            } else if (_model.jobData?.status ==
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

                                                _model.jobData = ((_model
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
                                                _model.isAssigned = true;
                                                safeSetState(() {});
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                          text: _model.jobData?.status ==
                                                  Status.IN_PROGRESS
                                              ? 'Complete job'
                                              : 'Assign to job',
                                          options: AppButtonOptions(
                                            width: 300.0,
                                            height: 50.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: _model.jobData?.status ==
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
                                  ].divide(SizedBox(
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
                            decoration: BoxDecoration(),
                          );
                        }
                      },
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (!_model.loading) {
                            return Visibility(
                              visible:
                                  (AppState().userProfileCache.userRole == 1) ||
                                      ((AppState().userProfileCache.userRole ==
                                              2) &&
                                          (_model.isProposalPaid == true)) ||
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
                                          separatorBuilder: (_, __) => SizedBox(
                                              height:
                                                  AppConstants.childPadding),
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
                                                                -1.0, 0.0),
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 0.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius.circular(
                                                                  AppTheme.of(
                                                                          context)
                                                                      .designToken
                                                                      .radius
                                                                      .lg),
                                                              bottomLeft: Radius
                                                                  .circular(AppTheme.of(
                                                                          context)
                                                                      .designToken
                                                                      .radius
                                                                      .lg),
                                                              bottomRight: Radius
                                                                  .circular(AppTheme.of(
                                                                          context)
                                                                      .designToken
                                                                      .radius
                                                                      .lg),
                                                            ),
                                                          ),
                                                          child: Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth: 221.0,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .alternate,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius.circular(
                                                                    AppTheme.of(
                                                                            context)
                                                                        .designToken
                                                                        .radius
                                                                        .lg),
                                                                bottomLeft: Radius.circular(
                                                                    AppTheme.of(
                                                                            context)
                                                                        .designToken
                                                                        .radius
                                                                        .lg),
                                                                bottomRight: Radius.circular(
                                                                    AppTheme.of(
                                                                            context)
                                                                        .designToken
                                                                        .radius
                                                                        .lg),
                                                              ),
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 0.0,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.all(
                                                                  valueOrDefault<
                                                                      double>(
                                                                AppConstants
                                                                    .childPadding,
                                                                0.0,
                                                              )),
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
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          PageTransition(
                                                                            type:
                                                                                PageTransitionType.fade,
                                                                            child:
                                                                                AppExpandedImageView(
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
                                                                          messagesItem
                                                                              .imageUrl,
                                                                          'https://picsum.photos/seed/380/600' +
                                                                              '$messagesIndex',
                                                                        ),
                                                                        transitionOnUserGestures:
                                                                            true,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(AppTheme.of(context).designToken.radius.md),
                                                                            bottomLeft:
                                                                                Radius.circular(AppTheme.of(context).designToken.radius.md),
                                                                            bottomRight:
                                                                                Radius.circular(AppTheme.of(context).designToken.radius.md),
                                                                          ),
                                                                          child:
                                                                              Image.network(
                                                                            valueOrDefault<String>(
                                                                              messagesItem.imageUrl,
                                                                              'https://picsum.photos/seed/380/600',
                                                                            ),
                                                                            height:
                                                                                200.0,
                                                                            fit:
                                                                                BoxFit.cover,
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
                                                      Text(
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
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius.circular(
                                                                    AppTheme.of(
                                                                            context)
                                                                        .designToken
                                                                        .radius
                                                                        .lg),
                                                                bottomLeft: Radius.circular(
                                                                    AppTheme.of(
                                                                            context)
                                                                        .designToken
                                                                        .radius
                                                                        .lg),
                                                                bottomRight: Radius.circular(
                                                                    AppTheme.of(
                                                                            context)
                                                                        .designToken
                                                                        .radius
                                                                        .lg),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                maxWidth: 221.0,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .primary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius.circular(
                                                                      AppTheme.of(
                                                                              context)
                                                                          .designToken
                                                                          .radius
                                                                          .lg),
                                                                  bottomLeft: Radius.circular(
                                                                      AppTheme.of(
                                                                              context)
                                                                          .designToken
                                                                          .radius
                                                                          .lg),
                                                                  bottomRight: Radius.circular(
                                                                      AppTheme.of(
                                                                              context)
                                                                          .designToken
                                                                          .radius
                                                                          .lg),
                                                                ),
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 0.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.all(
                                                                    valueOrDefault<
                                                                        double>(
                                                                  AppConstants
                                                                      .childPadding,
                                                                  0.0,
                                                                )),
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
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(AppTheme.of(context).designToken.radius.md),
                                                                              bottomLeft: Radius.circular(AppTheme.of(context).designToken.radius.md),
                                                                              bottomRight: Radius.circular(AppTheme.of(context).designToken.radius.md),
                                                                            ),
                                                                            child:
                                                                                Image.network(
                                                                              valueOrDefault<String>(
                                                                                messagesItem.imageUrl,
                                                                                'https://picsum.photos/seed/380/600',
                                                                              ),
                                                                              height: 200.0,
                                                                              fit: BoxFit.cover,
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
                                                    ],
                                                  ),
                                              ].divide(SizedBox(
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
                              updateCallback: () => safeSetState(() {}),
                              child: LoadingTextWidget(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(
                            0.0,
                            2.0,
                          ),
                        )
                      ],
                      border: Border.all(
                        color: Colors.transparent,
                        width: 0.0,
                      ),
                    ),
                    child: Builder(
                      builder: (context) {
                        if (_model.jobData != null) {
                          return Builder(
                            builder: (context) {
                              if (_model.jobData?.status != Status.COMPLETED) {
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
                                              alignment: AlignmentDirectional(
                                                  1.0, -1.0),
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
                                                      AlignmentDirectional(
                                                          1.12, -1.07),
                                                  child: AppIconButton(
                                                    borderRadius: 8.0,
                                                    buttonSize: 30.0,
                                                    fillColor:
                                                        Color(0xFF747685),
                                                    icon: Icon(
                                                      Icons.close,
                                                      color:
                                                          AppTheme.of(context)
                                                              .info,
                                                      size: 14.0,
                                                    ),
                                                    onPressed: () async {
                                                      safeSetState(() {
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
                                            borderRadius: 8.0,
                                            buttonSize: 40.0,
                                            fillColor: Colors.transparent,
                                            disabledColor:
                                                AppTheme.of(context).alternate,
                                            disabledIconColor:
                                                AppTheme.of(context).hint,
                                            icon: Icon(
                                              Icons.add_circle_outline_rounded,
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
                                                        if (_model.isAssigned) {
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
                                                                        safeSetState(() =>
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
                                                                          safeSetState(
                                                                              () {
                                                                            _model.uploadedLocalFile_locallyUploadedImage =
                                                                                selectedUploadedFiles.first;
                                                                          });
                                                                        } else {
                                                                          safeSetState(
                                                                              () {});
                                                                          return;
                                                                        }
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
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
                                                    color: AppTheme.of(context)
                                                        .primary,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppTheme.of(context)
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
                                                    color: AppTheme.of(context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
                                                  .messageTextFieldTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Builder(
                                            builder: (context) => AppIconButton(
                                              borderRadius: 8.0,
                                              buttonSize: 48.0,
                                              fillColor:
                                                  AppTheme.of(context).primary,
                                              icon: Icon(
                                                Icons.send_rounded,
                                                color: AppTheme.of(context)
                                                    .primaryBackground,
                                                size: 24.0,
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
                                                        (_model.isProposalPaid ==
                                                            true))) {
                                                  if (functions.canSendMessage(
                                                      _model
                                                          .messageTextFieldTextController
                                                          .text,
                                                      _model.isAssigned)) {
                                                    if (_model.uploadedLocalFile_locallyUploadedImage !=
                                                            null &&
                                                        (_model
                                                                .uploadedLocalFile_locallyUploadedImage
                                                                .bytes
                                                                ?.isNotEmpty ??
                                                            false)) {
                                                      {
                                                        safeSetState(() => _model
                                                                .isDataUploading_uploadedFileImagePath =
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
                                                          safeSetState(() {
                                                            _model.uploadedLocalFile_uploadedFileImagePath =
                                                                selectedUploadedFiles
                                                                    .first;
                                                            _model.uploadedFileUrl_uploadedFileImagePath =
                                                                downloadUrls
                                                                    .first;
                                                          });
                                                        } else {
                                                          safeSetState(() {});
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
                                                            safeSetState(() {
                                                              _model
                                                                  .messageTextFieldTextController
                                                                  ?.clear();
                                                            });
                                                          }),
                                                          Future(() async {
                                                            safeSetState(() {
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
                                                          alignment: AlignmentDirectional(
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
                                                                CountinueBookingWidget(),
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
                                                            AlignmentDirectional(
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

                                                safeSetState(() {});
                                              },
                                            ),
                                          ),
                                        ].divide(SizedBox(
                                            width: AppConstants.childSpacing)),
                                      ),
                                    ].divide(SizedBox(
                                        height: AppConstants.childSpacing)),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: AppTheme.of(context).success,
                                        size: 24.0,
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
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
                                                color: AppTheme.of(context)
                                                    .success,
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
                                        width: AppConstants.childSpacing)),
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
    );
  }
}
