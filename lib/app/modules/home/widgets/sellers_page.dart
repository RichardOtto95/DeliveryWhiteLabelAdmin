import 'package:delivery_admin_white_label/app/modules/home/home_store.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'agents_page.dart';
import 'seller_card.dart';

class SellersPage extends StatelessWidget {
  SellersPage({Key? key}) : super(key: key);

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
                  SellerCard(
                    status: "ACTIVE",
                    online: true,
                  ),
                  SellerCard(
                    status: "ACTIVE",
                    online: true,
                  ),
                  SellerCard(
                    status: "ACTIVE",
                    online: true,
                  ),
                  SellerCard(
                    status: "ACTIVE",
                    online: true,
                  ),
                  ProfileTitle(
                    title: "Offline",
                    color: Colors.red,
                  ),
                  SellerCard(
                    status: "ACTIVE",
                    online: false,
                  ),
                  SellerCard(
                    status: "ACTIVE",
                    online: false,
                  ),
                  SellerCard(
                    status: "ACTIVE",
                    online: false,
                  ),
                  SellerCard(
                    status: "ACTIVE",
                    online: false,
                  ),
                  ProfileTitle(
                    title: "Inativos",
                    color: Colors.grey,
                  ),
                  SellerCard(
                    status: "INACTIVE",
                    online: false,
                  ),
                  SellerCard(
                    status: "INACTIVE",
                    online: false,
                  ),
                  SellerCard(
                    status: "INACTIVE",
                    online: false,
                  ),
                  SellerCard(
                    status: "INACTIVE",
                    online: false,
                  ),
                  ProfileTitle(
                    title: "Bloqueados",
                    color: Colors.yellow,
                  ),
                  SellerCard(
                    status: "BLOCKED",
                    online: false,
                  ),
                  SellerCard(
                    status: "BLOCKED",
                    online: false,
                  ),
                  SellerCard(
                    status: "BLOCKED",
                    online: false,
                  ),
                  SellerCard(
                    status: "BLOCKED",
                    online: false,
                  ),
                ],
              ),
            ),
            DefaultAppBar("Vendedores"),
          ],
        ),
      ),
    );
  }
}
