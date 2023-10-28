import 'package:delivery_admin_white_label/app/modules/sellers/sellers_Page.dart';
import 'package:delivery_admin_white_label/app/modules/sellers/sellers_store.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SellersModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SellersStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SellersPage()),
  ];

  @override
  Widget get view => SellersPage();
}
