import 'package:delivery_admin_white_label/app/modules/home/widgets/seller_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/responsive.dart';
import '../../../shared/utilities.dart';
import '../../../shared/widgets/confirm_popup.dart';
import '../../../shared/widgets/load_circular_overlay.dart';
import '../home_store.dart';
import 'performance_popup.dart';
import 'profile_overlay_widget.dart';

class AgentCard extends StatelessWidget {
  final bool online;
  final String status;

  AgentCard({
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

  OverlayEntry getSellerMenu() => OverlayEntry(
        builder: (context) => Positioned(
          // height: wXD(135, context),
          width: wXD(150, context),
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
                            user: "agent",
                            userId: "",
                            onBack: () => profileOverlay.remove(),
                            edit: true,
                          ),
                        );
                        Overlay.of(context)!.insert(profileOverlay);
                      } else {
                        Modular.to.pushNamed(
                          "/home/agent",
                          arguments: {"agentId": "", "edit": true},
                        );
                      }
                      store.userMenu!.remove();
                      store.userMenu = null;
                      loadOverlay.remove();
                    },
                    icon: Icons.edit,
                    title: "Editar",
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
                            user: "agent",
                            userId: "",
                            onBack: () => profileOverlay.remove(),
                          ),
                        );
                        Overlay.of(context)!.insert(profileOverlay);
                      } else {
                        Modular.to.pushNamed(
                          "/home/agent",
                          arguments: {"agentId": "", "edit": false},
                        );
                      }
                      store.userMenu!.remove();
                      store.userMenu = null;
                      loadOverlay.remove();
                    },
                    icon: Icons.remove_red_eye,
                    title: "Visulizar",
                  ),
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      store.userMenu!.remove();
                      store.userMenu = null;

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
                      loadOverlay.remove();
                    },
                    icon: Icons.block,
                    title: "Bloquear",
                  ),
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      if (Responsive.isDesktop(context)) {
                        late OverlayEntry performanceOverlay;
                        performanceOverlay = OverlayEntry(
                          builder: (context) => PerformancePopup(
                            agentId: "Iz3wa9Ou9GP4DDnpbi3yEtfNQbJ3",
                            onPop: () => performanceOverlay.remove(),
                          ),
                        );
                        Overlay.of(context)!.insert(performanceOverlay);
                      } else {
                        Modular.to.pushNamed(
                          "/home/full-performance",
                          arguments: "Iz3wa9Ou9GP4DDnpbi3yEtfNQbJ3",
                        );
                      }
                      store.userMenu!.remove();
                      store.userMenu = null;
                      loadOverlay.remove();
                    },
                    icon: Icons.campaign_outlined,
                    title: "Desempenho",
                  ),
                  MenuTile(
                    onTap: () {
                      OverlayEntry loadOverlay = OverlayEntry(
                          builder: (context) => LoadCircularOverlay());
                      Overlay.of(context)!.insert(loadOverlay);
                      store.userMenu!.remove();
                      store.userMenu = null;
                      loadOverlay.remove();
                    },
                    icon: Icons.chat_outlined,
                    title: "Mensagem",
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
                  print("Seller menu");
                  store.userMenu = getSellerMenu();
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
