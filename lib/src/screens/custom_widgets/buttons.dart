import 'package:flutter/material.dart';

Widget getElevatedButton({
  String title = '',
  Widget? icon,
  Function()? onPressed,
  double? width,
  double? height,
  Widget? child,
  OutlinedBorder? shape,
  EdgeInsetsGeometry? padding,
  Color? backgroundColor,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape,
          padding: padding,
          backgroundColor: backgroundColor,
        ),
        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon,
                if (icon != null && title.isNotEmpty) const SizedBox(width: 8),
                if (title.isNotEmpty) Text(title),
              ],
            )),
  );
}

Widget getTextButton({
  String title = '',
  Widget? child,
  Function()? onPressed,
  double? width,
}) {
  return SizedBox(
    width: width,
    child: TextButton(
      onPressed: onPressed,
      child: child ?? Text(title),
    ),
  );
}
