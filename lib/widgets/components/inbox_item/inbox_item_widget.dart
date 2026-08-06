import 'package:cached_network_image/cached_network_image.dart';

import '/core/utils/image_decode_size.dart';
import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
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
    final unreadCount = widget!.conversation?.unreadCount ?? 0;
    final isUnread = unreadCount > 0;

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

        safeSetState(() {});
      },
      child: Material(
        color: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppTheme.of(context).designToken.radius.lg),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isUnread
                ? AppTheme.of(context).primary.withOpacity(0.06)
                : AppTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(
                AppTheme.of(context).designToken.radius.lg),
            border: Border.all(
              color: isUnread
                  ? AppTheme.of(context).primary.withOpacity(0.2)
                  : AppTheme.of(context).alternate,
              width: isUnread ? 1.5 : 1.0,
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
                  child: CachedNetworkImage(
                    imageUrl: valueOrDefault<String>(
                      widget!.members?.avatarUrl,
                      'https://images-ext-1.discordapp.net/external/AO96cLsz1bw1R0zy6qWuphMKgA7a3OkU2M3-zUSxcXM/%3Fq%3Dtbn%3AANd9GcTpRGUcBVltEkFutN21fIqebRvrgP7fOv4CjcNwuka3BtXR_-jhpd7GheJ_RkvMtSsnsA8%26usqp%3DCAU/https/encrypted-tbn0.gstatic.com/images?format=webp&width=562&height=360',
                    ),
                    width: 56.0,
                    height: 56.0,
                    memCacheWidth: decodeCacheSize(context, 56.0),
                    memCacheHeight: decodeCacheSize(context, 56.0),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
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
                            style: AppTheme.of(context).bodyLarge.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle:
                                      AppTheme.of(context).bodyLarge.fontStyle,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  functions.timeAgo(valueOrDefault<String>(
                                    widget!.conversation?.conversations
                                        ?.lastMessageAt,
                                    'date',
                                  )),
                                  'created time',
                                ),
                                style: AppTheme.of(context).bodyMedium.override(
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
                              if (isUnread)
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 18.0,
                                      minHeight: 18.0,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).primary,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      unreadCount > 99
                                          ? '99+'
                                          : unreadCount.toString(),
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.manrope(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      AnimatedDefaultTextStyle(
                        style: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.manrope(
                                fontWeight: isUnread
                                    ? FontWeight.bold
                                    : AppTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: isUnread
                                  ? AppTheme.of(context).primaryText
                                  : AppTheme.of(context).secondaryText,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: isUnread
                                  ? FontWeight.bold
                                  : AppTheme.of(context).bodyMedium.fontWeight,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                        duration: const Duration(milliseconds: 600),
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
              ].divide(const SizedBox(width: AppConstants.childSpacing)),
            ),
          ),
        ),
      ),
    );
  }
}
