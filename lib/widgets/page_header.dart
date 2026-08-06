import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/nav.dart';
import '/core/routes/index.dart';
import '/core/state/app_state.dart';
import '/core/theme/app_theme.dart';
import '/widgets/app_icon_button.dart';

class PageHeaderWidget extends StatelessWidget {
  const PageHeaderWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.showNotification = true,
    this.showBackButton = false,
    this.tag,
  });

  final String title;
  final String? tag;
  final String? subtitle;
  final bool showNotification;

  /// Shows a leading back arrow instead of relying on a Scaffold AppBar.
  /// Off by default since most current callers are tab roots with nothing
  /// to go back to.
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow(context),
        Divider(
          height: 3.0,
          thickness: 1.0,
          color: AppTheme.of(context).alternate,
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showBackButton)
          Padding(
            padding: const EdgeInsets.only(right: AppConstants.childSpacing),
            child: AppIconButton(
              borderRadius: 8.0,
              buttonSize: 40.0,
              icon: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 24.0,
                color: AppTheme.of(context).primaryText,
              ),
              onPressed: () async => Navigator.of(context).maybePop(),
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tag != null && tag!.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: AppConstants.childSpacing),
                  child: Text(
                    tag!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.of(context).bodySmall.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                          ),
                          color: AppTheme.of(context).primary,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.of(context).titleLarge.override(
                      font: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        fontStyle: AppTheme.of(context).titleLarge.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: AppTheme.of(context).titleLarge.fontStyle,
                      lineHeight: 1.2,
                    ),
              ),
              if (subtitle != null && subtitle!.isNotEmpty) ...[
                const SizedBox(height: 6.0),
                Text(
                  subtitle!,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.of(context).labelMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              AppTheme.of(context).labelMedium.fontStyle,
                        ),
                        color: AppTheme.of(context).secondaryText,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle: AppTheme.of(context).labelMedium.fontStyle,
                        lineHeight: 1.45,
                      ),
                ),
              ],
            ],
          ),
        ),
        if (showNotification)
          Padding(
            padding: const EdgeInsets.only(left: AppConstants.childSpacing),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AppIconButton(
                  borderRadius: 8.0,
                  buttonSize: 40.0,
                  icon: SvgPicture.asset(
                    'assets/images/bell.svg',
                    width: 20.0,
                    height: 20.0,
                    colorFilter: ColorFilter.mode(
                      AppTheme.of(context).primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () async =>
                      context.pushNamed(NotificationPageWidget.routeName),
                ),
                if (AppState().unreadNotificationsCount > 0)
                  Positioned(
                    top: 2.0,
                    right: 2.0,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 16.0,
                        minHeight: 16.0,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF3B30),
                        borderRadius: BorderRadius.circular(999.0),
                        border: Border.all(
                          color: AppTheme.of(context).primaryBackground,
                          width: 1.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppState().unreadNotificationsCount > 99
                            ? '99+'
                            : AppState().unreadNotificationsCount.toString(),
                        style: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: Colors.white,
                              fontSize: 9.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
