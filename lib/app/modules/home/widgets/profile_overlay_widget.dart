import 'dart:ui';

import 'package:delivery_admin_white_label/app/modules/home/widgets/seller_data.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:flutter/cupertino.dart';

import 'agent_data.dart';

class ProfileOverlayWidget extends StatefulWidget {
  final String userId;
  final bool edit;
  final void Function() onBack;
  final String user;

  ProfileOverlayWidget({
    Key? key,
    required this.userId,
    this.edit = false,
    required this.onBack,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileOverlayWidget> createState() => _ProfileOverlayWidgetState();
}

class _ProfileOverlayWidgetState extends State<ProfileOverlayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, value: 0);
    animate(1);

    super.initState();
  }

  TickerFuture animate(value) => controller.animateTo(
        value,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOutQuint,
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () async {
                await animate(0);
                widget.onBack();
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2 * controller.value + 0.01,
                  sigmaY: 2 * controller.value + 0.01,
                ),
                child: Container(
                  height: maxHeight(context),
                  width: maxWidth(context),
                  color: getColors(context)
                      .shadow
                      .withOpacity(.3 * controller.value),
                ),
              ),
            ),
            Positioned(
              right: -411 + 411 * controller.value,
              child: Container(
                height: maxHeight(context),
                width: 411,
                child: getUserData(),
              ),
            ),
          ],
        );
      },
    );
  }

  getUserData() {
    if (widget.user == "seller") {
      return SellerData(
        sellerId: widget.userId,
        onBack: () async {
          await animate(0);
          widget.onBack();
        },
      );
    } else if (widget.user == "agent") {
      return AgentData(
        agentId: widget.userId,
        onBack: () async {
          await animate(0);
          widget.onBack();
        },
      );
    }
  }
}
