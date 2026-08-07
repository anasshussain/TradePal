import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/theme_picker_model.dart';
export '/viewmodels/theme_picker_model.dart';

class _ThemeOption {
  const _ThemeOption(this.label, this.icon, this.mode);

  final String label;
  final IconData icon;
  final ThemeMode mode;
}

const _themeOptions = [
  _ThemeOption('Light Mode', Icons.light_mode_rounded, ThemeMode.light),
  _ThemeOption('Dark Mode', Icons.dark_mode_rounded, ThemeMode.dark),
  _ThemeOption(
      'System Default', Icons.brightness_auto_rounded, ThemeMode.system),
];

class ThemePickerWidget extends StatefulWidget {
  const ThemePickerWidget({super.key});

  @override
  State<ThemePickerWidget> createState() => _ThemePickerWidgetState();
}

class _ThemePickerWidgetState extends State<ThemePickerWidget> {
  late ThemePickerModel _model;

  String _resolveTheme() {
    final current = AppState().selectedTheme;
    return current.isEmpty ? 'System Default' : current;
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ThemePickerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AppState().selectedTheme.isEmpty) {
        AppState().selectedTheme = _resolveTheme();
      }
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  void _selectTheme(_ThemeOption option) {
    if (_resolveTheme() == option.label) return;
    safeSetState(() {
      AppState().selectedTheme = option.label;
    });
    setDarkModeSetting(context, option.mode);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();
    final selectedLabel = _resolveTheme();

    return Container(
      width: 320.0,
      decoration: BoxDecoration(
        color: AppTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [AppTheme.of(context).designToken.shadow.md],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Appearance',
                  style: AppTheme.of(context).titleMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontStyle: AppTheme.of(context).titleMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: AppTheme.of(context).titleMedium.fontStyle,
                      ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.close_rounded,
                      size: 20.0,
                      color: AppTheme.of(context).secondaryText,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 16.0),
              child: Text(
                'Choose how My Trade Pal looks on this device.',
                style: AppTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(
                        fontWeight: AppTheme.of(context).bodySmall.fontWeight,
                        fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                      ),
                      color: AppTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight: AppTheme.of(context).bodySmall.fontWeight,
                      fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                    ),
              ),
            ),
            ..._themeOptions
                .map((option) {
                  final isSelected = option.label == selectedLabel;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14.0),
                      onTap: () => _selectTheme(option),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.of(context).primary.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).alternate,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              option.icon,
                              size: 20.0,
                              color: isSelected
                                  ? AppTheme.of(context).primary
                                  : AppTheme.of(context).secondaryText,
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Text(
                                option.label,
                                style: AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: isSelected
                                          ? AppTheme.of(context).primary
                                          : AppTheme.of(context).primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                size: 20.0,
                                color: AppTheme.of(context).primary,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                .toList()
                .divide(const SizedBox(height: 10.0)),
          ],
        ),
      ),
    );
  }
}
