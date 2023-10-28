import 'package:delivery_admin_white_label/app/modules/sections/sections_store.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'sections_page.dart';

class SectionsModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SectionsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SectionsPage()),
  ];

  @override
  Widget get view => SectionsPage();
}
