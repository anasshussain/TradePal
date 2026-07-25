import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/widgets/components/choose_path_component/choose_path_component_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/action_blocks/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/choose_path_provider.dart';
import '/viewmodels/choose_path_model.dart';
export '/viewmodels/choose_path_model.dart';

/// create me a page where the user can either choose if theyre a tradesperson
/// or customer via buttons
class ChoosePathWidget extends StatefulWidget {
  const ChoosePathWidget({super.key});

  static String routeName = 'choose_path';
  static String routePath = '/choosePath';

  @override
  State<ChoosePathWidget> createState() => _ChoosePathWidgetState();
}

class _ChoosePathWidgetState extends State<ChoosePathWidget> {
  late ChoosePathModel _model;
  final ChoosePathProvider _provider = ChoosePathProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChoosePathModel());

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
    return ChangeNotifierProvider<ChoosePathProvider>.value(
      value: _provider,
      child: Consumer<ChoosePathProvider>(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Let\'s get you started',
                        textAlign: TextAlign.center,
                        style:
                            AppTheme.of(context).displaySmall.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: AppTheme.of(context)
                                        .displaySmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: AppTheme.of(context)
                                      .displaySmall
                                      .fontStyle,
                                ),
                      ),
                      Text(
                        'Choose the path that best describes\nyou to personalise your experience.',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context)
                            .titleMedium
                            .override(
                              font: GoogleFonts.manrope(
                                fontWeight: FontWeight.normal,
                                fontStyle: AppTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                              color: AppTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: AppTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                              lineHeight: 0.0,
                            ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await action_blocks.updateChoosePathOnboarding(
                            context,
                            selectedRole: UserRole.customer,
                          );
                        },
                        child: wrapWithModel(
                          model: _model.choosePathComponentModel1,
                          updateCallback: () => _provider.update(() {}),
                          child: ChoosePathComponentWidget(
                            icon: Icon(
                              Icons.search_rounded,
                              color: AppTheme.of(context).primary,
                            ),
                            title: 'I\'m a Customer',
                            description:
                                'Find trusted tradespeople for your projects, Request quotes & compare responses',
                            buttonText: 'FIND A PRO',
                            btnColor: AppTheme.of(context).primary,
                            boxColor: AppTheme.of(context).accent1,
                            borderColor:
                                _provider.selectedRole == UserRole.customer
                                    ? AppTheme.of(context).accent1
                                    : AppTheme.of(context)
                                        .secondaryBackground,
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await action_blocks.updateChoosePathOnboarding(
                            context,
                            selectedRole: UserRole.trades_person,
                          );
                        },
                        child: wrapWithModel(
                          model: _model.choosePathComponentModel2,
                          updateCallback: () => _provider.update(() {}),
                          child: ChoosePathComponentWidget(
                            icon: FaIcon(
                              FontAwesomeIcons.tools,
                              color: AppTheme.of(context).secondary,
                            ),
                            title: 'I\'m a Tradesperson',
                            description:
                                'Find new leads and grow your business.\nRespond to ads and chat with customers',
                            buttonText: 'BROWSE JOBS',
                            btnColor: AppTheme.of(context).secondary,
                            boxColor: AppTheme.of(context).accent2,
                            borderColor:
                                _provider.selectedRole == UserRole.trades_person
                                    ? AppTheme.of(context).accent2
                                    : AppTheme.of(context)
                                        .secondaryBackground,
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: AppConstants.spacing))
                        .addToEnd(SizedBox(height: 60.0)),
                  ),
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
                tabletLandscape: false,
                desktop: false,
              ))
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        0.0,
                        valueOrDefault<double>(
                          AppConstants.childPadding,
                          0.0,
                        )),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.0,
                            color: AppTheme.of(context).border,
                            offset: Offset(
                              0.0,
                              -1.0,
                            ),
                            spreadRadius: 0.0,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(valueOrDefault<double>(
                          AppConstants.childPadding,
                          0.0,
                        )),
                        child: AppButton(
                          onPressed: (_provider.selectedRole == null)
                              ? null
                              : () async {},
                          text: 'Continue',
                          options: AppButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: AppTheme.of(context).primary,
                            textStyle: AppTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: AppTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(
                                AppTheme.of(context)
                                    .designToken
                                    .radius
                                    .lg),
                            disabledColor: Color(0x58214FC7),
                            disabledTextColor: Color(0x83FFFFFF),
                          ),
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
