import 'package:delivery_admin_white_label/app/modules/categories/categories_page.dart';
import 'package:delivery_admin_white_label/app/modules/categories/categories_store.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/subcategories_page.dart';

class CategoriesModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CategoriesStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CategoriesPage()),
    ChildRoute(
      '/subcategories/',
      child: (_, args) => SubcategoriesPage(
        args.data["category"],
        args.data["collectionPath"],
      ),
    ),
  ];

  @override
  Widget get view => CategoriesPage();
}
