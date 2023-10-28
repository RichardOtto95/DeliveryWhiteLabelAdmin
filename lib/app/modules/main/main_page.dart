import 'package:delivery_admin_white_label/app/modules/advertisement/advertisement_module.dart';
import 'package:delivery_admin_white_label/app/modules/agents/agents_module.dart';
import 'package:delivery_admin_white_label/app/modules/attendence/attendence_module.dart';
import 'package:delivery_admin_white_label/app/modules/categories/categories_module.dart';
import 'package:delivery_admin_white_label/app/modules/customers/customers_module.dart';
import 'package:delivery_admin_white_label/app/modules/financial/financial_module.dart';
import 'package:delivery_admin_white_label/app/modules/home/home_module.dart';
import 'package:delivery_admin_white_label/app/modules/orders/orders_module.dart';
import 'package:delivery_admin_white_label/app/modules/sections/sections_module.dart';
import 'package:delivery_admin_white_label/app/modules/sellers/sellers_module.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/grid_scroll_behavior.dart';
import '../../shared/utilities.dart';
import 'main_store.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ModularState<MainPage, MainStore> {
  @override
  void initState() {
    FirebaseMessaging.instance.onTokenRefresh.listen(store.saveTokenToDatabase);
    super.initState();
  }

  List<Widget> modules = [
    HomeModule(),
    FinancialModule(),
    AttendenceModule(),
    SellersModule(),
    AgentsModule(),
    CustomersModule(),
    OrdersModule(),
    AdvertisementModule(),
    CategoriesModule(),
    SectionsModule(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        store.setVisibleNav(true);
        return false;
      },
      child: Scaffold(
        key: store.scaffoldKey,
        drawer: Drawer(
          width: wXD(289, context, ws: 289),
          backgroundColor: getColors(context).surface,
          child: Observer(
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: wXD(25, context),
                      bottom: wXD(50, context),
                    ),
                    child: Image.asset(
                      brightness == Brightness.light
                          ? "./assets/images/logo.png"
                          : "./assets/images/logo_dark.png",
                      fit: BoxFit.fitWidth,
                      width: wXD(155, context, ws: 155),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DrawerTile(
                            title: "Início",
                            isSelected: store.page == 0,
                            onTap: () => store.setPage(0, context),
                            icon: Icons.home_outlined,
                          ),
                          DrawerTile(
                            title: "Financeiro",
                            isSelected: store.page == 1,
                            onTap: () => store.setPage(1, context),
                            icon: Icons.monetization_on_outlined,
                          ),
                          DrawerTile(
                            title: "Atendimento",
                            isSelected: store.page == 2,
                            onTap: () => store.setPage(2, context),
                            icon: Icons.support_agent,
                          ),
                          DrawerTile(
                            title: "Vendedores",
                            isSelected: store.page == 3,
                            onTap: () => store.setPage(3, context),
                            icon: Icons.storefront_outlined,
                          ),
                          DrawerTile(
                            title: "Agentes",
                            isSelected: store.page == 4,
                            onTap: () => store.setPage(4, context),
                            icon: Icons.motorcycle_outlined,
                          ),
                          DrawerTile(
                            title: "Clientes",
                            isSelected: store.page == 5,
                            onTap: () => store.setPage(5, context),
                            icon: Icons.people_outline,
                          ),
                          DrawerTile(
                            title: "Pedidos",
                            isSelected: store.page == 6,
                            onTap: () => store.setPage(6, context),
                            icon: Icons.receipt_long,
                          ),
                          DrawerTile(
                            title: "Anúncios",
                            isSelected: store.page == 7,
                            onTap: () => store.setPage(7, context),
                            icon: Icons.announcement_outlined,
                          ),
                          DrawerTile(
                            title: "Categorias",
                            isSelected: store.page == 8,
                            onTap: () => store.setPage(8, context),
                            icon: Icons.category_outlined,
                          ),
                          DrawerTile(
                            title: "Seções",
                            isSelected: store.page == 9,
                            onTap: () => store.setPage(9, context),
                            icon: Icons.add_business_outlined,
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
        body: Observer(builder: (context) {
          return Container(
            height: maxHeight(context),
            width: maxWidth(context),
            child: modules[store.page],
            // child: ScrollConfiguration(
            //   behavior: CustomScrollBehavior(),
            //   child: PageView(
            //     physics: NeverScrollableScrollPhysics(),
            //     controller: store.pageController,
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       HomeModule(),
            //       FinancialModule(),
            //       AttendenceModule(),
            //       SellersModule(),
            //       AgentsModule(),
            //       CustomersModule(),
            //       OrdersModule(),
            //       AdvertisementModule(),
            //       CategoriesModule(),
            //       SectionsModule(),
            //     ],
            //     onPageChanged: (value) {
            //       // print('value: $value');
            //       store.page = value;
            //       store.setVisibleNav(true);
            //     },
            //   ),
            // ),
          );
        }),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final IconData icon;
  final void Function() onTap;

  const DrawerTile({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Container(
              height: wXD(53, context),
              width: wXD(249, context),
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                border: Border.all(
                  color: getColors(context)
                      .primary
                      .withOpacity(isSelected ? 1 : .3),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: wXD(20, context, ws: 25),
                    color: getColors(context)
                        .primary
                        .withOpacity(isSelected ? 1 : .3),
                  ),
                  SizedBox(width: wXD(15, context, ws: 15)),
                  Text(
                    title,
                    style: textFamily(
                      context,
                      color: getColors(context).onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: wXD(15, context, ws: 15)),
      ],
    );
  }
}
