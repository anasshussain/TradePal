import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/theme/app_theme.dart';
import '/core/lat_lng.dart';
import '/core/place.dart';
import '/core/util.dart';
import '/nav/serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export '/nav/serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? SplashScreenWidget()
          : SplashScreenWidget(),
      routes: [
        AppRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? SplashScreenWidget()
              : SplashScreenWidget(),
        ),
        AppRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) => HomeWidget(),
        ),
        AppRoute(
          name: PaymentSuccessWidget.routeName,
          path: PaymentSuccessWidget.routePath,
          builder: (context, params) => PaymentSuccessWidget(),
        ),
        AppRoute(
          name: ProcessingStateWidget.routeName,
          path: ProcessingStateWidget.routePath,
          builder: (context, params) => ProcessingStateWidget(),
        ),
        AppRoute(
          name: CompleteBookingDialogWidget.routeName,
          path: CompleteBookingDialogWidget.routePath,
          builder: (context, params) => CompleteBookingDialogWidget(),
        ),
        AppRoute(
          name: CompleteBookingPageWidget.routeName,
          path: CompleteBookingPageWidget.routePath,
          builder: (context, params) => CompleteBookingPageWidget(),
        ),
        AppRoute(
          name: BottomSheetAttachmentWidget.routeName,
          path: BottomSheetAttachmentWidget.routePath,
          builder: (context, params) => BottomSheetAttachmentWidget(),
        ),
        AppRoute(
          name: StripeConnectAccountSuccessWidget.routeName,
          path: StripeConnectAccountSuccessWidget.routePath,
          builder: (context, params) => StripeConnectAccountSuccessWidget(),
        ),
        AppRoute(
          name: NewScreen4Widget.routeName,
          path: NewScreen4Widget.routePath,
          builder: (context, params) => NewScreen4Widget(),
        ),
        AppRoute(
          name: StripeConnectAccountRefreshWidget.routeName,
          path: StripeConnectAccountRefreshWidget.routePath,
          builder: (context, params) => StripeConnectAccountRefreshWidget(),
        ),
        AppRoute(
          name: PasswordChangedSuccessPageWidget.routeName,
          path: PasswordChangedSuccessPageWidget.routePath,
          builder: (context, params) => PasswordChangedSuccessPageWidget(),
        ),
        AppRoute(
          name: ChoosePathWidget.routeName,
          path: ChoosePathWidget.routePath,
          builder: (context, params) => ChoosePathWidget(),
        ),
        AppRoute(
          name: BrowseTradePersonWidget.routeName,
          path: BrowseTradePersonWidget.routePath,
          builder: (context, params) => BrowseTradePersonWidget(),
        ),
        AppRoute(
          name: ForgetPasswordWidget.routeName,
          path: ForgetPasswordWidget.routePath,
          builder: (context, params) => ForgetPasswordWidget(
            headingTitle: params.getParam(
              'headingTitle',
              ParamType.String,
            ),
          ),
        ),
        AppRoute(
          name: BrowseJobsWidget.routeName,
          path: BrowseJobsWidget.routePath,
          builder: (context, params) => BrowseJobsWidget(),
        ),
        AppRoute(
          name: CustomerDashboardWidget.routeName,
          path: CustomerDashboardWidget.routePath,
          builder: (context, params) => CustomerDashboardWidget(),
        ),
        AppRoute(
          name: SignupWidget.routeName,
          path: SignupWidget.routePath,
          builder: (context, params) => SignupWidget(),
        ),
        AppRoute(
          name: VerifyEmailWidget.routeName,
          path: VerifyEmailWidget.routePath,
          builder: (context, params) => VerifyEmailWidget(),
        ),
        AppRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => LoginWidget(),
        ),
        AppRoute(
          name: ResetPasswordWidget.routeName,
          path: ResetPasswordWidget.routePath,
          builder: (context, params) => ResetPasswordWidget(),
        ),
        AppRoute(
          name: TraderProfileWidget.routeName,
          path: TraderProfileWidget.routePath,
          builder: (context, params) => TraderProfileWidget(),
        ),
        AppRoute(
          name: CheckoutPageWidget.routeName,
          path: CheckoutPageWidget.routePath,
          builder: (context, params) => CheckoutPageWidget(),
        ),
        AppRoute(
          name: CustomerProfileWidget.routeName,
          path: CustomerProfileWidget.routePath,
          builder: (context, params) => CustomerProfileWidget(),
        ),
        AppRoute(
          name: BankCardsWidget.routeName,
          path: BankCardsWidget.routePath,
          builder: (context, params) => BankCardsWidget(),
        ),
        AppRoute(
          name: OnboardingWidget.routeName,
          path: OnboardingWidget.routePath,
          builder: (context, params) => OnboardingWidget(),
        ),
        AppRoute(
          name: ReviewWidget.routeName,
          path: ReviewWidget.routePath,
          builder: (context, params) => ReviewWidget(
            name: params.getParam(
              'name',
              ParamType.String,
            ),
            profileUrl: params.getParam(
              'profileUrl',
              ParamType.String,
            ),
            jobid: params.getParam(
              'jobid',
              ParamType.String,
            ),
            tradepersonId: params.getParam(
              'tradepersonId',
              ParamType.String,
            ),
          ),
        ),
        AppRoute(
          name: AccountInactiveWidget.routeName,
          path: AccountInactiveWidget.routePath,
          builder: (context, params) => AccountInactiveWidget(),
        ),
        AppRoute(
          name: EditTraderProfileWidget.routeName,
          path: EditTraderProfileWidget.routePath,
          builder: (context, params) => EditTraderProfileWidget(),
        ),
        AppRoute(
          name: EditCustomerProfieWidget.routeName,
          path: EditCustomerProfieWidget.routePath,
          builder: (context, params) => EditCustomerProfieWidget(),
        ),
        AppRoute(
          name: TpMyJobsWidget.routeName,
          path: TpMyJobsWidget.routePath,
          builder: (context, params) => TpMyJobsWidget(),
        ),
        AppRoute(
          name: NotificationPageWidget.routeName,
          path: NotificationPageWidget.routePath,
          builder: (context, params) => NotificationPageWidget(),
        ),
        AppRoute(
          name: CustomerAllJobsWidget.routeName,
          path: CustomerAllJobsWidget.routePath,
          builder: (context, params) => CustomerAllJobsWidget(),
        ),
        AppRoute(
          name: TpInboxWidget.routeName,
          path: TpInboxWidget.routePath,
          builder: (context, params) => TpInboxWidget(),
        ),
        AppRoute(
          name: CustomerInboxWidget.routeName,
          path: CustomerInboxWidget.routePath,
          builder: (context, params) => CustomerInboxWidget(),
        ),
        AppRoute(
          name: ChatPageWidget.routeName,
          path: ChatPageWidget.routePath,
          builder: (context, params) => ChatPageWidget(
            conversationId: params.getParam(
              'conversationId',
              ParamType.String,
            ),
            username: params.getParam(
              'username',
              ParamType.String,
            ),
            avatarUrl: params.getParam(
              'avatarUrl',
              ParamType.String,
            ),
            jobid: params.getParam(
              'jobid',
              ParamType.String,
            ),
            member: params.getParam(
              'member',
              ParamType.DataStruct,
              isList: false,
              structBuilder: MembersStruct.fromSerializableMap,
            ),
          ),
        ),
        AppRoute(
          name: AddJobWidget.routeName,
          path: AddJobWidget.routePath,
          builder: (context, params) => AddJobWidget(
            jobData: params.getParam(
              'jobData',
              ParamType.DataStruct,
              isList: false,
              structBuilder: JobDataStruct.fromSerializableMap,
            ),
            location: params.getParam(
              'location',
              ParamType.DataStruct,
              isList: false,
              structBuilder: LocationStruct.fromSerializableMap,
            ),
          ),
        ),
        AppRoute(
          name: SplashScreenWidget.routeName,
          path: SplashScreenWidget.routePath,
          builder: (context, params) => SplashScreenWidget(),
        ),
        AppRoute(
          name: JobDetailsWidget.routeName,
          path: JobDetailsWidget.routePath,
          builder: (context, params) => JobDetailsWidget(
            jobId: params.getParam(
              'jobId',
              ParamType.String,
            ),
            jobView: params.getParam<JobDetailsView>(
              'jobView',
              ParamType.Enum,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class AppRouteParameters {
  AppRouteParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class AppRoute {
  const AppRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, AppRouteParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/splashScreen';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final routeParams = AppRouteParameters(state, asyncParams);
          final page = routeParams.hasFutures
              ? FutureBuilder(
                  future: routeParams.completeFutures(),
                  builder: (context, _) => builder(context, routeParams),
                )
              : builder(context, routeParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: SpinKitFadingCube(
                      color: AppTheme.of(context).primary,
                      size: 50.0,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
