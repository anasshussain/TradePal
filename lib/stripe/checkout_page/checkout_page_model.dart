import '/components/download_p_d_f/download_p_d_f_widget.dart';
import '/components/payment_method_item/payment_method_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'checkout_page_widget.dart' show CheckoutPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckoutPageModel extends FlutterFlowModel<CheckoutPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PaymentMethodItem.
  late PaymentMethodItemModel paymentMethodItemModel1;
  // Model for PaymentMethodItem.
  late PaymentMethodItemModel paymentMethodItemModel2;
  // Model for TextField.
  late TextFieldModel textFieldModel1;
  // Model for TextField.
  late TextFieldModel textFieldModel2;
  // Model for TextField.
  late TextFieldModel textFieldModel3;
  // Model for TextField.
  late TextFieldModel textFieldModel4;
  // Model for TextField.
  late TextFieldModel textFieldModel5;
  // Model for Button.
  late DownloadPDFModel buttonModel;

  @override
  void initState(BuildContext context) {
    paymentMethodItemModel1 =
        createModel(context, () => PaymentMethodItemModel());
    paymentMethodItemModel2 =
        createModel(context, () => PaymentMethodItemModel());
    textFieldModel1 = createModel(context, () => TextFieldModel());
    textFieldModel2 = createModel(context, () => TextFieldModel());
    textFieldModel3 = createModel(context, () => TextFieldModel());
    textFieldModel4 = createModel(context, () => TextFieldModel());
    textFieldModel5 = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => DownloadPDFModel());
  }

  @override
  void dispose() {
    paymentMethodItemModel1.dispose();
    paymentMethodItemModel2.dispose();
    textFieldModel1.dispose();
    textFieldModel2.dispose();
    textFieldModel3.dispose();
    textFieldModel4.dispose();
    textFieldModel5.dispose();
    buttonModel.dispose();
  }
}
