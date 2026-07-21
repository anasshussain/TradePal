import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/customer_navbar/customer_navbar_widget.dart';
import '/widgets/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/browse_trade_person_model.dart';
export '/viewmodels/browse_trade_person_model.dart';

class BrowseTradePersonWidget extends StatefulWidget {
  const BrowseTradePersonWidget({super.key});

  static String routeName = 'browse_trade_person';
  static String routePath = '/browseTradePerson';

  @override
  State<BrowseTradePersonWidget> createState() =>
      _BrowseTradePersonWidgetState();
}

class _BrowseTradePersonWidgetState extends State<BrowseTradePersonWidget> {
  late BrowseTradePersonModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BrowseTradePersonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: AppbarComponentWidget(
              title: 'Browse Tradeperson',
              showAction: false,
              action: () async {},
            ),
          ),
          actions: [],
          centerTitle: false,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(valueOrDefault<double>(
                  AppConstants.parentPagePadding,
                  0.0,
                )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      wrapWithModel(
                        model: _model.pageHeaderSectiomModel,
                        updateCallback: () => safeSetState(() {}),
                        child: PageHeaderSectiomWidget(
                          tag: 'DISCOVER EXCELLENCE',
                          title: 'Expert Hands for\nProfessional\nResults',
                          subtitle: 'default text',
                          numberOfItems: 100,
                          itemText: 'Vetted Pros',
                        ),
                      ),
                    ].divide(SizedBox(height: AppConstants.spacing)),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.customerNavbarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: Hero(
                    tag: 'myHeroTag',
                    transitionOnUserGestures: true,
                    child: Material(
                      color: Colors.transparent,
                      child: CustomerNavbarWidget(
                        selectedIndex: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
