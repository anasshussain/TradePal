import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/job_details_loader_model.dart';
export '/viewmodels/job_details_loader_model.dart';

class JobDetailsLoaderWidget extends StatefulWidget {
  const JobDetailsLoaderWidget({super.key});

  @override
  State<JobDetailsLoaderWidget> createState() => _JobDetailsLoaderWidgetState();
}

class _JobDetailsLoaderWidgetState extends State<JobDetailsLoaderWidget> {
  late JobDetailsLoaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JobDetailsLoaderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(valueOrDefault<double>(
        AppConstants.parentPagePadding,
        0.0,
      )),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: AppTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Container(
              width: 250.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: AppTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Container(
              width: 200.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: AppTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Container(
              width: 200.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: AppTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                color: AppTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                color: AppTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                color: AppTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ]
              .divide(const SizedBox(height: AppConstants.parentPagePadding))
              .addToEnd(const SizedBox(height: 80.0)),
        ),
      ),
    );
  }
}
