import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_admin_white_label/app/modules/home/home_store.dart';
import 'package:delivery_admin_white_label/app/modules/main/main_store.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/load_circular_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/models/time_model.dart';

class HomeAppBar extends StatefulWidget {
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final HomeStore store = Modular.get();

  final MainStore mainStore = Modular.get();

  OverlayEntry? filterOverlay;

  OverlayEntry getFilterOverlay() {
    Widget getCheckPeriod(String title, int index) {
      return Builder(
        builder: (context) {
          return GestureDetector(
            // onTap: () => store.filterAltered(index),
            child: Container(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: wXD(16, context), top: wXD(15, context)),
                    height: wXD(16, context),
                    width: wXD(16, context),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: getColors(context).primary),
                      color: getColors(context).surface,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      height: wXD(10, context),
                      width: wXD(10, context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: getColors(context).primary,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: textFamily(context,
                        fontSize: 12,
                        color: getColors(context).onBackground.withOpacity(.7)),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          height: maxHeight(context),
          width: maxWidth(context),
          child: Material(
            color: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, stateSet) {
                return Stack(
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        filterOverlay!.remove();
                      },
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            getColors(context).shadow,
                            BlendMode.color,
                          ),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease,
                            opacity: .3,
                            child: Container(
                              color: getColors(context).shadow,
                              height: maxHeight(context),
                              width: maxWidth(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.ease,
                      right: 0,
                      child: Container(
                        height: maxHeight(context),
                        width: wXD(260, context),
                        decoration: BoxDecoration(
                          color: getColors(context).surface,
                          borderRadius:
                              BorderRadius.horizontal(left: Radius.circular(3)),
                        ),
                        padding: EdgeInsets.fromLTRB(
                          wXD(11, context),
                          wXD(34, context),
                          wXD(8, context),
                          wXD(0, context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: wXD(20, context),
                                    color: getColors(context)
                                        .onBackground
                                        .withOpacity(.7),
                                  ),
                                ),
                                Spacer(flex: 3),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: wXD(30, context),
                                    width: wXD(60, context),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Limpar",
                                      style: textFamily(
                                        context,
                                        color: getColors(context)
                                            .onBackground
                                            .withOpacity(.7),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: wXD(30, context),
                                    width: wXD(50, context),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Filtrar",
                                      style: textFamily(
                                        context,
                                        color: getColors(context).primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: wXD(9, context)),
                              width: wXD(241, context),
                              color: getColors(context)
                                  .onBackground
                                  .withOpacity(.7)
                                  .withOpacity(.2),
                              height: wXD(.5, context),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  wXD(10, context),
                                  wXD(13, context),
                                  wXD(0, context),
                                  wXD(20, context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Período",
                                    style: textFamily(
                                      context,
                                      color: getColors(context).primary,
                                    ),
                                  ),
                                  getCheckPeriod("Hoje", 0),
                                  getCheckPeriod("Ontem", 1),
                                  getCheckPeriod("1ª quinzena do mês", 2),
                                  getCheckPeriod("2ª quinzena do mês", 3),
                                  getCheckPeriod("Mês passado", 4),
                                  SizedBox(height: wXD(20, context)),
                                  Text(
                                    "Período específico",
                                    style: textFamily(
                                      context,
                                      color: getColors(context).primary,
                                    ),
                                  ),
                                  SizedBox(height: wXD(15, context)),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {},
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: wXD(4, context)),
                                              height: wXD(29, context),
                                              width: wXD(76, context),
                                              decoration: BoxDecoration(
                                                color: getColors(context)
                                                    .background,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(3),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Data inicial",
                                                style: textFamily(
                                                  context,
                                                  fontSize: 10,
                                                  color: getColors(context)
                                                      .onBackground
                                                      .withOpacity(.5),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              TimeModel().date(Timestamp.now()),
                                              style: textFamily(
                                                context,
                                                fontSize: 10,
                                                color: getColors(context)
                                                    .onBackground
                                                    .withOpacity(.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: wXD(10, context)),
                                      GestureDetector(
                                        onTap: () async {},
                                        child: Column(
                                          children: [
                                            Container(
                                              height: wXD(29, context),
                                              width: wXD(76, context),
                                              margin: EdgeInsets.only(
                                                  bottom: wXD(4, context)),
                                              decoration: BoxDecoration(
                                                color: getColors(context)
                                                    .background,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(3),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Data final",
                                                style: textFamily(
                                                  context,
                                                  fontSize: 10,
                                                  color: getColors(context)
                                                      .onBackground
                                                      .withOpacity(.5),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              TimeModel().date(Timestamp.now()),
                                              style: textFamily(
                                                context,
                                                fontSize: 10,
                                                color: getColors(context)
                                                    .onBackground
                                                    .withOpacity(.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: wXD(241, context),
                              color: getColors(context)
                                  .onBackground
                                  .withOpacity(.7)
                                  .withOpacity(.2),
                              height: wXD(.5, context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(getColors(context).primary),
      child: Container(
        height: viewPaddingTop(context) + wXD(50, context),
        width: maxWidth(context),
        color: getColors(context).primary,
        padding: EdgeInsets.only(top: viewPaddingTop(context)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              // top: viewPaddingTop(context),
              left: 0,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: wXD(25, context, ws: 25),
                    color: getColors(context).onPrimary,
                  ),
                  onPressed: () {
                    OverlayEntry loadOverlay = OverlayEntry(
                        builder: (context) => LoadCircularOverlay());
                    Overlay.of(context)!.insert(loadOverlay);
                    mainStore.scaffoldKey.currentState?.openDrawer();
                    loadOverlay.remove();
                  },
                ),
              ),
            ),
            Text(
              "Nome da loja",
              style: textFamily(
                context,
                fontSize: 18,
                color: getColors(context).onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Positioned(
              // top: viewPaddingTop(context),
              right: wXD(0, context),
              // bottom: wXD(5, context),
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    OverlayEntry loadOverlay = OverlayEntry(
                        builder: (context) => LoadCircularOverlay());
                    Overlay.of(context)!.insert(loadOverlay);
                    filterOverlay = getFilterOverlay();
                    Overlay.of(context)!.insert(filterOverlay!);
                    loadOverlay.remove();
                  },
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    size: wXD(25, context),
                    color: getColors(context).onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
