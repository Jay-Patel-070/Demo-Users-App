import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Example:
  /// ```dart
  /// print("jay".capitalize()); // Output: Jay
  /// ```
  ///
  /// Handles empty string safely.
  String capitalize() {
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
  ///     .onTapEvent(() {
  ///       print("Widget clicked");
  ///     });
  /// ```
  ///
  /// Useful for making non-button widgets clickable.
  Widget onTapEvent(GestureTapCallback onTap) {
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


extension isNullandEmptyExtension on String? {
  /// Checks if the string is null or empty.
  ///
  /// Example:
  /// ```dart
  /// String? name;
  /// print(name.isNullOrEmpty()); // Output: true
  /// ```
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
}


extension isNotNullandEmptyExtension on String? {
  /// Checks if the string is not null and not empty.
  ///
  /// Example:
  /// ```dart
  /// String? name = "John";
  /// print(name.isNotNullOrEmpty()); // Output: true
  /// ```
  bool isNotNullOrEmpty() {
    return this != null && this!.isNotEmpty;
  }
}

extension DateTimeFormattingExtension on DateTime {
  /// Returns formatted date like "05 Dec 2025"
  String toDateString() {
    return DateFormat('dd MMMM yyyy').format(this);
  }

  /// Returns formatted time like "10:45 AM"
  String toTimeString() {
    return DateFormat('hh:mm a').format(this);
  }

  /// Returns both date + time → "05 Dec 2025  10:45 AM"
  String toDateTimeString() {
    return "${toDateString()}  ${toTimeString()}";
  }

}