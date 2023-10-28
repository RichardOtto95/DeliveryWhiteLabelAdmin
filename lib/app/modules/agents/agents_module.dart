import 'package:delivery_admin_white_label/app/modules/agents/agents_Page.dart';
import 'package:delivery_admin_white_label/app/modules/agents/agents_store.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AgentsModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AgentsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AgentsPage()),
  ];

  @override
  Widget get view => AgentsPage();
}
