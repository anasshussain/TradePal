import '/widgets/app_radio_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/core/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/theme_picker_model.dart';
export '/viewmodels/theme_picker_model.dart';

class ThemePickerWidget extends StatefulWidget {
  const ThemePickerWidget({super.key});

  @override
  State<ThemePickerWidget> createState() => _ThemePickerWidgetState();
}

class _ThemePickerWidgetState extends State<ThemePickerWidget> {
  late ThemePickerModel _model;

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
      // yahan explicitly latest value set karo
      _model.radioButtonValueController ??=
          FormFieldController<String>(AppState().selectedTheme);
      _model.radioButtonValueController!.value = AppState().selectedTheme;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    _model.radioButtonValueController ??=
        FormFieldController<String>(AppState().selectedTheme);
    if (_model.radioButtonValueController!.value != AppState().selectedTheme) {
      _model.radioButtonValueController!.value = AppState().selectedTheme;
    }
    return Container(
      width: 300.0,
      height: 170.0,
      decoration: BoxDecoration(
        color: AppTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(valueOrDefault<double>(
          AppConstants.childPadding,
          0.0,
        )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Theme',
              style: AppTheme.of(context).titleSmall.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          AppTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          AppTheme.of(context).titleSmall.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        AppTheme.of(context).titleSmall.fontWeight,
                    fontStyle:
                        AppTheme.of(context).titleSmall.fontStyle,
                  ),
            ),
            AppRadioButton(
              options: ['Dark Mode', 'Light Mode', 'System Default'].toList(),
              onChanged: (val) async {
                safeSetState(() {});
                AppState().selectedTheme = _model.radioButtonValue!;
                safeSetState(() {});
                if (_model.radioButtonValue == 'Dark Mode') {
                  setDarkModeSetting(context, ThemeMode.dark);
                } else if (_model.radioButtonValue == 'Light Mode') {
                  setDarkModeSetting(context, ThemeMode.light);
                } else {
                  setDarkModeSetting(context, ThemeMode.system);
                }
              },
              controller: _model.radioButtonValueController!,
              // FormFieldController<String>(AppState().selectedTheme),
              optionHeight: 32.0,
              textStyle: AppTheme.of(context).bodyLarge.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          AppTheme.of(context).bodyLarge.fontWeight,
                      fontStyle:
                          AppTheme.of(context).bodyLarge.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        AppTheme.of(context).bodyLarge.fontWeight,
                    fontStyle: AppTheme.of(context).bodyLarge.fontStyle,
                  ),
              selectedTextStyle:
                  AppTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              AppTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: AppTheme.of(context).primaryText,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            AppTheme.of(context).bodyMedium.fontStyle,
                      ),
              buttonPosition: RadioButtonPosition.left,
              direction: Axis.vertical,
              radioButtonColor: AppTheme.of(context).primaryText,
              inactiveRadioButtonColor:
                  AppTheme.of(context).secondaryText,
              toggleable: false,
              horizontalAlignment: WrapAlignment.start,
              verticalAlignment: WrapCrossAlignment.start,
            ),
          ].divide(const SizedBox(height: AppConstants.spacing)),
        ),
      ),
    );
  }
}