import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/inbox_item_model.dart';
export '/viewmodels/inbox_item_model.dart';

class InboxItemWidget extends StatefulWidget {
  const InboxItemWidget({
    super.key,
    required this.members,
    required this.conversation,
  });

  final MembersStruct? members;
  final ConversationStruct? conversation;

  @override
  State<InboxItemWidget> createState() => _InboxItemWidgetState();
}

class _InboxItemWidgetState extends State<InboxItemWidget> {
  late InboxItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InboxItemModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        context.pushNamed(
          ChatPageWidget.routeName,
          queryParameters: {
            'conversationId': serializeParam(
              widget!.conversation?.conversationId,
              ParamType.String,
            ),
            'username': serializeParam(
              widget!.members?.name,
              ParamType.String,
            ),
            'avatarUrl': serializeParam(
              widget!.members?.avatarUrl,
              ParamType.String,
            ),
            'jobid': serializeParam(
              widget!.conversation?.conversations?.jobId,
              ParamType.String,
            ),
            'member': serializeParam(
              widget!.members,
              ParamType.DataStruct,
            ),
          }.withoutNulls,
        );

        _model.markConversationRes =
            await SupbaseRpcGroup.markConversationReadCall.call(
          conversationId: widget!.conversation?.conversationId,
          authtoken: currentJwtToken,
        );

        if ((_model.markConversationRes?.succeeded ?? true)) {
          await actions.updateTotalCount(
            (_model.markConversationRes?.jsonBody ?? ''),
          );
        }

        safeSetState(() {});
      },
      child: Material(
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
            padding: EdgeInsets.all(valueOrDefault<double>(
              AppConstants.childPadding,
              0.0,
            )),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    valueOrDefault<String>(
                      widget!.members?.avatarUrl,
                      'https://images-ext-1.discordapp.net/external/AO96cLsz1bw1R0zy6qWuphMKgA7a3OkU2M3-zUSxcXM/%3Fq%3Dtbn%3AANd9GcTpRGUcBVltEkFutN21fIqebRvrgP7fOv4CjcNwuka3BtXR_-jhpd7GheJ_RkvMtSsnsA8%26usqp%3DCAU/https/encrypted-tbn0.gstatic.com/images?format=webp&width=562&height=360',
                    ),
                    width: 56.0,
                    height: 56.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/error_image.svg',
                      width: 56.0,
                      height: 56.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              widget!.members?.name,
                              'name',
                            ),
                            style:
                                AppTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: AppTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: AppTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              functions.timeAgo(valueOrDefault<String>(
                                widget!
                                    .conversation?.conversations?.lastMessageAt,
                                'date',
                              )),
                              'created time',
                            ),
                            style: AppTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: AppTheme.of(context).primary,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: AppTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      AnimatedDefaultTextStyle(
                        style: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.manrope(
                                fontWeight: AppTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: AppTheme.of(context).secondaryText,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: AppTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeIn,
                        child: Text(
                          valueOrDefault<String>(
                            widget!.conversation?.conversations?.lastMessage,
                            'message',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ].divide(SizedBox(width: AppConstants.childSpacing)),
            ),
          ),
        ),
      ),
    );
  }
}
