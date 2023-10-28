import 'package:flutter/material.dart';

import '../../../shared/utilities.dart';

class MenuTile extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final IconData icon;

  const MenuTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(9)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: wXD(3, context)),
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                icon,
                size: wXD(18, context),
                color: getColors(context).primary,
              ),
              SizedBox(width: wXD(7, context)),
              Text(
                title,
                style: textFamily(
                  context,
                  fontSize: 15,
                  color: getColors(context).onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
