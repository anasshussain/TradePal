import 'package:skeletonizer/skeletonizer.dart';
import '/repositories/api_requests/api_calls.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/customer_navbar/customer_navbar_widget.dart';
import '/widgets/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import 'package:flutter/material.dart';
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
  static bool _hasLoadedTradePersonsOnce = false;

  late Future<ApiCallResponse> _tradePersonListFuture;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BrowseTradePersonModel());
    _tradePersonListFuture = _fetchTradePersons();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }
  Future<ApiCallResponse> _fetchTradePersons() async {
    // Placeholder — real API call ready hote hi yahan replace karna hai.
    await Future.delayed(const Duration(milliseconds: 800));
    final response = ApiCallResponse(null, {}, 200);
    _hasLoadedTradePersonsOnce = true;
    return response;
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
          actions: const [],
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
                child: FutureBuilder<ApiCallResponse>(
                  future: _tradePersonListFuture,
                  builder: (context, snapshot) {
                    // Skeleton sirf pehli dafa dikhega (jab tak kabhi
                    // successfully load nahi hua). Baad mein hamesha
                    // silently refresh hoga, koi loader nahi dikhega.
                    final isLoading = !_hasLoadedTradePersonsOnce &&
                        snapshot.connectionState == ConnectionState.waiting;

                    return RefreshIndicator(
                      color: AppTheme.of(context).primary,
                      onRefresh: () async {
                        setState(() {
                          _tradePersonListFuture = _fetchTradePersons();
                        });
                      },
                      child: SingleChildScrollView(
                        child: Skeletonizer(
                          enabled: isLoading,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              wrapWithModel(
                                model: _model.pageHeaderSectiomModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const PageHeaderSectiomWidget(
                                  tag: 'DISCOVER EXCELLENCE',
                                  title: 'Expert Hands for\nProfessional\nResults',
                                  subtitle: 'default text',
                                  numberOfItems: 100,
                                  itemText: 'Vetted Pros',
                                ),
                              ),
                              _buildTradePersonSkeletonList(context),
                            ].divide(
                                const SizedBox(height: AppConstants.spacing)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.customerNavbarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: const Hero(
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

  Widget _buildTradePersonSkeletonList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (_, __) =>
      const SizedBox(height: AppConstants.childPadding),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Placeholder tradeperson name'),
                  SizedBox(height: 6),
                  Text('Placeholder tradeperson subtitle'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}