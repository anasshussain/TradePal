import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '/core/theme/app_theme.dart';
import '/widgets/components/appbar_component/appbar_component_widget.dart';

enum StripeOnboardingResult { completed, refreshNeeded, cancelled }

/// Hosts Stripe's onboarding/Express-dashboard link in an in-app WebView and
/// watches its navigation so the screen can close itself automatically once
/// Stripe redirects to the return/refresh URL — the hosted flow has no other
/// way to signal back to the app that it's finished.
class StripeOnboardingWebviewWidget extends StatefulWidget {
  const StripeOnboardingWebviewWidget({
    super.key,
    required this.url,
    required this.returnUrl,
    required this.refreshUrl,
    this.title = 'Stripe',
  });

  final String url;
  final String returnUrl;
  final String refreshUrl;
  final String title;

  @override
  State<StripeOnboardingWebviewWidget> createState() =>
      _StripeOnboardingWebviewWidgetState();
}

class _StripeOnboardingWebviewWidgetState
    extends State<StripeOnboardingWebviewWidget> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: _checkForCompletion,
          onNavigationRequest: (request) {
            _checkForCompletion(request.url);
            return NavigationDecision.navigate;
          },
          onPageFinished: (_) {
            if (mounted) setState(() => isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _checkForCompletion(String url) {
    if (_finished) return;

    if (url.startsWith(widget.returnUrl)) {
      _finished = true;
      Navigator.of(context).pop(StripeOnboardingResult.completed);
    } else if (url.startsWith(widget.refreshUrl)) {
      _finished = true;
      Navigator.of(context).pop(StripeOnboardingResult.refreshNeeded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      appBar: AppBar(
        backgroundColor: theme.primaryBackground,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () =>
              Navigator.of(context).pop(StripeOnboardingResult.cancelled),
        ),
        title: AppbarComponentWidget(
          title: widget.title,
          showAction: false,
          actionIcon: null,
          action: () async {},
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
