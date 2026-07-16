import '/components/download_p_d_f/download_p_d_f_widget.dart';
import '/components/receipt_row/receipt_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'payment_success_widget.dart' show PaymentSuccessWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentSuccessModel extends FlutterFlowModel<PaymentSuccessWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ReceiptRow.
  late ReceiptRowModel receiptRowModel1;
  // Model for ReceiptRow.
  late ReceiptRowModel receiptRowModel2;
  // Model for ReceiptRow.
  late ReceiptRowModel receiptRowModel3;
  // Model for ReceiptRow.
  late ReceiptRowModel receiptRowModel4;
  // Model for Button.
  late DownloadPDFModel buttonModel1;
  // Model for Button.
  late DownloadPDFModel buttonModel2;
  // Model for Button.
  late DownloadPDFModel buttonModel3;

  @override
  void initState(BuildContext context) {
    receiptRowModel1 = createModel(context, () => ReceiptRowModel());
    receiptRowModel2 = createModel(context, () => ReceiptRowModel());
    receiptRowModel3 = createModel(context, () => ReceiptRowModel());
    receiptRowModel4 = createModel(context, () => ReceiptRowModel());
    buttonModel1 = createModel(context, () => DownloadPDFModel());
    buttonModel2 = createModel(context, () => DownloadPDFModel());
    buttonModel3 = createModel(context, () => DownloadPDFModel());
  }

  @override
  void dispose() {
    receiptRowModel1.dispose();
    receiptRowModel2.dispose();
    receiptRowModel3.dispose();
    receiptRowModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
  }
}
