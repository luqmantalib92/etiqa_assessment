import 'package:flutter/material.dart';

import 'colour.dart';

class Deco {
  Theme calendarPrimary(Widget child) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: Colour().primary,
        accentColor: Colour().primary,
        colorScheme: ColorScheme.light(primary: Colour().primary),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      child: child,
    );
  }

  InputDecoration textInput(
    String _hintText,
    TextStyle _hintTextStyle,
    Color _fillColor,
    double _radius,
  ) {
    return InputDecoration(
      hintText: _hintText,
      hintStyle: _hintTextStyle,
      errorStyle: TextStyle(
        fontSize: 10,
        color: Colour().tertiary,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 15.0,
      ),
      filled: true,
      fillColor: _fillColor,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().textPrimary),
        borderRadius: BorderRadius.circular(_radius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().textPrimary),
        borderRadius: BorderRadius.circular(_radius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().textPrimary),
        borderRadius: BorderRadius.circular(_radius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().tertiary),
        borderRadius: BorderRadius.circular(_radius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().tertiary),
        borderRadius: BorderRadius.circular(_radius),
      ),
    );
  }

  InputDecoration dateInput(
    String _hintText,
    TextStyle _hintTextStyle,
    Color _fillColor,
    double _radius,
  ) {
    return InputDecoration(
      hintText: _hintText,
      hintStyle: _hintTextStyle,
      errorStyle: TextStyle(
        fontSize: 10,
        color: Colour().tertiary,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 15.0,
      ),
      suffixIcon: Icon(Icons.arrow_drop_down),
      filled: true,
      fillColor: _fillColor,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().textPrimary),
        borderRadius: BorderRadius.circular(_radius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().textPrimary),
        borderRadius: BorderRadius.circular(_radius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().textPrimary),
        borderRadius: BorderRadius.circular(_radius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().tertiary),
        borderRadius: BorderRadius.circular(_radius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colour().tertiary),
        borderRadius: BorderRadius.circular(_radius),
      ),
    );
  }
}
