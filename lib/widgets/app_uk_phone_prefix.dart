import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/theme/app_theme.dart';

/// A compact "🇬🇧 +44" prefix meant to be used as a [TextFormField]'s
/// `prefixIcon`, paired with `prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0)`
/// so it hugs its content instead of reserving the default 48x48 box.
class AppUkPhonePrefix extends StatelessWidget {
  const AppUkPhonePrefix({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 8.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '🇬🇧',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(width: 6.0),
          Text(
            '+44',
            style: AppTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                    fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: AppTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
          const SizedBox(width: 8.0),
          Container(
            width: 1.0,
            height: 20.0,
            color: AppTheme.of(context).alternate,
          ),
        ],
      ),
    );
  }
}
