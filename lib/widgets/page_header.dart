import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/nav.dart';
import '/core/routes/index.dart';
import '/core/theme/app_theme.dart';

class PageHeaderWidget extends StatelessWidget {
  const PageHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.showNotification = true,
    this.tag
  });

  final String title;
  final String? tag;
  final String subtitle;
  final bool showNotification;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tag != null && tag!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.childSpacing),
                  child: Text(
                    tag!,
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
                style: AppTheme.of(context).displayMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w900,
                    fontStyle: AppTheme.of(context).displayMedium.fontStyle,
                  ),
                  fontSize: 38.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w900,
                  fontStyle: AppTheme.of(context).displayMedium.fontStyle,
                  lineHeight: 1.0,
                ),
              ),

              const SizedBox(height: AppConstants.childSpacing),

              Text(
                subtitle,
                textAlign: TextAlign.start,
                style: AppTheme.of(context).titleSmall.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontStyle: AppTheme.of(context).titleSmall.fontStyle,
                  ),
                  color: AppTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: AppTheme.of(context).titleSmall.fontStyle,
                ),
              ),
            ],
          ),
        ),
        if (showNotification)
          InkWell(
            onTap: () {
              context.pushNamed(NotificationPageWidget.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: SvgPicture.asset(
                'assets/images/bell.svg',
                width: 21.5,
                height: 21.5,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF1B7FA3),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
      ],
    );
  }
}