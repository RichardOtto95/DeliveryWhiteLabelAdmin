import 'package:delivery_admin_white_label/app/modules/financial/widgets/financial_filter_popup.dart';
import 'package:delivery_admin_white_label/app/modules/main/main_store.dart';
import 'package:delivery_admin_white_label/app/shared/responsive.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/load_circular_overlay.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'balance_popup.dart';

class FinancialAppBar extends StatelessWidget {
  final bool noPop;

  FinancialAppBar({this.noPop = true});

  final MainStore mainStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(getColors(context).surface),
      child: Container(
        width: maxWidth(context),
        height: MediaQuery.of(context).viewPadding.top + wXD(50, context),
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3)),
          color:
              noPop ? getColors(context).primary : getColors(context).surface,
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
              Positioned(
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (Responsive.isDesktop(context))
                      InkWell(
                        onTap: () {
                          OverlayEntry loadOverlay = OverlayEntry(
                              builder: (context) => LoadCircularOverlay());
                          Overlay.of(context)!.insert(loadOverlay);
                          late OverlayEntry balanceOverlay;
                          balanceOverlay = OverlayEntry(
                              builder: (context) => BalancePopup(
                                    onPop: () => balanceOverlay.remove(),
                                  ));
                          Overlay.of(context)!.insert(balanceOverlay);
                          loadOverlay.remove();
                        },
                        child: Container(
                          height: wXD(50, context),
                          width: wXD(50, context),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            "./assets/svg/monthly_balance.svg",
                            height: 25,
                            width: 25,
                            // fit: BoxFit.contain,
                          ),
                          // color: getColors(context).onPrimary,
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        OverlayEntry loadOverlay = OverlayEntry(
                            builder: (context) => LoadCircularOverlay());
                        Overlay.of(context)!.insert(loadOverlay);
                        late OverlayEntry financialFilterOverlay;
                        financialFilterOverlay = OverlayEntry(
                            builder: (context) => FinancialFilterPopup(
                                  onPop: () => financialFilterOverlay.remove(),
                                ));
                        Overlay.of(context)!.insert(financialFilterOverlay);
                        loadOverlay.remove();
                      },
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        size: wXD(25, context),
                        color: getColors(context).onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              if (!noPop)
                Positioned(
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: wXD(25, context),
                      color: getColors(context).onPrimary,
                    ),
                  ),
                ),
              if (noPop)
                Positioned(
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      mainStore.scaffoldKey.currentState!.openDrawer();
                      loadOverlay.remove();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: wXD(25, context),
                      color: getColors(context).onPrimary,
                    ),
                  ),
                ),
              Positioned(
                // bottom: wXD(9, context),
                child: Text(
                  "Financeiro",
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
