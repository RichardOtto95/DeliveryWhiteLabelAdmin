import 'package:flutter/material.dart';

import '../utilities.dart';

class FloatingCircleButton extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final Color? iconColor;
  final Color? color;
  final double? size;
  final double iconSize;
  final Widget? child;
  const FloatingCircleButton({
    Key? key,
    required this.onTap,
    this.color,
    this.size,
    this.child,
    this.iconColor,
    this.icon = Icons.search_rounded,
    this.iconSize = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(9000)),
      color: getColors(context).surface,
      elevation: 8,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(9000)),
        onTap: onTap,
        child: Container(
          height: size ?? wXD(68, context),
          width: size ?? wXD(68, context),
          alignment: Alignment.center,
          child: child ??
              Icon(
                icon,
                size: wXD(iconSize, context),
                color: iconColor,
              ),
        ),
      ),
    );
  }
}
