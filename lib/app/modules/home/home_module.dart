import 'package:delivery_admin_white_label/app/modules/home/home_Page.dart';
import 'package:delivery_admin_white_label/app/modules/home/home_store.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/agent_data.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/agents_page.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/best_sellers.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/full_performance.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/seller_data.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/sellers_page.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomePage()),
    ChildRoute('/best-sellers', child: (_, args) => BestSellers()),
    ChildRoute('/sellers', child: (_, args) => SellersPage()),
    ChildRoute('/seller',
        child: (_, args) => SellerData(
              sellerId: args.data["sellerId"],
              edit: args.data["edit"],
            )),
    ChildRoute('/agents', child: (_, args) => AgentsPage()),
    ChildRoute('/full-performance',
        child: (_, args) => FullPerformance(agentId: args.data)),
    ChildRoute('/agent',
        child: (_, args) => AgentData(
              agentId: args.data["agentId"],
              edit: args.data["edit"],
            )),
  ];

  @override
  Widget get view => HomePage();
}
