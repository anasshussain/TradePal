import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/empty_list_copy_component_model.dart';
export '/viewmodels/empty_list_copy_component_model.dart';

class EmptyListCopyComponentWidget extends StatefulWidget {
  const EmptyListCopyComponentWidget({
    super.key,
    this.icon,
    this.title,
    this.description,
  });

  final Widget? icon;
  final String? title;
  final String? description;

  @override
  State<EmptyListCopyComponentWidget> createState() =>
      _EmptyListCopyComponentWidgetState();
}

class _EmptyListCopyComponentWidgetState
    extends State<EmptyListCopyComponentWidget> {
  late EmptyListCopyComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyListCopyComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget!.icon!,
          Text(
            valueOrDefault<String>(
              widget!.title,
              'No items found',
            ),
            style: AppTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.manrope(
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        AppTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: AppTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
          Text(
            valueOrDefault<String>(
              widget!.description,
              'The items you are looking for might not exist',
            ),
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
                ),
          ),
        ].divide(const SizedBox(height: AppConstants.childSpacing)),
      ),
    );
  }
}
