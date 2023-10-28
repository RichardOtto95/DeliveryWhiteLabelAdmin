import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/main/main_store.dart';

class DefaultAppBar extends StatefulWidget {
  final String title;
  final void Function()? onPop;
  final bool noPop;
  final bool main;

  DefaultAppBar(
    this.title, {
    this.onPop,
    this.main = false,
    this.noPop = false,
  });

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  late final MainStore mainStore;

  @override
  void initState() {
    if (widget.main) {
      mainStore = Modular.get();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(getColors(context).surface),
      child: Container(
        width: maxWidth(context),
        height: MediaQuery.of(context).viewPadding.top + wXD(50, context),
        padding: EdgeInsets.only(top: viewPaddingTop(context)),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3)),
          color: widget.main
              ? getColors(context).primary
              : getColors(context).surface,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: getColors(context).shadow,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (!widget.noPop && !widget.main)
                Positioned(
                  left: wXD(0, context),
                  child: IconButton(
                    onPressed: () {
                      if (!widget.noPop) {
                        if (widget.onPop != null) {
                          widget.onPop!();
                        } else {
                          Modular.to.pop();
                        }
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: wXD(25, context),
                    ),
                  ),
                ),
              if (widget.main)
                Positioned(
                  left: wXD(0, context),
                  child: IconButton(
                    onPressed: () =>
                        mainStore.scaffoldKey.currentState!.openDrawer(),
                    icon: Icon(
                      Icons.menu,
                      size: wXD(25, context),
                    ),
                  ),
                ),
              Positioned(
                top: wXD(0, context, ws: 15),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: getColors(context).onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
