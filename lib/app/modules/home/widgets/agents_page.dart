import 'package:delivery_admin_white_label/app/modules/home/home_store.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'agent_card.dart';

class AgentsPage extends StatelessWidget {
  AgentsPage({Key? key}) : super(key: key);

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
            DefaultAppBar("Agentes"),
          ],
        ),
      ),
    );
  }
}

class ProfileTitle extends StatelessWidget {
  final Color color;
  final String title;

  const ProfileTitle({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: wXD(20, context),
        bottom: wXD(6, context),
        top: wXD(15, context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: textFamily(
              context,
              fontSize: 17,
              color: getColors(context).onBackground,
            ),
          ),
          Container(
            height: wXD(11, context),
            width: wXD(11, context),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ],
      ),
    );
  }
}
