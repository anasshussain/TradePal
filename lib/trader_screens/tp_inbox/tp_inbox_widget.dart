import 'package:skeletonizer/skeletonizer.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';
import '/widgets/components/inbox_item/inbox_item_widget.dart';
import '/widgets/components/page_header_sectiom/page_header_sectiom_widget.dart';
import '/widgets/components/tp_navbar/tp_navbar_widget.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/tp_inbox_provider.dart';
import '/viewmodels/tp_inbox_model.dart';
export '/viewmodels/tp_inbox_model.dart';

class TpInboxWidget extends StatefulWidget {
  const TpInboxWidget({super.key});

  static String routeName = 'tp_Inbox';
  static String routePath = '/tpInbox';

  @override
  State<TpInboxWidget> createState() => _TpInboxWidgetState();
}

class _TpInboxWidgetState extends State<TpInboxWidget> {
  late TpInboxModel _model;
  final TpInboxProvider _provider = TpInboxProvider();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // ---------------------------------------------------------------------
  // CACHE: `static` hone ki wajah se ye poori app session ke liye zinda
  // rehta hai, widget dispose hone ke baad bhi.
  //
  // Pehle sirf `TpInboxProvider.isLoading` flag check ho raha tha, jo
  // sirf skeleton chhupata tha lekin uski jagah `SizedBox.shrink()`
  // (khaali jagah) dikhata rehta tha jab tak naya fetch complete na ho —
  // yani har dafa page pe wapas aane par screen "reload" jaisi mehsoos
  // hoti thi.
  //
  // Fix: hum actual response cache karte hain. Dobara page open hone par
  // agar cache maujood hai to woh turant dikha dete hain (bilkul
  // Instagram jaisa), aur background mein naya data fetch ho ke silently
  // update ho jata hai — na koi loader, na koi blank flash.
  // ---------------------------------------------------------------------
  static ApiCallResponse? _cachedConversations;

  late Future<ApiCallResponse> _conversationsFuture;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TpInboxModel());

    _conversationsFuture = _fetchConversations();

    // On page load action.
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
          // Realtime update aane par silently background mein refetch
          // karo — list turant khaali ho ke wapas nahi bharegi, purana
          // data tab tak screen par rehta hai jab tak naya na aa jaye.
          final response =
          await SupabaseTablesGroup.getConversationsCall.call(
            userId: currentUserUid,
          );
          _cachedConversations = response;
          if (!mounted) return;
          setState(() {
            _conversationsFuture = Future.value(response);
          });
        },
      );
    });

    _model.searchTextController ??= TextEditingController();
    _model.searchFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.notify());
  }

  Future<ApiCallResponse> _fetchConversations() async {
    final response = await SupabaseTablesGroup.getConversationsCall.call(
      userId: currentUserUid,
    );
    _cachedConversations = response;
    return response;
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

    return ChangeNotifierProvider<TpInboxProvider>.value(
      value: _provider,
      child: Consumer<TpInboxProvider>(
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
                        updateCallback: () => _provider.notify(),
                        child: const PageHeaderSectiomWidget(
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
                            decoration: const BoxDecoration(),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _model.searchTextController,
                                focusNode: _model.searchFocusNode,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.searchTextController',
                                  const Duration(milliseconds: 300),
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
                                      fontWeight:
                                      AppTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle:
                                      AppTheme.of(context)
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
                                      fontStyle:
                                      AppTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color:
                                    AppTheme.of(context).hint,
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
                                      color:
                                      AppTheme.of(context).primary,
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
                                  fillColor:
                                  AppTheme.of(context).alternate,
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
                                      color: AppTheme.of(context)
                                          .tertiary,
                                      size: 26.0,
                                    ),
                                  )
                                      : null,
                                ),
                                style: AppTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                                cursorColor:
                                AppTheme.of(context).primaryText,
                                enableInteractiveSelection: true,
                                validator: _model.searchTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder<ApiCallResponse>(
                        future: _conversationsFuture,
                        initialData: _cachedConversations,
                        builder: (context, snapshot) {
                          // Sirf tab skeleton dikhao jab bilkul koi purana
                          // data maujood na ho (app session mein pehli
                          // dafa is page ka load).
                          if (!snapshot.hasData) {
                            return Skeletonizer(
                              enabled: true,
                              child: _buildInboxSkeletonList(),
                            );
                          }

                          final listViewGetConversationsResponse =
                          snapshot.data!;

                          return Builder(
                            builder: (context) {
                              final conversation = (_provider.showSearchList
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
                                padding: const EdgeInsets.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  80.0,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: conversation.length,
                                separatorBuilder: (_, __) => const SizedBox(
                                    height: AppConstants.childSpacing),
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
                    ].divide(const SizedBox(height: AppConstants.spacing)),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.tpNavbarModel,
                  updateCallback: () => _provider.notify(),
                  child: const TpNavbarWidget(
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
  Widget _buildInboxSkeletonList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 80.0),
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (_, __) =>
      const SizedBox(height: AppConstants.spacing),
      itemBuilder: (context, index) => Row(
        children: [
          const CircleAvatar(radius: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Placeholder name'),
                SizedBox(height: 6),
                Text('Placeholder last message preview line here'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}