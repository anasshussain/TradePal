import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/text_field_model.dart';
export '/viewmodels/text_field_model.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    String? label,
    bool? labelPresent,
    String? helper,
    bool? helperPresent,
    String? hint,
    String? value,
    String? onChange,
    String? onSubmit,
    this.leadingIcon,
    bool? leadingIconPresent,
    this.trailingIcon,
    bool? trailingIconPresent,
    String? variant,
    bool? error,
  })  : this.label = label ?? 'Card Number',
        this.labelPresent = labelPresent ?? true,
        this.helper = helper ?? '',
        this.helperPresent = helperPresent ?? false,
        this.hint = hint ?? '0000 0000 0000 0000',
        this.value = value ?? '',
        this.onChange = onChange ?? '',
        this.onSubmit = onSubmit ?? '',
        this.leadingIconPresent = leadingIconPresent ?? true,
        this.trailingIconPresent = trailingIconPresent ?? false,
        this.variant = variant ?? 'outlined',
        this.error = error ?? false;

  final String label;
  final bool labelPresent;
  final String helper;
  final bool helperPresent;
  final String hint;
  final String value;
  final String onChange;
  final String onSubmit;
  final Widget? leadingIcon;
  final bool leadingIconPresent;
  final Widget? trailingIcon;
  final bool trailingIconPresent;
  final String variant;
  final bool error;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TextFieldModel());

    _model.inputTextController ??= TextEditingController(text: widget!.value);
    _model.inputFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (valueOrDefault<bool>(
            widget!.labelPresent,
            true,
          ))
            Text(
              valueOrDefault<String>(
                widget!.label,
                'Card Number',
              ),
              style: AppTheme.of(context).labelMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          AppTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          AppTheme.of(context).labelMedium.fontStyle,
                    ),
                    color: widget!.error
                        ? AppTheme.of(context).error
                        : AppTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        AppTheme.of(context).labelMedium.fontWeight,
                    fontStyle:
                        AppTheme.of(context).labelMedium.fontStyle,
                    lineHeight: 1.4,
                  ),
            ),
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: () {
                if (widget!.variant == 'filled') {
                  return AppTheme.of(context).secondaryBackground;
                } else if (widget!.variant == 'ghost') {
                  return Colors.transparent;
                } else {
                  return Colors.transparent;
                }
              }(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(valueOrDefault<double>(
                  () {
                    if (widget!.variant == 'filled') {
                      return 4.0;
                    } else if (widget!.variant == 'ghost') {
                      return 4.0;
                    } else {
                      return 4.0;
                    }
                  }(),
                  0.0,
                )),
                topRight: Radius.circular(valueOrDefault<double>(
                  () {
                    if (widget!.variant == 'filled') {
                      return 4.0;
                    } else if (widget!.variant == 'ghost') {
                      return 4.0;
                    } else {
                      return 4.0;
                    }
                  }(),
                  0.0,
                )),
                bottomLeft: Radius.circular(valueOrDefault<double>(
                  () {
                    if (widget!.variant == 'filled') {
                      return 4.0;
                    } else if (widget!.variant == 'ghost') {
                      return 4.0;
                    } else {
                      return 4.0;
                    }
                  }(),
                  0.0,
                )),
                bottomRight: Radius.circular(valueOrDefault<double>(
                  () {
                    if (widget!.variant == 'filled') {
                      return 4.0;
                    } else if (widget!.variant == 'ghost') {
                      return 4.0;
                    } else {
                      return 4.0;
                    }
                  }(),
                  0.0,
                )),
              ),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: () {
                  if (widget!.error) {
                    return AppTheme.of(context).error;
                  } else if (widget!.variant == 'filled') {
                    return Colors.transparent;
                  } else if (widget!.variant == 'ghost') {
                    return Colors.transparent;
                  } else {
                    return AppTheme.of(context).alternate;
                  }
                }(),
                width: () {
                  if (widget!.error) {
                    return 1.0;
                  } else if (widget!.variant == 'filled') {
                    return 1.0;
                  } else if (widget!.variant == 'ghost') {
                    return 0.0;
                  } else {
                    return 1.0;
                  }
                }(),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  valueOrDefault<double>(
                    () {
                      if (widget!.variant == 'filled') {
                        return 8.0;
                      } else if (widget!.variant == 'ghost') {
                        return 8.0;
                      } else {
                        return 8.0;
                      }
                    }(),
                    0.0,
                  ),
                  valueOrDefault<double>(
                    () {
                      if (widget!.variant == 'filled') {
                        return 8.0;
                      } else if (widget!.variant == 'ghost') {
                        return 8.0;
                      } else {
                        return 8.0;
                      }
                    }(),
                    0.0,
                  ),
                  valueOrDefault<double>(
                    () {
                      if (widget!.variant == 'filled') {
                        return 8.0;
                      } else if (widget!.variant == 'ghost') {
                        return 8.0;
                      } else {
                        return 8.0;
                      }
                    }(),
                    0.0,
                  ),
                  valueOrDefault<double>(
                    () {
                      if (widget!.variant == 'filled') {
                        return 8.0;
                      } else if (widget!.variant == 'ghost') {
                        return 8.0;
                      } else {
                        return 8.0;
                      }
                    }(),
                    0.0,
                  )),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (valueOrDefault<bool>(
                    widget!.leadingIconPresent,
                    true,
                  ))
                    widget!.leadingIcon!,
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _model.inputTextController,
                      focusNode: _model.inputFocusNode,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: valueOrDefault<String>(
                          widget!.hint,
                          '0000 0000 0000 0000',
                        ),
                        hintStyle: AppTheme.of(context)
                            .bodyMedium
                            .override(
                              font: GoogleFonts.manrope(
                                fontWeight: AppTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: AppTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: () {
                                if (widget!.variant == 'filled') {
                                  return AppTheme.of(context).accent3;
                                } else if (widget!.variant == 'ghost') {
                                  return AppTheme.of(context).accent3;
                                } else {
                                  return AppTheme.of(context).accent3;
                                }
                              }(),
                              letterSpacing: 0.0,
                              fontWeight: AppTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                              lineHeight: 1.5,
                            ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                      style: AppTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.manrope(
                              fontWeight: AppTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: AppTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: () {
                              if (widget!.variant == 'filled') {
                                return AppTheme.of(context).primaryText;
                              } else if (widget!.variant == 'ghost') {
                                return AppTheme.of(context).primaryText;
                              } else {
                                return AppTheme.of(context).primaryText;
                              }
                            }(),
                            letterSpacing: 0.0,
                            fontWeight: AppTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: AppTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                            lineHeight: 1.5,
                          ),
                      validator: _model.inputTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  if (valueOrDefault<bool>(
                    widget!.trailingIconPresent,
                    false,
                  ))
                    widget!.trailingIcon!,
                ],
              ),
            ),
          ),
          if (valueOrDefault<bool>(
            widget!.helperPresent,
            false,
          ))
            Text(
              widget!.helper,
              style: AppTheme.of(context).bodySmall.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          AppTheme.of(context).bodySmall.fontWeight,
                      fontStyle:
                          AppTheme.of(context).bodySmall.fontStyle,
                    ),
                    color: widget!.error
                        ? AppTheme.of(context).error
                        : AppTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        AppTheme.of(context).bodySmall.fontWeight,
                    fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                    lineHeight: 1.4,
                  ),
            ),
        ].divide(SizedBox(height: 6.0)),
      ),
    );
  }
}
