import 'package:flutter/material.dart';

// Central primary color constants; change these to switch the app's
// primary color everywhere.
const Color kPrimaryGreen = Color(0xFF00A63E);
const Color kPrimaryGreenAlt = Color(0xFF00C950);

const List<Color> kPrimaryGradient = [
  kPrimaryGreen,
  kPrimaryGreenAlt,
];

const LinearGradient kPrimaryGradientLinear = LinearGradient(
  colors: kPrimaryGradient,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// New primary color (teal) as requested: #008080
const Color kPrimaryTeal = Color(0xFF008080);
