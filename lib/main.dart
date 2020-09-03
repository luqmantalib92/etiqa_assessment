import 'package:flutter/material.dart';

import 'include/colour.dart';

import 'page-main.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colour().primary,
      secondaryHeaderColor: Colour().secondary,
      scaffoldBackgroundColor: Colour().bgPrimary,
      dialogBackgroundColor: Colour().bgPrimary,
    ),
    title: 'Etiqa Assessment',
    home: PageMain(),
  ));
}