import 'package:delivery_admin_white_label/app/modules/financial/financial_Page.dart';
import 'package:delivery_admin_white_label/app/modules/financial/financial_store.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FinancialModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FinancialStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => FinancialPage(sellerId: args.data)),
  ];

  @override
  Widget get view => FinancialPage();
}
