import 'package:flutter/material.dart';

/// Converts a logical-pixel layout dimension into the physical-pixel dimension
/// the image decoder should target.
///
/// Network images decode at their full source resolution by default, so a
/// 56x56 avatar backed by a 562x360 source holds ~13x more memory than it
/// needs. Passing the result to `cacheWidth`/`cacheHeight` (`Image`) or
/// `memCacheWidth`/`memCacheHeight` (`CachedNetworkImage`) caps the decode at
/// the size actually painted.
///
/// The device pixel ratio is applied so the decoded image still matches the
/// physical resolution of the display: the rendered result is unchanged, only
/// the wasted headroom is dropped. Returns `null` for unbounded or non-positive
/// dimensions, which leaves that axis at its natural size.
int? decodeCacheSize(BuildContext context, double logicalSize) {
  if (!logicalSize.isFinite || logicalSize <= 0.0) {
    return null;
  }
  return (logicalSize * MediaQuery.devicePixelRatioOf(context)).round();
}
