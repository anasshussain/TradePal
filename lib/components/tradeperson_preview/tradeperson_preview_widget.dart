import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/labels/labels_widget.dart';
import '/theme/app_theme.dart';
import '/core/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/core/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tradeperson_preview_model.dart';
export 'tradeperson_preview_model.dart';

class TradepersonPreviewWidget extends StatefulWidget {
  const TradepersonPreviewWidget({
    super.key,
    required this.proposalsItem,
    required this.callback,
    required this.jobViewType,
    required this.onAccept,
    required this.onReject,
  });

  final ProposalListStruct? proposalsItem;
  final Future Function()? callback;
  final JobDetailsView? jobViewType;
  final Future Function()? onAccept;
  final Future Function()? onReject;

  @override
  State<TradepersonPreviewWidget> createState() =>
      _TradepersonPreviewWidgetState();
}

class _TradepersonPreviewWidgetState extends State<TradepersonPreviewWidget> {
  late TradepersonPreviewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TradepersonPreviewModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.getUser = await SupabaseTablesGroup.getUserCall.call(
        userId: widget!.proposalsItem?.tradespersonId,
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
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            AppTheme.of(context).designToken.radius.md),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
          boxShadow: [AppTheme.of(context).designToken.shadow.sm],
          borderRadius: BorderRadius.circular(
              AppTheme.of(context).designToken.radius.md),
          border: Border.all(
            color: AppTheme.of(context).alternate,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(valueOrDefault<double>(
            AppConstants.parentPagePadding,
            0.0,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    valueOrDefault<String>(
                      _model.user?.profession,
                      'profession',
                    ),
                    style: AppTheme.of(context).bodySmall.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontStyle: AppTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: AppTheme.of(context).primary,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              AppTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                  if ((widget!.proposalsItem?.status == Status.REJECTED.name) ||
                      (widget!.proposalsItem?.status == Status.ACCEPTED.name))
                    wrapWithModel(
                      model: _model.labelsModel,
                      updateCallback: () => safeSetState(() {}),
                      child: LabelsWidget(
                        labelText: widget!.proposalsItem?.status,
                        textcolor: valueOrDefault<String>(
                                  widget!.proposalsItem?.status,
                                  'status',
                                ) ==
                                Status.ACCEPTED.name
                            ? AppTheme.of(context).success
                            : AppTheme.of(context).error,
                        backroundColor: valueOrDefault<String>(
                                  widget!.proposalsItem?.status,
                                  'status',
                                ) ==
                                Status.ACCEPTED.name
                            ? Color(0x5F5BDC8B)
                            : Color(0x97F07878),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '£ ${valueOrDefault<String>(
                      widget!.proposalsItem?.quoteAmount?.toString(),
                      'amount',
                    )}',
                    style: AppTheme.of(context).titleLarge.override(
                          font: GoogleFonts.inter(
                            fontWeight: AppTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: AppTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: AppTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              AppTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                  Text(
                    functions.timeAgo(valueOrDefault<String>(
                      widget!.proposalsItem?.createdAt,
                      'created at',
                    )),
                    style: AppTheme.of(context).bodyMedium.override(
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
                          fontStyle:
                              AppTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
              if (valueOrDefault<String>(
                        widget!.proposalsItem?.duration,
                        'duration',
                      ) !=
                      null &&
                  valueOrDefault<String>(
                        widget!.proposalsItem?.duration,
                        'duration',
                      ) !=
                      '')
                Text(
                  'Duration: ${valueOrDefault<String>(
                    widget!.proposalsItem?.duration,
                    'duration',
                  )}',
                  style: AppTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: AppTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              AppTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            AppTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            AppTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              Text(
                valueOrDefault<String>(
                  widget!.proposalsItem?.message,
                  'No description',
                ),
                style: AppTheme.of(context).labelMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            AppTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            AppTheme.of(context).labelMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          AppTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          AppTheme.of(context).labelMedium.fontStyle,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          valueOrDefault<String>(
                            _model.user?.avatarUrl,
                            'https://images-ext-1.discordapp.net/external/AO96cLsz1bw1R0zy6qWuphMKgA7a3OkU2M3-zUSxcXM/%3Fq%3Dtbn%3AANd9GcTpRGUcBVltEkFutN21fIqebRvrgP7fOv4CjcNwuka3BtXR_-jhpd7GheJ_RkvMtSsnsA8%26usqp%3DCAU/https/encrypted-tbn0.gstatic.com/images?format=webp&width=562&height=360',
                          ),
                          width: 40.0,
                          height: 40.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              _model.user?.name,
                              'name',
                            ),
                            style: AppTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.star_sharp,
                                color: AppTheme.of(context).tertiary,
                                size: 14.0,
                              ),
                              RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: valueOrDefault<String>(
                                        widget!
                                            .proposalsItem?.users?.averageRating
                                            ?.toString(),
                                        '0.0',
                                      ),
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    TextSpan(
                                      text: ' (${valueOrDefault<String>(
                                        widget!
                                            .proposalsItem?.users?.totalReviews
                                            ?.toString(),
                                        '0',
                                      )} reviews)',
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: AppTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    )
                                  ],
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
                                        fontWeight: AppTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: AppConstants.childSpacing)),
                      ),
                    ].divide(SizedBox(width: AppConstants.childSpacing)),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).alternate,
                ),
              ),
              if ((widget!.proposalsItem?.status != Status.REJECTED.name) &&
                  (widget!.proposalsItem?.status != Status.ACCEPTED.name))
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: () async {
                          await widget.onAccept?.call();
                        },
                        text: 'Accept',
                        icon: Icon(
                          Icons.check_circle,
                          size: 26.0,
                        ),
                        options: AppButtonOptions(
                          width: 300.0,
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
                    Expanded(
                      child: AppButton(
                        onPressed: () async {
                          await widget.onReject?.call();
                        },
                        text: 'Reject',
                        icon: Icon(
                          Icons.cancel_rounded,
                          size: 24.0,
                        ),
                        options: AppButtonOptions(
                          width: 300.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconColor: AppTheme.of(context).error,
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
                                    color: AppTheme.of(context).error,
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
                            color: AppTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: AppConstants.childSpacing)),
                ),
              if ((AppState().userProfileCache.userRole == 1) &&
                  (widget!.proposalsItem?.status == Status.ACCEPTED.name) &&
                  (widget!.jobViewType != JobDetailsView.chat))
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: AppButton(
                    onPressed: () async {
                      _model.startChat = await SupbaseRpcGroup
                          .getConversationBetweenUsersCall
                          .call(
                        userA: currentUserUid,
                        userB: widget!.proposalsItem?.tradespersonId,
                        jobId: widget!.proposalsItem?.jobId,
                      );

                      if ((_model.startChat?.succeeded ?? true)) {
                        await Future.wait([
                          Future(() async {
                            context.pushNamed(
                              ChatPageWidget.routeName,
                              queryParameters: {
                                'conversationId': serializeParam(
                                  StartChatStruct.maybeFromMap(
                                          (_model.startChat?.jsonBody ?? ''))
                                      ?.conversationId,
                                  ParamType.String,
                                ),
                                'username': serializeParam(
                                  currentUserUid !=
                                          StartChatStruct.maybeFromMap(
                                                  (_model.startChat?.jsonBody ??
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
                                'avatarUrl': serializeParam(
                                  currentUserUid !=
                                          StartChatStruct.maybeFromMap(
                                                  (_model.startChat?.jsonBody ??
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
                                'jobid': serializeParam(
                                  widget!.proposalsItem?.jobId,
                                  ParamType.String,
                                ),
                                'member': serializeParam(
                                  MembersStruct(
                                    id: ((_model.getUser?.jsonBody ?? '')
                                            .toList()
                                            .map<UserStruct?>(
                                                UserStruct.maybeFromMap)
                                            .toList() as Iterable<UserStruct?>)
                                        .withoutNulls
                                        ?.firstOrNull
                                        ?.id,
                                    name: ((_model.getUser?.jsonBody ?? '')
                                            .toList()
                                            .map<UserStruct?>(
                                                UserStruct.maybeFromMap)
                                            .toList() as Iterable<UserStruct?>)
                                        .withoutNulls
                                        ?.firstOrNull
                                        ?.name,
                                    avatarUrl: ((_model.getUser?.jsonBody ?? '')
                                            .toList()
                                            .map<UserStruct?>(
                                                UserStruct.maybeFromMap)
                                            .toList() as Iterable<UserStruct?>)
                                        .withoutNulls
                                        ?.firstOrNull
                                        ?.avatarUrl,
                                    deviceToken: ((_model.getUser?.jsonBody ??
                                                '')
                                            .toList()
                                            .map<UserStruct?>(
                                                UserStruct.maybeFromMap)
                                            .toList() as Iterable<UserStruct?>)
                                        .withoutNulls
                                        ?.firstOrNull
                                        ?.deviceToken,
                                  ),
                                  ParamType.DataStruct,
                                ),
                              }.withoutNulls,
                            );
                          }),
                          Future(() async {
                            await action_blocks.insertNotifications(
                              context,
                              title: 'Conversation Started by Customer',
                              message:
                                  'A customer is interested in your services and has started a conversation.',
                              type: NotificationType.APPLICATION.name,
                              userId: currentUserUid,
                              referenceId: widget!.proposalsItem?.jobId,
                              recieverid: widget!.proposalsItem?.tradespersonId,
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
                            _model.messageNotificationRes =
                                await SupabaseEdgeFunctionsGroup
                                    .sendPushNotificationCall
                                    .call(
                              deviceToken: ((_model.getUser?.jsonBody ?? '')
                                      .toList()
                                      .map<UserStruct?>(UserStruct.maybeFromMap)
                                      .toList() as Iterable<UserStruct?>)
                                  .withoutNulls
                                  ?.firstOrNull
                                  ?.deviceToken,
                              title: 'Conversation Started by Customer',
                              body:
                                  'A customer is interested in your services and has started a conversation.',
                              dataJson: {},
                            );
                          }),
                        ]);
                      }

                      safeSetState(() {});
                    },
                    text: 'Send a Message',
                    icon: Icon(
                      Icons.message_rounded,
                      size: 30.0,
                    ),
                    options: AppButtonOptions(
                      width: 300.0,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
            ].divide(SizedBox(height: AppConstants.childSpacing)),
          ),
        ),
      ),
    );
  }
}
