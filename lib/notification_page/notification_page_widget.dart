import 'dart:async';

import 'package:skeletonizer/skeletonizer.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/repositories/supabase/supabase.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/notification_item_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/notification_page_provider.dart';
import '/viewmodels/notification_page_model.dart';
export '/viewmodels/notification_page_model.dart';

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  static String routeName = 'NotificationPage';
  static String routePath = '/notificationPage';

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget> {
  late NotificationPageModel _model;
  final NotificationPageProvider _provider = NotificationPageProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationPageModel());

    final bool alreadyLoaded = _provider.isAlreadyLoaded();
    if (alreadyLoaded) {
      _provider.restoreFromCache();
    }

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!alreadyLoaded) {
        _provider.setLoading(true);

        _model.notifications =
            await SupabaseTablesGroup.getNotificationsCall.call(
          userId: currentUserUid,
        );

        if ((_model.notifications?.succeeded ?? true)) {
          final fetchedList = ((_model.notifications?.jsonBody ?? '')
                  .toList()
                  .map<NotificationsStruct?>(NotificationsStruct.maybeFromMap)
                  .toList() as Iterable<NotificationsStruct?>)
              .withoutNulls
              .toList()
              .cast<NotificationsStruct>();

          _provider.notificationsPageState = fetchedList;
          _provider.saveToCache(fetchedList);

          if (fetchedList.any((n) => !n.isRead)) {
            unawaited(NotificationsTable().update(
              data: {'is_read': true},
              matchingRows: (rows) => rows
                  .eq('receiver_id', currentUserUid)
                  .eq('is_read', false),
            ));
          }
          AppState().unreadNotificationsCount = 0;
        }
        _provider.setLoading(false);
      }
    });
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
    return ChangeNotifierProvider<NotificationPageProvider>.value(
      value: _provider,
      child: _buildContent(context),
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
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => _provider.notify(),
            child: AppbarComponentWidget(
              title: 'Notifications',
              showAction: false,
              action: () async {},
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          // top: true,
          child: Padding(
            padding:
                EdgeInsets.all(AppTheme.of(context).designToken.spacing.lg),
            child: Consumer<NotificationPageProvider>(
              builder: (context, provider, _) {
                final notification = provider.notificationsPageState.toList();
                final itemCount = provider.isLoading ? 6 : notification.length;

                if (!provider.isLoading && notification.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 88.0,
                          height: 88.0,
                          decoration: BoxDecoration(
                            color: AppTheme.of(context).alternate,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications_none_rounded,
                            color: AppTheme.of(context).secondaryText,
                            size: 40.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: AppTheme.of(context).designToken.spacing.md),
                          child: Text(
                            'No notifications yet',
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
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Skeletonizer(
                  enabled: provider.isLoading,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: itemCount,
                    separatorBuilder: (context, _) => SizedBox(
                        height: AppTheme.of(context).designToken.spacing.sm),
                    itemBuilder: (context, notificationIndex) {
                      if (provider.isLoading) {
                        return Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            color: AppTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                              color: AppTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 46.0,
                                height: 46.0,
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).alternate,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Placeholder notification title'),
                                    SizedBox(height: 6.0),
                                    Text(
                                        'Placeholder notification body text goes here'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      final notificationItem = notification[notificationIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (notificationItem.type ==
                              NotificationType.CHAT.name) {
                            context.pushNamed(
                              ChatPageWidget.routeName,
                              queryParameters: {
                                'conversationId': serializeParam(
                                  notificationItem.referenceId,
                                  ParamType.String,
                                ),
                                'username': serializeParam(
                                  notificationItem.extraData.member.username,
                                  ParamType.String,
                                ),
                                'avatarUrl': serializeParam(
                                  notificationItem.extraData.member.avatarurl,
                                  ParamType.String,
                                ),
                                'jobid': serializeParam(
                                  notificationItem.extraData.member.jobid,
                                  ParamType.String,
                                ),
                                'member': serializeParam(
                                  MembersStruct(
                                    id: notificationItem
                                        .extraData.member.memberId,
                                    name: notificationItem
                                        .extraData.member.username,
                                    avatarUrl: notificationItem
                                        .extraData.member.avatarurl,
                                  ),
                                  ParamType.DataStruct,
                                ),
                              }.withoutNulls,
                            );
                          } else if ((notificationItem.type ==
                                  NotificationType.APPLICATION.name) ||
                              (notificationItem.type ==
                                  NotificationType.PROPOSAL.name)) {
                            context.pushNamed(
                              JobDetailsWidget.routeName,
                              queryParameters: {
                                'jobId': serializeParam(
                                  notificationItem.referenceId,
                                  ParamType.String,
                                ),
                                'jobView': serializeParam(
                                  JobDetailsView.general,
                                  ParamType.Enum,
                                ),
                              }.withoutNulls,
                            );
                          }
                        },
                        child: NotificationItemWidget(
                          key: Key(
                              'Keyohh_${notificationIndex}_of_${notification.length}'),
                          isUnread: !notificationItem.isRead,
                          title: notificationItem.title,
                          time: notificationItem.createdAt,
                          body: notificationItem.message,
                          type: () {
                            if (notificationItem.type ==
                                NotificationType.CHAT.name) {
                              return NotificationType.CHAT;
                            } else if (notificationItem.type ==
                                NotificationType.PROPOSAL.name) {
                              return NotificationType.PROPOSAL;
                            } else if (notificationItem.type ==
                                NotificationType.APPLICATION.name) {
                              return NotificationType.APPLICATION;
                            } else {
                              return NotificationType.APPLICATION;
                            }
                          }(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
