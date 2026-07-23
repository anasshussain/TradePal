import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/core/location/lat_lng.dart';
import '/core/location/place.dart';
import '/core/utils/uploaded_file.dart';
import '/repositories/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/structs/index.dart';
import '/utils/enums/enums.dart';
import '/repositories/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

bool hasMinLength(String password) {
  return password.length >= 8;
}

bool hasUppercase(String password) {
  return RegExp(r'[A-Z]').hasMatch(password);
}

bool hasLowercase(String password) {
  return RegExp(r'[a-z]').hasMatch(password);
}

bool hasNumberOrSymbol(String password) {
  return RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]').hasMatch(password);
}

double getLatLng(
  int index,
  LatLng location,
) {
  if (index == 0) {
    return location.latitude;
  } else {
    return location.longitude;
  }
}

DateTime convertDateStringtoDateTIme(String dateString) {
  return DateTime.parse(dateString);
}

String timeAgo(String date) {
  final now = DateTime.now();
  final dateTime = DateTime.parse(date);
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return "${difference.inSeconds} sec ago";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} min ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hr ago";
  } else if (difference.inDays < 7) {
    return "${difference.inDays} day ago";
  } else if (difference.inDays < 30) {
    return "${(difference.inDays / 7).floor()} week ago";
  } else if (difference.inDays < 365) {
    return "${(difference.inDays / 30).floor()} month ago";
  } else {
    return "${(difference.inDays / 365).floor()} year ago";
  }
}

String formatDateTime(String timestamp) {
  final dt = DateTime.parse(timestamp).toLocal();
  final now = DateTime.now();

  if (dt.day == now.day && dt.month == now.month && dt.year == now.year) {
    return DateFormat('hh:mm a').format(dt);
  } else if (dt.day == now.day - 1 &&
      dt.month == now.month &&
      dt.year == now.year) {
    return 'Yesterday, ${DateFormat('hh:mm a').format(dt)}';
  } else {
    return DateFormat('dd MMM, hh:mm a').format(dt);
  }
}

int sumList(List<int> numbers) {
  return numbers.fold(0, (sum, item) => sum + item);
}

bool canSendMessage(
  String message,
  bool isAssigned,
) {
  // ✅ Allow everything after assignment
  if (isAssigned) return true;

  final text = message.toLowerCase();

  // 🚫 Email detection
  final emailRegex = RegExp(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}');

  // 🚫 Phone number detection
  final phoneRegex = RegExp(r'\d{8,}');

  // 🚫 Blocked keywords / links
  const blockedPatterns = [
    'whatsapp',
    'wa.me',
    'telegram',
    'instagram',
    'facebook',
    'snapchat',
    'http',
    'www.',
    '.com',
    '.net',
  ];

  // 🚫 Check email
  if (emailRegex.hasMatch(text)) {
    return false;
  }

  // 🚫 Check phone
  if (phoneRegex.hasMatch(text)) {
    return false;
  }

  // 🚫 Check keywords/links
  for (final pattern in blockedPatterns) {
    if (text.contains(pattern)) {
      return false;
    }
  }

  // ✅ Safe message
  return true;
}

String countryCodeToEmoji(String countryCode) {
  return countryCode.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(
          match.group(0)!.codeUnitAt(0) + 127397,
        ),
      );
}
