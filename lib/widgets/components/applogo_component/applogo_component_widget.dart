import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/applogo_component_model.dart';
export '/viewmodels/applogo_component_model.dart';

class ApplogoComponentWidget extends StatefulWidget {
  const ApplogoComponentWidget({super.key});

  @override
  State<ApplogoComponentWidget> createState() => _ApplogoComponentWidgetState();
}

class _ApplogoComponentWidgetState extends State<ApplogoComponentWidget> {
  late ApplogoComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApplogoComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: Image.asset(
        'assets/images/logo-removebg-preview.png',
        width: 120.0,
        height: 120.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
