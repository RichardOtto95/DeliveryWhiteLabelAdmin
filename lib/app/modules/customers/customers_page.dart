import 'package:delivery_admin_white_label/app/modules/advertisement/widgets/ads_popup.dart';
import 'package:delivery_admin_white_label/app/modules/home/home_store.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/profile_overlay_widget.dart';
import 'package:delivery_admin_white_label/app/modules/orders/widgets/orders_popup.dart';
import 'package:delivery_admin_white_label/app/shared/responsive.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/confirm_popup.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/load_circular_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home/widgets/seller_menu_tile.dart';

class CustomersPage extends StatelessWidget {
  CustomersPage({Key? key}) : super(key: key);

  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (store.userMenu != null) {
          store.userMenu!.remove();
          store.userMenu = null;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: viewPaddingTop(context) + wXD(55, context)),
                  ProfileTitle(
                    title: "Online",
                    color: Colors.green,
                  ),
                  CustomerCard(
                    status: "ACTIVE",
                    online: true,
                  ),
                  CustomerCard(
                    status: "ACTIVE",
                    online: true,
                  ),
                  CustomerCard(
                    status: "ACTIVE",
                    online: true,
                  ),
                  CustomerCard(
                    status: "ACTIVE",
                    online: true,
                  ),
                  ProfileTitle(
                    title: "Offline",
                    color: Colors.red,
                  ),
                  CustomerCard(
                    status: "ACTIVE",
                    online: false,
                  ),
                  CustomerCard(
                    status: "ACTIVE",
                    online: false,
                  ),
                  CustomerCard(
                    status: "ACTIVE",
                    online: false,
                  ),
                  CustomerCard(
                    status: "ACTIVE",
                    online: false,
                  ),
                  ProfileTitle(
                    title: "Inativos",
                    color: Colors.grey,
                  ),
                  CustomerCard(
                    status: "INACTIVE",
                    online: false,
                  ),
                  CustomerCard(
                    status: "INACTIVE",
                    online: false,
                  ),
                  CustomerCard(
                    status: "INACTIVE",
                    online: false,
                  ),
                  CustomerCard(
                    status: "INACTIVE",
                    online: false,
                  ),
                  ProfileTitle(
                    title: "Bloqueados",
                    color: Colors.yellow,
                  ),
                  CustomerCard(
                    status: "BLOCKED",
                    online: false,
                  ),
                  CustomerCard(
                    status: "BLOCKED",
                    online: false,
                  ),
                  CustomerCard(
                    status: "BLOCKED",
                    online: false,
                  ),
                  CustomerCard(
                    status: "BLOCKED",
                    online: false,
                  ),
                ],
              ),
            ),
            DefaultAppBar("Cliente", main: true),
          ],
        ),
      ),
    );
  }
}

class ProfileTitle extends StatelessWidget {
  final Color color;
  final String title;

