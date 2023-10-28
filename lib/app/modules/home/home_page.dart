import 'package:delivery_admin_white_label/app/modules/home/widgets/agents_page.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/graph.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/home_app_bar.dart';
import 'package:delivery_admin_white_label/app/modules/home/widgets/statistic.dart';
import 'package:delivery_admin_white_label/app/modules/main/main_store.dart';
import 'package:delivery_admin_white_label/app/modules/home/home_store.dart';
import 'package:delivery_admin_white_label/app/shared/responsive.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '../../shared/grid_scroll_behavior.dart';
import 'widgets/agent_card.dart';
import 'widgets/seller_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore>
    with SingleTickerProviderStateMixin {
  MainStore mainStore = Modular.get();

  int selected = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Statistic> statistics = [
    Statistic(
      title: "Pedidos solicitados",
      data: "100",
      icon: Icons.merge,
    ),
    Statistic(
      title: "Pedidos processando",
      data: "97",
      icon: Icons.sync,
    ),
    Statistic(
      title: "Pedidos recusados",
      data: "7",
      icon: Icons.cancel_outlined,
    ),
    Statistic(
      title: "Pedidos cancelados",
      data: "20",
      icon: Icons.cancel,
    ),
    Statistic(
      title: "Pedidos buscando agente",
      data: "79",
      icon: Icons.search,
    ),
    Statistic(
      title: "Pedidos aguardando agente",
      data: "99",
      icon: Icons.hourglass_bottom_rounded,
    ),
    Statistic(
        title: "Pedidos recusados pelo agente",
        data: "3",
        icon: Icons.cancel_outlined),
    Statistic(
      title: "Pedidos cancelados pelo agente",
      data: "5",
      icon: Icons.cancel,
    ),
    Statistic(
      title: "Pedidos enviados",
      data: "88",
      icon: Icons.done_all,
    ),
    Statistic(
        title: "Pedidos com falha no pagamento",
        data: "2",
        icon: Icons.dangerous),
    Statistic(
      title: "Categorias",
      data: "15",
      icon: Icons.category,
    ),
    Statistic(
      title: "Anúncios",
      data: "54",
      icon: Icons.campaign,
    ),
    Statistic(
      title: "Seções",
      data: "80",
      icon: Icons.library_add,
    ),
    Statistic(
      title: "Chamados",
      data: "200",
      icon: Icons.support_agent,
    ),
    Statistic(
      title: "Chamados abertos",
      data: "30",
      icon: Icons.chat,
    ),
    Statistic(
      title: "Chamados concluídos",
      data: "170",
      icon: Icons.recommend,
    ),
    Statistic(
      title: "Cupons",
      data: "20",
      icon: Icons.confirmation_num,
    ),
    Statistic(
      title: "Clientes",
      data: "600",
      icon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Statistic> onlineStatistics = [
      Statistic(
        title: "Vendedores online",
        totalData: "300",
        data: "250",
        icon: Icons.arrow_forward_ios_rounded,
        onTap: () {
          Modular.to.pushNamed("/home/sellers");
        },
      ),
      Statistic(
        title: "Agentes online",
        totalData: "300",
        data: "250",
        icon: Icons.arrow_forward_ios_rounded,
        onTap: () {
          Modular.to.pushNamed("/home/agents");
        },
      ),
    ];

    if (Responsive.isMobile(context) && statistics.length < 20) {
      statistics += onlineStatistics;
    }

    return Listener(
      onPointerDown: (event) {
        if (store.userMenu != null) {
          store.userMenu!.remove();
          store.userMenu = null;
        }
      },
      child: Stack(
        children: [
          ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: viewPaddingTop(context) + wXD(43, context),
                  width: maxWidth(context),
                ),
                Responsive(
                  mobile: Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: wXD(6, context)),
                      reverse: true,
                      child: Column(
                        children: statistics,
                      ),
                    ),
                  ),
                  desktop: SizedBox(
                    height: 180,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        children: statistics,
                      ),
                    ),
                  ),
                ),
                Responsive(
                  mobile: SizedBox(
                    height: wXD(265, context),
                    width: maxWidth(context),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.symmetric(horizontal: wXD(10, context)),
                      child: Row(
                        children: [
                          Graph(),
                          Graph(),
                          Graph(),
                          Graph(),
                          Graph(),
                        ],
                      ),
                    ),
                  ),
                  desktop: Expanded(
                    child: Container(
                      width: maxWidth(context),
                      padding:
                          EdgeInsets.symmetric(horizontal: wW(37, context)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: getColors(context)
                                              .onSurface
                                              .withOpacity(.5)))),
                              child: SingleChildScrollView(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 30,
                                  runSpacing: 20,
                                  children: [
                                    Graph(),
                                    Graph(),
                                    Graph(),
                                    Graph(),
                                    Graph(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        onlineStatistics[0],
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
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        onlineStatistics[0],
                                        ProfileTitle(
                                          title: "Online",
                                          color: Colors.green,
                                        ),
                                        AgentCard(
                                          status: "ACTIVE",
                                          online: true,
                                        ),
                                        AgentCard(
                                          status: "ACTIVE",
                                          online: true,
                                        ),
                                        AgentCard(
                                          status: "ACTIVE",
                                          online: true,
                                        ),
                                        AgentCard(
                                          status: "ACTIVE",
                                          online: true,
                                        ),
                                        ProfileTitle(
                                          title: "Offline",
                                          color: Colors.red,
                                        ),
                                        AgentCard(
                                          status: "ACTIVE",
                                          online: false,
                                        ),
                                        AgentCard(
                                          status: "ACTIVE",
                                          online: false,
                                        ),
                                        AgentCard(
                                          status: "ACTIVE",
                                          online: false,
                                        ),
                                        AgentCard(
                                          status: "ACTIVE",
                                          online: false,
                                        ),
                                        ProfileTitle(
                                          title: "Inativos",
                                          color: Colors.grey,
                                        ),
                                        AgentCard(
                                          status: "INACTIVE",
                                          online: false,
                                        ),
                                        AgentCard(
                                          status: "INACTIVE",
                                          online: false,
                                        ),
                                        AgentCard(
                                          status: "INACTIVE",
                                          online: false,
                                        ),
                                        AgentCard(
                                          status: "INACTIVE",
                                          online: false,
                                        ),
                                        ProfileTitle(
                                          title: "Bloqueados",
                                          color: Colors.yellow,
                                        ),
                                        AgentCard(
                                          status: "BLOCKED",
                                          online: false,
                                        ),
                                        AgentCard(
                                          status: "BLOCKED",
                                          online: false,
                                        ),
                                        AgentCard(
                                          status: "BLOCKED",
                                          online: false,
                                        ),
                                        AgentCard(
                                          status: "BLOCKED",
                                          online: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          HomeAppBar(),
        ],
      ),
    );
  }
}
