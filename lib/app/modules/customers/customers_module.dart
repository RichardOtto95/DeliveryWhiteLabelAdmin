import 'package:delivery_admin_white_label/app/modules/customers/customers_Page.dart';
import 'package:delivery_admin_white_label/app/modules/customers/customers_store.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomersModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CustomersStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CustomersPage()),
  ];

  @override
  Widget get view => CustomersPage();
}
