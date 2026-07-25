import 'package:skeletonizer/skeletonizer.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/notification_item_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/notification_page_provider.dart';
import '/viewmodels/notification_page_model.dart';
export '/viewmodels/notification_page_model.dart';

/// create a notification page
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

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _provider.setLoading(true); // loading start

      _model.notifications = await SupabaseTablesGroup.getNotificationsCall.call(
        userId: currentUserUid,
      );

      if ((_model.notifications?.succeeded ?? true)) {
        _provider.notificationsPageState = ((_model.notifications?.jsonBody ?? '')
            .toList()
            .map<NotificationsStruct?>(NotificationsStruct.maybeFromMap)
            .toList() as Iterable<NotificationsStruct?>)
            .withoutNulls
            .toList()
            .cast<NotificationsStruct>();
      }
      _provider.setLoading(false);
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
          top: true,
          child: Padding(
            padding: EdgeInsets.all(
                AppTheme.of(context).designToken.spacing.lg),
            child: Consumer<NotificationPageProvider>(
              builder: (context, provider, _) {
                final notification = provider.notificationsPageState.toList();
                final itemCount = provider.isLoading ? 6 : notification.length;

                return Skeletonizer(
                  enabled: provider.isLoading,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: notification.length,
                    itemBuilder: (context, notificationIndex) {
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
                          isUnread: true,
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
