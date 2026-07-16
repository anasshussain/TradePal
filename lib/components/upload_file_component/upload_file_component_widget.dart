import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'upload_file_component_model.dart';
export 'upload_file_component_model.dart';

class UploadFileComponentWidget extends StatefulWidget {
  const UploadFileComponentWidget({
    super.key,
    this.existingImageUrl,
  });

  final String? existingImageUrl;

  @override
  State<UploadFileComponentWidget> createState() =>
      _UploadFileComponentWidgetState();
}

class _UploadFileComponentWidgetState extends State<UploadFileComponentWidget> {
  late UploadFileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadFileComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((widget!.existingImageUrl != null &&
              widget!.existingImageUrl != '') ||
          (_model.uploadedLocalFile_localUploadedPhoto != null &&
              (_model.uploadedLocalFile_localUploadedPhoto.bytes?.isNotEmpty ??
                  false))) {
        _model.hasData = true;
      }
    });

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
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Builder(
        builder: (context) {
          if (_model.uploadedLocalFile_localUploadedPhoto != null &&
              (_model.uploadedLocalFile_localUploadedPhoto.bytes?.isNotEmpty ??
                  false)) {
            return Container(
              width: 120.0,
              height: 120.0,
              child: Stack(
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0x7A3D3DBB),
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.memory(
                        _model.uploadedLocalFile_localUploadedPhoto.bytes ??
                            Uint8List.fromList([]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, -1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).error,
                        borderRadius: 40.0,
                        borderWidth: 2.0,
                        buttonSize: 40.0,
                        fillColor: Colors.transparent,
                        icon: Icon(
                          Icons.clear_rounded,
                          color: FlutterFlowTheme.of(context).error,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          safeSetState(() {
                            _model.isDataUploading_localUploadedPhoto = false;
                            _model.uploadedLocalFile_localUploadedPhoto =
                                FFUploadedFile(
                                    bytes: Uint8List.fromList([]),
                                    originalFilename: '');
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    final selectedFiles = await selectFiles(
                      multiFile: false,
                    );
                    if (selectedFiles != null) {
                      safeSetState(() =>
                          _model.isDataUploading_localUploadedPhoto = true);
                      var selectedUploadedFiles = <FFUploadedFile>[];

                      try {
                        selectedUploadedFiles = selectedFiles
                            .map((m) => FFUploadedFile(
                                  name: m.storagePath.split('/').last,
                                  bytes: m.bytes,
                                  originalFilename: m.originalFilename,
                                ))
                            .toList();
                      } finally {
                        _model.isDataUploading_localUploadedPhoto = false;
                      }
                      if (selectedUploadedFiles.length ==
                          selectedFiles.length) {
                        safeSetState(() {
                          _model.uploadedLocalFile_localUploadedPhoto =
                              selectedUploadedFiles.first;
                        });
                      } else {
                        safeSetState(() {});
                        return;
                      }
                    }

                    if (_model.uploadedLocalFile_localUploadedPhoto != null &&
                        (_model.uploadedLocalFile_localUploadedPhoto.bytes
                                ?.isNotEmpty ??
                            false)) {
                      _model.hasData = true;
                    }
                  },
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: Color(0x75000088),
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: Image.network(
                          widget!.existingImageUrl != null &&
                                  widget!.existingImageUrl != ''
                              ? widget!.existingImageUrl!
                              : 'https://i.sstatic.net/l60Hf.png',
                        ).image,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 2.0,
                      ),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: FlutterFlowTheme.of(context).accent1,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
