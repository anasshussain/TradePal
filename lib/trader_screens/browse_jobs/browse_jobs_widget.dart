import '/utils/enums/enums.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/jobs_list/jobs_list_widget.dart';
import '/widgets/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/widgets/components/tp_navbar/tp_navbar_widget.dart';
import '/widgets/app_drop_down.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import '/core/utils/form_field_controller.dart';
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/browse_jobs_provider.dart';
import '/viewmodels/browse_jobs_model.dart';
export '/viewmodels/browse_jobs_model.dart';

class BrowseJobsWidget extends StatefulWidget {
  const BrowseJobsWidget({super.key});

  static String routeName = 'browse_jobs';
  static String routePath = '/browseJobs';

  @override
  State<BrowseJobsWidget> createState() => _BrowseJobsWidgetState();
}

class _BrowseJobsWidgetState extends State<BrowseJobsWidget> {
  late BrowseJobsModel _model;
  final BrowseJobsProvider _provider = BrowseJobsProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BrowseJobsModel());

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
    context.watch<AppState>();

    return ChangeNotifierProvider<BrowseJobsProvider>.value(
      value: _provider,
      child: Consumer<BrowseJobsProvider>(
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
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => _provider.update(() {}),
            child: AppbarComponentWidget(
              title: 'Home',
              showAction: true,
              actionIcon: Icon(
                Icons.notifications_rounded,
                color: AppTheme.of(context).secondary,
              ),
              action: () async {
                context.pushNamed(NotificationPageWidget.routeName);
              },
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      wrapWithModel(
                        model: _model.pageHeaderSectiomModel,
                        updateCallback: () => _provider.update(() {}),
                        child: PageHeaderSectiomWidget(
                          tag: 'MARKETPLACE',
                          title: 'Available Jobs',
                          subtitle:
                              'Browse premium local contracts and expand your artisan portfolio. Verified clients only.',
                          numberOfItems: valueOrDefault<int>(
                            AppState().jobCache.jobs.length,
                            0,
                          ),
                          itemText: 'Jobs nearby',
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Material(
                          color: Colors.transparent,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppTheme.of(context)
                                    .designToken
                                    .radius
                                    .lg),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).alternate,
                              borderRadius: BorderRadius.circular(
                                  AppTheme.of(context)
                                      .designToken
                                      .radius
                                      .lg),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(valueOrDefault<double>(
                                AppConstants.childPadding,
                                0.0,
                              )),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppDropDown<String>(
                                    controller:
                                        _model.dropDownValueController1 ??=
                                            FormFieldController<String>(null),
                                    options: AppState().availableServices,
                                    onChanged: (val) => _provider.update(
                                        () => _model.dropDownValue1 = val),
                                    width: double.infinity,
                                    height: 50.0,
                                    maxHeight: 200.0,
                                    textStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    hintText: 'Plumbing..',
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    fillColor: AppTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 2.0,
                                    borderColor:
                                        AppTheme.of(context).border,
                                    borderWidth: 0.0,
                                    borderRadius: 8.0,
                                    margin: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 12.0, 0.0),
                                    hidesUnderline: true,
                                    isOverButton: false,
                                    isSearchable: false,
                                    isMultiSelect: false,
                                  ),
                                  AppDropDown<String>(
                                    controller:
                                        _model.dropDownValueController2 ??=
                                            FormFieldController<String>(null),
                                    options: const [
                                      '100',
                                      '200',
                                      '300',
                                      '400',
                                      '500',
                                      '600',
                                      '700',
                                      '800',
                                      '900',
                                      '1000'
                                    ],
                                    onChanged: (val) => _provider.update(
                                        () => _model.dropDownValue2 = val),
                                    width: double.infinity,
                                    height: 50.0,
                                    textStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    hintText: '\$100',
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    fillColor: AppTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 2.0,
                                    borderColor:
                                        AppTheme.of(context).border,
                                    borderWidth: 0.0,
                                    borderRadius: 8.0,
                                    margin: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 12.0, 0.0),
                                    hidesUnderline: true,
                                    isOverButton: false,
                                    isSearchable: false,
                                    isMultiSelect: false,
                                  ),
                                  AppButton(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: 'Apply filters',
                                    options: AppButtonOptions(
                                      height: 50.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          AppTheme.of(context).primary,
                                      textStyle: AppTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  AppTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  AppTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                AppTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                AppTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(
                                          AppTheme.of(context)
                                              .designToken
                                              .radius
                                              .lg),
                                    ),
                                  ),
                                ].divide(const SizedBox(
                                    height: AppConstants.childSpacing)),
                              ),
                            ),
                          ),
                        ),
                      wrapWithModel(
                        model: _model.jobsListModel,
                        updateCallback: () => _provider.update(() {}),
                        child: const JobsListWidget(
                          jobViewType: JobsViewType.BROWSE,
                        ),
                      ),
                    ]
                        .divide(const SizedBox(height: AppConstants.spacing))
                        .addToEnd(const SizedBox(height: 50.0)),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.tpNavbarModel,
                  updateCallback: () => _provider.update(() {}),
                  child: const TpNavbarWidget(
                    selectedIndex: 0,
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
