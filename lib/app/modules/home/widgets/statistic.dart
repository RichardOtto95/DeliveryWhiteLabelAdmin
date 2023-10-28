import 'package:delivery_admin_white_label/app/shared/responsive.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../shared/utilities.dart';

class Statistic extends StatelessWidget {
  final String title;
  final String data;
  final String? totalData;
  final void Function()? onTap;
  final IconData icon;

  const Statistic({
    Key? key,
    required this.title,
    required this.data,
    required this.icon,
    this.totalData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: wXD(69, context),
        width: wXD(375, context,
            ws: totalData != null ? 445 : 327, mediaWeb: totalData != null),
        margin: EdgeInsets.symmetric(
            horizontal: wXD(14, context, ws: 5),
            vertical: wXD(6, context, ws: 5)),
        padding:
            EdgeInsets.symmetric(horizontal: wXD(21, context, mediaWeb: true)),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: getColors(context).surface,
          borderRadius: BorderRadius.all(Radius.circular(wXD(9, context))),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0, 2),
              color: getColors(context).shadow,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (totalData != null)
              Row(
                children: [
                  Container(
                    width: wXD(74, context, mediaWeb: true),
                    height: wXD(32, context),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(wXD(11, context))),
                      gradient: SweepGradient(
                        center: FractionalOffset.center,
                        startAngle: 0.0,
                        endAngle: math.pi * 2,
                        colors: <Color>[
                          getColors(context).primary.withOpacity(1),
                          getColors(context).primary.withOpacity(0),
                        ],
                        stops: <double>[0.0, math.pi * 2],
                        transform: GradientRotation(3 * math.pi / 2),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: wXD(72, context),
                      height: wXD(30, context),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(wXD(11, context))),
                        color: getColors(context).surface,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        totalData!,
                        style: textFamily(
                          context,
                          fontSize: 14,
                          color: getColors(context).onBackground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: wXD(7, context)),
                    child: Text(
                      data,
                      style: textFamily(
                        context,
                        fontSize: 18,
                        color: getColors(context).onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: wXD(150, context, ws: 220, mediaWeb: true),
                    child: Text(
                      title,
                      maxLines: 2,
                      // overflow: TextOverflow.,
                      style: textFamily(
                        context,
                        fontSize: 16,
                        color: getColors(context).onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            if (totalData == null)
              SizedBox(
                width: wXD(200, context),
                child: Text(
                  title,
                  style: textFamily(
                    context,
                    fontSize: 16,
                    color: getColors(context).onBackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            if (totalData == null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: wXD(7, context)),
                child: Text(
                  data,
                  style: textFamily(
                    context,
                    fontSize: 18,
                    color: getColors(context).onBackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            Visibility(
              visible: totalData != null && !Responsive.isDesktop(context),
              child: Icon(
                icon,
                size: totalData != null ? wXD(20, context) : wXD(30, context),
                color: totalData != null
                    ? getColors(context).onSurface.withOpacity(.6)
                    : getColors(context).onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
