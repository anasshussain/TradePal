import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/appbar_component/appbar_component_widget.dart';
import '/components/inbox_item/inbox_item_widget.dart';
import '/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/components/tp_navbar/tp_navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tp_inbox_model.dart';
export 'tp_inbox_model.dart';

/// could you design me an all chats inbox page with 2 list views.
///
/// 1 for trades and 1 for customers
class TpInboxWidget extends StatefulWidget {
  const TpInboxWidget({super.key});

  static String routeName = 'tp_Inbox';
  static String routePath = '/tpInbox';

  @override
  State<TpInboxWidget> createState() => _TpInboxWidgetState();
}

class _TpInboxWidgetState extends State<TpInboxWidget> {
  late TpInboxModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TpInboxModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.unsubscribe(
        'conversation_participants',
      );
      await Future.delayed(
        Duration(
          milliseconds: 500,
        ),
      );
      await actions.subscribe(
        'conversation_participants',
        'user_id',
        FFAppState().userProfileCache.userKey,
        'update',
        () async {
          safeSetState(() => _model.apiRequestCompleter = null);
          await _model.waitForApiRequestCompleted();
        },
      );
    });

    _model.searchTextController ??= TextEditingController();
    _model.searchFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      await actions.unsubscribe(
        'conversation_participants',
      );
    }();

    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.appbarComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: AppbarComponentWidget(
              title: 'Inbox',
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
                  FFAppConstants.parentPagePadding,
                  0.0,
                )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      wrapWithModel(
                        model: _model.pageHeaderSectiomModel,
                        updateCallback: () => safeSetState(() {}),
                        child: PageHeaderSectiomWidget(
                          tag: '',
                          title: 'Inbox',
                          subtitle:
                              'Manage your professional communications and\nproject updates.',
                          itemText: '',
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            child: Container(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _model.searchTextController,
                                focusNode: _model.searchFocusNode,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.searchTextController',
                                  Duration(milliseconds: 300),
                                  () async {
                                    _model.searchJobApiRespone =
                                        await SupbaseRpcGroup
                                            .searchConversationsCall
                                            .call(
                                      userId: currentUserUid,
                                      searchText:
                                          _model.searchTextController.text,
                                    );

                                    if ((_model
                                            .searchJobApiRespone?.succeeded ??
                                        true)) {
                                      if (_model.searchTextController.text !=
                                              null &&
                                          _model.searchTextController.text !=
                                              '') {
                                        _model.showSearchList = true;
                                        safeSetState(() {});
                                      } else {
                                        _model.showSearchList = false;
                                        safeSetState(() {});
                                      }
                                    }

                                    safeSetState(() {});
                                  },
                                ),
                                autofocus: false,
                                enabled: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: false,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  hintText: 'Search conversations',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).hint,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  suffixIcon: _model
                                          .searchTextController!.text.isNotEmpty
                                      ? InkWell(
                                          onTap: () async {
                                            _model.searchTextController
                                                ?.clear();
                                            _model.searchJobApiRespone =
                                                await SupbaseRpcGroup
                                                    .searchConversationsCall
                                                    .call(
                                              userId: currentUserUid,
                                              searchText: _model
                                                  .searchTextController.text,
                                            );

                                            if ((_model.searchJobApiRespone
                                                    ?.succeeded ??
                                                true)) {
                                              if (_model.searchTextController
                                                          .text !=
                                                      null &&
                                                  _model.searchTextController
                                                          .text !=
                                                      '') {
                                                _model.showSearchList = true;
                                                safeSetState(() {});
                                              } else {
                                                _model.showSearchList = false;
                                                safeSetState(() {});
                                              }
                                            }

                                            safeSetState(() {});
                                            safeSetState(() {});
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
                                            size: 26.0,
                                          ),
                                        )
                                      : null,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                enableInteractiveSelection: true,
                                validator: _model.searchTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder<ApiCallResponse>(
                        future: (_model.apiRequestCompleter ??= Completer<
                                ApiCallResponse>()
                              ..complete(
                                  SupabaseTablesGroup.getConversationsCall.call(
                                userId: currentUserUid,
                              )))
                            .future,
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 200.0, 0.0, 0.0),
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitFadingCube(
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            );
                          }
                          final listViewGetConversationsResponse =
                              snapshot.data!;

                          return Builder(
                            builder: (context) {
                              final conversation = (_model.showSearchList
                                          ? ((_model.searchJobApiRespone?.jsonBody ?? '')
                                                      .toList()
                                                      .map<ConversationStruct?>(
                                                          ConversationStruct
                                                              .maybeFromMap)
                                                      .toList()
                                                  as Iterable<
                                                      ConversationStruct?>)
                                              .withoutNulls
                                              ?.sortedList(
                                                  keyOf: (e) => e.conversations
                                                      .lastMessageAt,
                                                  desc: true)
                                          : (listViewGetConversationsResponse
                                                  .jsonBody
                                                  .toList()
                                                  .map<ConversationStruct?>(ConversationStruct.maybeFromMap)
                                                  .toList() as Iterable<ConversationStruct?>)
                                              .withoutNulls
                                              ?.sortedList(keyOf: (e) => e.conversations.lastMessageAt, desc: true))
                                      ?.toList() ??
                                  [];

                              return ListView.separated(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  80.0,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: conversation.length,
                                separatorBuilder: (_, __) => SizedBox(
                                    height: FFAppConstants.childSpacing),
                                itemBuilder: (context, conversationIndex) {
                                  final conversationItem =
                                      conversation[conversationIndex];
                                  return InboxItemWidget(
                                    key: Key(
                                        'Keydpz_${conversationIndex}_of_${conversation.length}'),
                                    members: conversationItem
                                        .conversations.conversationParticipants
                                        .where((e) =>
                                            currentUserUid != e.members.id)
                                        .toList()
                                        .firstOrNull!
                                        .members,
                                    conversation: conversationItem,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ].divide(SizedBox(height: FFAppConstants.spacing)),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.tpNavbarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TpNavbarWidget(
                    selectedIndex: 2,
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
