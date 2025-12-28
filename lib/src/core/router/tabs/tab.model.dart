import 'package:flutter/material.dart';

class TabModel {
  final String route;
  final String labelKey;
  final IconData icon;

  const TabModel({
    required this.route,
    required this.labelKey,
    required this.icon,
  });
}
