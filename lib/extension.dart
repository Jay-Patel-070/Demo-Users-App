import 'package:flutter/material.dart';

extension StringCasingExtension on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Example:
  /// ```dart
  /// print("jay".capitalizeFirst()); // Output: Jay
  /// ```
  ///
  /// Handles empty string safely.
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}


extension OnTapWidgetExtension on Widget {
  /// Wraps any widget with a [GestureDetector] to provide an onTap callback.
  ///
  /// Example:
  /// ```dart
  /// Text("Click Me")
  ///     .onTap(() {
  ///       print("Widget clicked");
  ///     });
  /// ```
  ///
  /// Useful for making non-button widgets clickable.
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: this,
    );
  }
}


extension PaddingExtension on Widget {
  /// Adds padding around any widget.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello").withPadding(all: 12);
  /// ```
  Widget withPadding({double? all, EdgeInsets? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.all(all ?? 0),
      child: this,
    );
  }
}