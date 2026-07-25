import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import '/auth/supabase_auth/supabase_user_provider.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/repositories/supabase/supabase.dart';
import '/core/firebase/firebase_config.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import 'package:my_trade_pal/utils/custom_code/actions/init_stripe.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '/utils/custom_code/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  final environmentValues = DevEnvironmentValues();
  await environmentValues.initialize();

  await initFirebase();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await NotificationService.instance.init();

  // These three are mutually independent: Supabase reads its own hardcoded
  // credentials, and the other two only wrap SharedPreferences.getInstance().
  // Overlapping them removes the serialized round-trips from cold start; they
  // still run after the Firebase chain, so ordering against it is unchanged.
  final appState = AppState(); // Initialize AppState
  await Future.wait([
    SupaFlow.initialize(),
    AppTheme.initialize(),
    appState.initializePersistedState(),
  ]);
  initStripe();
  runApp(MultiProvider(
    providers: [
      // App-wide / shared state. Screen-scoped providers (Job Details,
      // Dashboard, Profile, Payments, etc.) live in lib/providers and are
      // provided per-route inside their own screens.
      ChangeNotifierProvider<AppState>(create: (context) => appState),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = AppTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.path;
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = myTradePalSupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        AppTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Trade Pal',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: MaterialStateProperty.all(false),
          thickness: MaterialStateProperty.all(2.0),
          radius: const Radius.circular(12.0),
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.dragged)) {
              return const Color(4278236083);
            }
            if (states.contains(MaterialState.hovered)) {
              return const Color(4278236083);
            }
            return const Color(4278236083);
          }),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: MaterialStateProperty.all(false),
          thickness: MaterialStateProperty.all(2.0),
          radius: const Radius.circular(12.0),
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.dragged)) {
              return const Color(4283292892);
            }
            if (states.contains(MaterialState.hovered)) {
              return const Color(4283292892);
            }
            return const Color(4283292892);
          }),
        ),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}