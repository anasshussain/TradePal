import 'package:skeletonizer/skeletonizer.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/customer_navbar/customer_navbar_widget.dart';
import '/widgets/components/empty_list_component/empty_list_component_widget.dart';
import '/widgets/components/inbox_item/inbox_item_widget.dart';
import '/widgets/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/customer_inbox_provider.dart';
import '/viewmodels/customer_inbox_model.dart';
export '/viewmodels/customer_inbox_model.dart';

class CustomerInboxWidget extends StatefulWidget {
  const CustomerInboxWidget({super.key});

  static String routeName = 'customer_Inbox';
  static String routePath = '/chatsInbox';

  @override
  State<CustomerInboxWidget> createState() => _CustomerInboxWidgetState();
}

class _CustomerInboxWidgetState extends State<CustomerInboxWidget> {
  late CustomerInboxModel _model;
  final CustomerInboxProvider _provider = CustomerInboxProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerInboxModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.unsubscribe(
        'conversation_participants',
      );
      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );
      await actions.subscribe(
        'conversation_participants',
        'user_id',
        AppState().userProfileCache.userKey,
        'update',
        () async {
          _provider.update(() => _model.apiRequestCompleter = null);
          await _model.waitForApiRequestCompleted();
        },
      );
    });

    _model.searchTextController ??= TextEditingController();
    _model.searchFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.notify());
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
    _provider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return ChangeNotifierProvider<CustomerInboxProvider>.value(
      value: _provider,
      child: Consumer<CustomerInboxProvider>(
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
            updateCallback: () => _provider.notify(),
            child: AppbarComponentWidget(
              title: 'Inbox',
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
              Skeletonizer(
                enabled: _provider.isLoading,
                child: Padding(
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
                          updateCallback: () => _provider.notify(),
                          child: const PageHeaderSectiomWidget(
                            tag: '',
                            title: 'Inbox',
                            subtitle:
                                'Manage your professional communications and project updates.',
                            itemText: '',
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.searchTextController,
                            focusNode: _model.searchFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.searchTextController',
                              const Duration(milliseconds: 300),
                              () async {
                                _model.searchJobApiRespone = await SupbaseRpcGroup
                                    .searchConversationsCall
                                    .call(
                                  userId: currentUserUid,
                                  searchText: _model.searchTextController.text,
                                );

                                if ((_model.searchJobApiRespone?.succeeded ??
                                    true)) {
                                  if (_model.searchTextController.text != null &&
                                      _model.searchTextController.text != '') {
                                    _provider.showSearchList = true;
                                    _provider.notify();
                                  } else {
                                    _provider.showSearchList = false;
                                    _provider.notify();
                                  }
                                }

                                _provider.notify();
                              },
                            ),
                            autofocus: false,
                            enabled: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: false,
                              labelStyle: AppTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              hintText: 'Search conversations',
                              hintStyle: AppTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: AppTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context).hint,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: AppTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).primary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: AppTheme.of(context).alternate,
                              suffixIcon: _model
                                      .searchTextController!.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () async {
                                        _model.searchTextController?.clear();
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
                                            _provider.showSearchList = true;
                                            _provider.notify();
                                          } else {
                                            _provider.showSearchList = false;
                                            _provider.notify();
                                          }
                                        }

                                        _provider.notify();
                                        _provider.notify();
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color:
                                            AppTheme.of(context).tertiary,
                                        size: 26.0,
                                      ),
                                    )
                                  : null,
                            ),
                            style:
                                AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: AppTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                            cursorColor: AppTheme.of(context).primaryText,
                            enableInteractiveSelection: true,
                            validator: _model.searchTextControllerValidator
                                .asValidator(context),
                          ),
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 200.0, 0.0, 0.0),
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: SpinKitFadingCube(
                                      color: AppTheme.of(context).primary,
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
                                final conversations = (_provider.showSearchList
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
                                if (conversations.isEmpty) {
                                  return const EmptyListComponentWidget(
                                    icon: Icon(
                                      Icons.chat_outlined,
                                    ),
                                    title: 'No Messaged',
                                    description: 'You have no messages yet',
                                  );
                                }

                                return ListView.separated(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    80.0,
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: conversations.length,
                                  separatorBuilder: (_, __) => const SizedBox(
                                      height: AppConstants.childSpacing),
                                  itemBuilder: (context, conversationsIndex) {
                                    final conversationsItem =
                                        conversations[conversationsIndex];
                                    return InboxItemWidget(
                                      key: Key(
                                          'Key0r1_${conversationsIndex}_of_${conversations.length}'),
                                      members: conversationsItem
                                          .conversations.conversationParticipants
                                          .where((e) =>
                                              currentUserUid != e.members.id)
                                          .toList()
                                          .firstOrNull!
                                          .members,
                                      conversation: conversationsItem,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ].divide(const SizedBox(height: AppConstants.spacing)),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.customerNavbarModel,
                  updateCallback: () => _provider.notify(),
                  child: const CustomerNavbarWidget(
                    selectedIndex: 1,
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