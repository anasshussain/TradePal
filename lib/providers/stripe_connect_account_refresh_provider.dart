import 'package:flutter/foundation.dart';

/// State management for the stripe_connect_account_refresh screen (migrated from setState).
///
/// This screen carries no persistent local state; the provider exists to drive
/// widget rebuilds through Provider instead of setState.
class StripeConnectAccountRefreshProvider extends ChangeNotifier {
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Notify observers without mutating state (replaces empty setState).
  void notify() {
    if (!_disposed) notifyListeners();
  }

  /// Run [fn] then notify observers (replaces setState(() => ...)).
  void update(VoidCallback fn) {
    fn();
    if (!_disposed) notifyListeners();
  }
}
