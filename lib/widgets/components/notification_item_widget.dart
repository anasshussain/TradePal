import '/utils/enums/enums.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/notification_item_model.dart';
export '/viewmodels/notification_item_model.dart';

class NotificationItemWidget extends StatefulWidget {
  const NotificationItemWidget({
    super.key,
    bool? isUnread,
    String? title,
    String? time,
    String? body,
    required this.type,
  })  : this.isUnread = isUnread ?? true,
        this.title = title ?? 'Trade Proposal Received',
        this.time = time ?? '2m ago',
        this.body = body ??
            'Alex Rivera sent a swap request for your Vintage Power Drill.';

  final bool isUnread;
  final String title;
  final String time;
  final String body;
  final NotificationType? type;

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  late NotificationItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationItemModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUnread = valueOrDefault<bool>(widget!.isUnread, true);

    return Container(
      decoration: BoxDecoration(
        color: isUnread
            ? AppTheme.of(context).primary.withOpacity(0.06)
            : AppTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: isUnread
              ? AppTheme.of(context).primary.withOpacity(0.15)
              : AppTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12.0, 14.0, 12.0, 14.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(
              builder: (context) {
                Color color;
                IconData icon;
                switch (widget!.type) {
                  case NotificationType.CHAT:
                    color = AppTheme.of(context).warning;
                    icon = Icons.chat_rounded;
                  case NotificationType.PROPOSAL:
                    color = AppTheme.of(context).success;
                    icon = Icons.swap_horiz_rounded;
                  case NotificationType.APPLICATION:
                    color = AppTheme.of(context).primary;
                    icon = Icons.assignment_outlined;
                  default:
                    color = AppTheme.of(context).secondaryText;
                    icon = Icons.notifications_rounded;
                }
                final iconColor = color.computeLuminance() > 0.5
                    ? Colors.black.withOpacity(0.75)
                    : Colors.white;
                return Container(
                  width: 46.0,
                  height: 46.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 22.0,
                  ),
                );
              },
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          valueOrDefault<String>(
                            widget!.title,
                            'New Proposal Received',
                          ),
                          maxLines: 1,
                          style: AppTheme.of(context).titleSmall.override(
                                font: GoogleFonts.manrope(
                                  fontWeight: AppTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle:
                                      AppTheme.of(context).titleSmall.fontStyle,
                                ),
                                color: AppTheme.of(context).primaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight:
                                    AppTheme.of(context).titleSmall.fontWeight,
                                fontStyle:
                                    AppTheme.of(context).titleSmall.fontStyle,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        valueOrDefault<String>(
                          functions.timeAgo(widget!.time),
                          '2m ago',
                        ),
                        style: AppTheme.of(context).labelSmall.override(
                              font: GoogleFonts.inter(
                                fontWeight:
                                    AppTheme.of(context).labelSmall.fontWeight,
                                fontStyle:
                                    AppTheme.of(context).labelSmall.fontStyle,
                              ),
                              color: AppTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight:
                                  AppTheme.of(context).labelSmall.fontWeight,
                              fontStyle:
                                  AppTheme.of(context).labelSmall.fontStyle,
                              lineHeight: 1.4,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    widget!.body,
                    maxLines: 4,
                    style: AppTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight:
                                AppTheme.of(context).bodyMedium.fontWeight,
                            fontStyle:
                                AppTheme.of(context).bodyMedium.fontStyle,
                          ),
                          color: AppTheme.of(context).secondaryText,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight:
                              AppTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.4,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ].divide(const SizedBox(height: 2.0)),
              ),
            ),
          ].divide(const SizedBox(width: 10.0)),
        ),
      ),
    );
  }
}
