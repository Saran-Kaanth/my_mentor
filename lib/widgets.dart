import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget loadingWidget({Color loadingWidgetColor = Colors.white}) {
  return Center(
    child: CircularProgressIndicator(color: loadingWidgetColor),
  );
}