  const ProfileTitle({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: wXD(20, context),
        bottom: wXD(6, context),
        top: wXD(15, context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: textFamily(
              context,
              fontSize: 17,
              color: getColors(context).onBackground,
            ),
          ),
          Container(
            height: wXD(11, context),
            width: wXD(11, context),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ],
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final bool online;
  final String status;

  CustomerCard({
    Key? key,
    required this.status,
    required this.online,
  }) : super(key: key);

  final HomeStore store = Modular.get();

  final _overlayLink = LayerLink();

  Color getColor() {
    if (status == "INACTIVE") {
      return Colors.grey;
    }

    if (status == "BLOCKED") {
      return Colors.yellow;
    }

    if (online) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  OverlayEntry getCustomerMenu() => OverlayEntry(
        builder: (context) => Positioned(
          // height: wXD(135, context),
          width: wXD(145, context),
          child: CompositedTransformFollower(
            offset: Offset(wXD(-100, context), wXD(10, context)),
            link: _overlayLink,
            child: Container(
              // height: wXD(135, context),
              width: wXD(126, context),
              padding: EdgeInsets.only(
                left: wXD(7, context),
                top: wXD(2, context),
                right: wXD(7, context),
                bottom: wXD(2, context),
              ),
              decoration: BoxDecoration(
                color: getColors(context).surface,
                borderRadius:
                    BorderRadius.all(Radius.circular(wXD(6, context))),
                boxShadow: [
                  BoxShadow(
                      blurRadius: wXD(6, context),
                      offset: Offset(0, 3),
                      color: getColors(context).shadow),
                ],
              ),
              child: Column(
                children: [
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      if (Responsive.isDesktop(context)) {
                        late OverlayEntry profileOverlay;
                        profileOverlay = OverlayEntry(
                            builder: (context) => ProfileOverlayWidget(
                                  user: "seller",
                                  userId: "",
                                  onBack: () => profileOverlay.remove(),
                                  edit: true,
                                ));
                        Overlay.of(context)!.insert(profileOverlay);
                      } else {
                        Modular.to.pushNamed(
                          "/home/seller",
                          arguments: {"sellerId": "", "edit": true},
                        );
                      }
                      store.userMenu!.remove();
                      store.userMenu = null;
                      loadOverlay.remove();
                    },
                    title: "Editar",
                    icon: Icons.edit,
                  ),
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      if (Responsive.isDesktop(context)) {
                        late OverlayEntry profileOverlay;
                        profileOverlay = OverlayEntry(
                            builder: (context) => ProfileOverlayWidget(
                                  user: "seller",
                                  userId: "",
                                  onBack: () => profileOverlay.remove(),
                                ));
                        Overlay.of(context)!.insert(profileOverlay);
                      } else {
                        Modular.to.pushNamed(
                          "/home/seller",
                          arguments: {"sellerId": "", "edit": false},
                        );
                      }
                      store.userMenu!.remove();
                      store.userMenu = null;
                      loadOverlay.remove();
                    },
                    title: "Visulizar",
                    icon: Icons.remove_red_eye,
                  ),
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      late OverlayEntry confirmOverlay;
                      confirmOverlay = OverlayEntry(
                          builder: (context) => ConfirmPopup(
                                text:
                                    "Tem certeza que deseja bloquear este usuário?",
                                onConfirm: () {
                                  confirmOverlay.remove();
                                },
                                onCancel: () {
                                  confirmOverlay.remove();
                                },
                              ));
                      Overlay.of(context)!.insert(confirmOverlay);
                      store.userMenu!.remove();
                      store.userMenu = null;
                      loadOverlay.remove();
                    },
                    title: "Bloquear",
                    icon: Icons.block,
                  ),
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      store.userMenu!.remove();
                      store.userMenu = null;
                      if (Responsive.isDesktop(context)) {
                        late OverlayEntry adsOverlay;
                        adsOverlay = OverlayEntry(
                          builder: (context) => AdsPopup(
                            onPop: () => adsOverlay.remove(),
                            sellerId: "Iz3wa9Ou9GP4DDnpbi3yEtfNQbJ3",
                          ),
                        );
                        Overlay.of(context)!.insert(adsOverlay);
                      } else {
                        Modular.to.pushNamed("/advertisement");
                      }
                      loadOverlay.remove();
                    },
                    title: "Ver anúncios",
                    icon: Icons.campaign_outlined,
                  ),
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      if (Responsive.isDesktop(context)) {
                        late OverlayEntry ordersOverlay;
                        ordersOverlay = OverlayEntry(
                            builder: (context) => OrdersPopup(
                                sellerId: "Iz3wa9Ou9GP4DDnpbi3yEtfNQbJ3",
                                onPop: () => ordersOverlay.remove()));
                        Overlay.of(context)!.insert(ordersOverlay);
                      } else {
                        Modular.to.pushNamed("/orders");
                      }
                      store.userMenu!.remove();
                      store.userMenu = null;
                      loadOverlay.remove();
                    },
                    title: "Ver pedidos",
                    icon: Icons.list_alt_outlined,
                  ),
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      store.userMenu!.remove();
                      store.userMenu = null;
                      Modular.to.pushNamed("/financial/",
                          arguments: "Iz3wa9Ou9GP4DDnpbi3yEtfNQbJ3");
                      loadOverlay.remove();
                    },
                    title: "Ver finanças",
                    icon: Icons.monetization_on_outlined,
                  ),
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      store.userMenu!.remove();
                      store.userMenu = null;
                      Modular.to.pushNamed('/messages/chat', arguments: {
                        "receiverId": "",
                        "receiverCollection": "sellers",
                      });
                      loadOverlay.remove();
                    },
                    title: "Mensagem",
                    icon: Icons.chat_outlined,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth(context),
      height: wXD(64, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(wXD(9, context))),
        color: getColors(context).surface,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 2),
            color: getColors(context).shadow,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: wXD(8, context)),
      margin: EdgeInsets.symmetric(
        horizontal: wXD(9, context),
        vertical: wXD(4, context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: wXD(5, context), bottom: wXD(4, context)),
                width: wXD(52, context),
                height: wXD(48, context),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(wXD(4, context))),
                  child: Container(
                    width: wXD(52, context),
                    height: wXD(48, context),
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: wXD(11, context),
                  width: wXD(11, context),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: getColor()),
                ),
              )
            ],
          ),
          SizedBox(width: wXD(2, context)),
          Container(
            alignment: Alignment.centerLeft,
            width: wXD(230, context, mediaWeb: true),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fulano ciclano de tal",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: textFamily(
                    context,
                    fontSize: 13,
                    color: getColors(context).onBackground,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: wXD(5, context)),
                  child: Text(
                    "Estado tal, cidade tal, bairro tal rua tal",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textFamily(
                      context,
                      fontSize: 13,
                      color: getColors(context).onSurface,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: wXD(5, context)),
                  child: Text(
                    "Seg a Sex, das 18:00 às 08:00",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textFamily(
                      context,
                      fontSize: 13,
                      color: getColors(context).onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          CompositedTransformTarget(
            link: _overlayLink,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  print("Customer menu");
                  store.userMenu = getCustomerMenu();
                  Overlay.of(context)!.insert(store.userMenu!);
                },
                icon: Icon(
                  Icons.more_vert,
                  size: wXD(25, context),
                  color: getColors(context).onBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
