import 'package:flutter/material.dart';
import 'dart:developer' as developer;

/// to remove focus when this function is called
void unfocus([_]) => FocusManager.instance.primaryFocus?.unfocus();

/// get device width
double get width {
  final x = WidgetsBinding.instance.window;
  final r = MediaQueryData.fromWindow(x);
  return r.size.width;
}

/// get device height
double get height {
  final x = WidgetsBinding.instance.window;
  final r = MediaQueryData.fromWindow(x);
  return r.size.height;
}

/// print in yellow
void printWarning(data) {
  developer.log('\x1B[33m$data\x1B[0m');
}

/// print in green
void printData(data) {
  developer.log('\x1B[32m$data\x1B[0m');
}

/// print in red
void printError(data) {
  developer.log('\x1B[31m$data\x1B[0m');
}

/// print in purple
void printPurple(data) {
  developer.log('\x1b[1;35m$data\x1b[0;35m');
}

/// print in toska
void printToska(data) {
  developer.log('\x1b[1;36m$data\x1b[0;36m');
}

/// print in white
void printWhite(data) {
  developer.log('\x1b[1;37m$data\x1b[0;37m');
}

/// run the function when the ui is done rendering
void onLoad(void Function() fun) {
  WidgetsBinding.instance.addPostFrameCallback((_) => fun());
}

/// get keyboard height
double keyboardHeight(BuildContext context) =>
    MediaQuery.of(context).viewInsets.bottom;

/// get Status Bar height
double statBarHeight(BuildContext context) =>
    MediaQuery.of(context).viewPadding.top;
