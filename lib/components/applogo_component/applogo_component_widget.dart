import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'applogo_component_model.dart';
export 'applogo_component_model.dart';

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
