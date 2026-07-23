import '/widgets/components/download_p_d_f/download_p_d_f_widget.dart';
import '/widgets/components/payment_method_item/payment_method_item_widget.dart';
import '/widgets/components/text_field/text_field_widget.dart';
import '/widgets/app_icon_button.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/checkout_page_provider.dart';
import '/viewmodels/checkout_page_model.dart';
export '/viewmodels/checkout_page_model.dart';

class CheckoutPageWidget extends StatefulWidget {
  const CheckoutPageWidget({super.key});

  static String routeName = 'checkout_page';
  static String routePath = '/checkoutPage';

  @override
  State<CheckoutPageWidget> createState() => _CheckoutPageWidgetState();
}

class _CheckoutPageWidgetState extends State<CheckoutPageWidget> {
  late CheckoutPageModel _model;
  final CheckoutPageProvider _provider = CheckoutPageProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckoutPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.update(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    _provider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckoutPageProvider>.value(
      value: _provider,
      child: Consumer<CheckoutPageProvider>(
        builder: (context, _, __) => _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppIconButton(
                              borderRadius: 8.0,
                              buttonSize: 40.0,
                              fillColor: Colors.transparent,
                              icon: Icon(
                                Icons.close_rounded,
                                color:
                                    AppTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                            Text(
                              'Checkout',
                              style: AppTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: AppTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: AppTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                            Container(
                              width: 40.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).alternate,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F9FC),
                        borderRadius: BorderRadius.circular(12.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: AppTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Order Summary',
                                    style: AppTheme.of(context)
                                        .labelLarge
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .labelLarge
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                  Text(
                                    '#SW-9921',
                                    style: AppTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: const Color(0xFF1A1F36),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.3,
                                        ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 16.0,
                                thickness: 1.0,
                                indent: 0.0,
                                endIndent: 0.0,
                                color: AppTheme.of(context).alternate,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 48.0,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: AppTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.shopping_bag_rounded,
                                      color:
                                          AppTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Pro Plan Subscription',
                                          maxLines: 1,
                                          style: AppTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                                lineHeight: 1.5,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Billed monthly',
                                          style: AppTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      AppTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    AppTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    AppTheme.of(context)
                                                        .bodySmall
                                                        .fontWeight,
                                                fontStyle:
                                                    AppTheme.of(context)
                                                        .bodySmall
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                      ].divide(const SizedBox(height: 4.0)),
                                    ),
                                  ),
                                  Text(
                                    '\$29.00',
                                    style: AppTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ].divide(const SizedBox(width: 16.0)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0x80FFFFFF),
                                  borderRadius: BorderRadius.circular(8.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Subtotal',
                                              style: AppTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontStyle,
                                                    ),
                                                    color: AppTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              '\$29.00',
                                              style: AppTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontStyle,
                                                    ),
                                                    color: AppTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Tax (0%)',
                                              style: AppTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontStyle,
                                                    ),
                                                    color: AppTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              '\$0.00',
                                              style: AppTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontStyle,
                                                    ),
                                                    color: AppTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 16.0,
                                          thickness: 1.0,
                                          indent: 0.0,
                                          endIndent: 0.0,
                                          color: AppTheme.of(context)
                                              .alternate,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Total due today',
                                              style: AppTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                    lineHeight: 1.5,
                                                  ),
                                            ),
                                            Text(
                                              '\$29.00',
                                              style: AppTheme.of(
                                                      context)
                                                  .titleMedium
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontStyle:
                                                          AppTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontStyle,
                                                    ),
                                                    color: AppTheme.of(
                                                            context)
                                                        .primary,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w800,
                                                    fontStyle:
                                                        AppTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ].divide(const SizedBox(height: 8.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(const SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Payment Method',
                          style:
                              AppTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: AppTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                        ),
                        wrapWithModel(
                          model: _model.paymentMethodItemModel1,
                          updateCallback: () => _provider.update(() {}),
                          child: PaymentMethodItemWidget(
                            icon: Icon(
                              Icons.credit_card_rounded,
                              color: AppTheme.of(context).primary,
                              size: 24.0,
                            ),
                            label: 'Credit Card',
                            selected: false,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.paymentMethodItemModel2,
                          updateCallback: () => _provider.update(() {}),
                          child: PaymentMethodItemWidget(
                            icon: Icon(
                              Icons.apple,
                              color: AppTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            label: 'Apple Pay',
                            selected: true,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: AppTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.textFieldModel1,
                                    updateCallback: () => _provider.update(() {}),
                                    child: const TextFieldWidget(
                                      label: 'Card Number',
                                      labelPresent: true,
                                      helper: '',
                                      helperPresent: false,
                                      hint: '0000 0000 0000 0000',
                                      value: '',
                                      onChange: '',
                                      onSubmit: '',
                                      leadingIcon: Icon(
                                        Icons.credit_card_rounded,
                                      ),
                                      leadingIconPresent: true,
                                      trailingIconPresent: false,
                                      variant: 'outlined',
                                      error: false,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: wrapWithModel(
                                          model: _model.textFieldModel2,
                                          updateCallback: () =>
                                              _provider.update(() {}),
                                          child: const TextFieldWidget(
                                            label: 'Expiry',
                                            labelPresent: true,
                                            helper: '',
                                            helperPresent: false,
                                            hint: 'MM/YY',
                                            value: '',
                                            onChange: '',
                                            onSubmit: '',
                                            leadingIconPresent: false,
                                            trailingIconPresent: false,
                                            variant: 'outlined',
                                            error: false,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: wrapWithModel(
                                          model: _model.textFieldModel3,
                                          updateCallback: () =>
                                              _provider.update(() {}),
                                          child: const TextFieldWidget(
                                            label: 'CVC',
                                            labelPresent: true,
                                            helper: '',
                                            helperPresent: false,
                                            hint: '123',
                                            value: '',
                                            onChange: '',
                                            onSubmit: '',
                                            leadingIconPresent: false,
                                            trailingIcon: Icon(
                                              Icons.help_outline_rounded,
                                            ),
                                            trailingIconPresent: true,
                                            variant: 'outlined',
                                            error: false,
                                          ),
                                        ),
                                      ),
                                    ].divide(const SizedBox(width: 16.0)),
                                  ),
                                  wrapWithModel(
                                    model: _model.textFieldModel4,
                                    updateCallback: () => _provider.update(() {}),
                                    child: const TextFieldWidget(
                                      label: 'Cardholder Name',
                                      labelPresent: true,
                                      helper: '',
                                      helperPresent: false,
                                      hint: 'Alex Rivera',
                                      value: '',
                                      onChange: '',
                                      onSubmit: '',
                                      leadingIconPresent: false,
                                      trailingIconPresent: false,
                                      variant: 'outlined',
                                      error: false,
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ),
                        wrapWithModel(
                          model: _model.textFieldModel5,
                          updateCallback: () => _provider.update(() {}),
                          child: const TextFieldWidget(
                            label: 'Country or region',
                            labelPresent: true,
                            helper: '',
                            helperPresent: false,
                            hint: 'Type here...',
                            value: 'United States',
                            onChange: '',
                            onSubmit: '',
                            leadingIconPresent: false,
                            trailingIcon: Icon(
                              Icons.expand_more_rounded,
                            ),
                            trailingIconPresent: true,
                            variant: 'outlined',
                            error: false,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock_rounded,
                              color: AppTheme.of(context).secondaryText,
                              size: 14.0,
                            ),
                            Text(
                              'Payments are secure and encrypted',
                              style: AppTheme.of(context)
                                  .labelSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                    lineHeight: 1.3,
                                  ),
                            ),
                          ].divide(const SizedBox(width: 4.0)),
                        ),
                      ].divide(const SizedBox(height: 16.0)),
                    ),
                  ].divide(const SizedBox(height: 24.0)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 1.0,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).alternate,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            wrapWithModel(
                              model: _model.buttonModel,
                              updateCallback: () => _provider.update(() {}),
                              child: const DownloadPDFWidget(
                                content: 'Pay \$29.00',
                                iconPresent: false,
                                iconEndPresent: false,
                                variant: 'primary',
                                size: 'large',
                                fullWidth: true,
                                loading: false,
                                disabled: false,
                              ),
                            ),
                            Text(
                              'By confirming your subscription, you allow SwiftPay to charge your card for future payments in accordance with their terms.',
                              textAlign: TextAlign.center,
                              style: AppTheme.of(context)
                                  .labelSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                    lineHeight: 1.3,
                                  ),
                            ),
                          ].divide(const SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
