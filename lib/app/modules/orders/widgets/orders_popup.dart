import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/utilities.dart';
import '../../../shared/widgets/center_load_circular.dart';
import '../../../shared/widgets/emtpy_state.dart';
import '../../main/main_store.dart';
import '../orders_store.dart';
import 'order_widget.dart';
import 'orders_app_bar.dart';

class OrdersPopup extends StatefulWidget {
  final String sellerId;
  final void Function() onPop;

  const OrdersPopup({Key? key, required this.sellerId, required this.onPop})
      : super(key: key);

  @override
  State<OrdersPopup> createState() => _OrdersPopupState();
}

class _OrdersPopupState extends State<OrdersPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final OrdersStore store = Modular.get();
  final MainStore mainStore = Modular.get();

  PageController pageController = PageController();

  int limit = 10;
  double lastExtent = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, value: 0);
    animateTo(1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> animateTo(double val) async {
    await _controller.animateTo(val,
        duration: Duration(milliseconds: 400), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    await animateTo(0);
                    widget.onPop();
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: _controller.value + 0.001,
                      sigmaY: _controller.value + 0.001,
                    ),
                    child: Container(
                      height: maxHeight(context),
                      width: maxWidth(context),
                      color: getColors(context)
                          .shadow
                          .withOpacity(.3 * _controller.value),
                    ),
                  ),
                ),
                Positioned(
                  right: -wXD(411, context) + 411 * _controller.value,
                  child: Column(
                    children: [
                      OrdersAppBar(
                        onTap: (int value) {
                          lastExtent = 0;
                          setState(() {
                            limit = 15;
                          });
                          pageController.jumpToPage(value);
                        },
                      ),
                      Container(
                        color: getColors(context).background,
                        height: maxHeight(context),
                        width: wXD(411, context),
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: pageController,
                          children: [
                            getPendingList(),
                            getInProgressList(),
                            getConcludedList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget getPendingList() {
    List viewableOrderStatus = ['REQUESTED'];
    // print('getPendingList store.viewableOrderStatus: $viewableOrderStatus');
    // List<QueryDocumentSnapshot<Map<String, dynamic>>> orders;
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("sellers")
            .doc(widget.sellerId)
            .collection("orders")
            .where("status", whereIn: viewableOrderStatus)
            // .where("paid", isEqualTo: true)
            .orderBy("created_at", descending: true)
            .limit(limit)
            .snapshots(),
        builder: (context, snapshot) {
          // print(' getPendingList snapshot hasdata: ${snapshot.hasData}');
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          if (!snapshot.hasData) {
            return CenterLoadCircular();
          }
          List<QueryDocumentSnapshot<Map<String, dynamic>>> orders =
              snapshot.data!.docs;
          // print('getPendingList orders: $orders');
          // print('getPendingList orders.length: ${orders.length}');
          return orders.isEmpty
              ? EmptyState(
                  text: "Sem pedidos pendentes",
                  icon: Icons.file_copy_outlined,
                  height: maxHeight(context),
                )
              // Container(
              //     width: maxWidth(context),
              //     height: maxHeight(context),
              //     alignment: Alignment.center,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.file_copy_outlined,
              //           size: wXD(90, context),
              //         ),
              //         Text(
              //           "Sem pedidos pendentes ainda!",
              //           style: textFamily(context,),
              //         ),
              //       ],
              //     ),
              //   )
              : Column(
                  children: [
                    SizedBox(height: wXD(15, context)),
                    ...orders.map((order) {
                      // print('getPendingList order: ${order.id}');
                      // print(
                      //     'getPendingList order status: ${order.get("status")}');
                      return OrderWidget(
                        orderMap: order.data(),
                        status: order.get("status"),
                        agentStatus: order.get("agent_status") ?? "",
                      );
                    }),
                    Container(
                      height: wXD(120, context),
                      width: wXD(100, context),
                      alignment: Alignment.center,
                      child: limit == orders.length
                          ? CircularProgressIndicator()
                          : Container(),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget getInProgressList() {
    List viewableOrderStatus = [
      "SENDED",
      "PROCESSING",
      "DELIVERY_REQUESTED",
      "DELIVERY_REFUSED",
      "DELIVERY_ACCEPTED",
      "TIMEOUT",
    ];
    // print('getInProgressList store.viewableOrderStatus: $viewableOrderStatus');
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("sellers")
            .doc(widget.sellerId)
            .collection("orders")
            .where("status", whereIn: viewableOrderStatus)
            .orderBy("created_at", descending: true)
            .limit(limit)
            .snapshots(),
        builder: (context, snapshot) {
          // print('snapshot hasdata: ${snapshot.hasData}');

          if (!snapshot.hasData) {
            return CenterLoadCircular();
          }
          List<QueryDocumentSnapshot<Map<String, dynamic>>> orders =
              snapshot.data!.docs;
          // print('orders: $orders');
          // print('orders.length: ${orders.length}');
          return orders.isEmpty
              ? EmptyState(
                  text: "Sem pedidos em andamento",
                  icon: Icons.file_copy_outlined,
                  height: maxHeight(context),
                )
              : Column(
                  children: [
                    SizedBox(height: wXD(15, context)),
                    ...orders.map((order) {
                      // print('order: ${order.id}');
                      // print('order status: ${order.get("status")}');
                      return OrderWidget(
                        orderMap: order.data(),
                        status: order.get("status"),
                        agentStatus: order.get("agent_status") ?? "",
                      );
                    }),
                    Container(
                      height: wXD(120, context),
                      width: wXD(100, context),
                      alignment: Alignment.center,
                      child: limit == orders.length
                          ? CircularProgressIndicator()
                          : Container(),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget getConcludedList() {
    List viewableOrderStatus = [
      "CANCELED",
      "REFUSED",
      "CONCLUDED",
    ];
    // print('getConcludedList store.viewableOrderStatus: $viewableOrderStatus');
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("sellers")
            .doc(widget.sellerId)
            .collection("orders")
            .where("status", whereIn: viewableOrderStatus)
            .orderBy("created_at", descending: true)
            .limit(limit)
            .snapshots(),
        builder: (context, snapshot) {
          // print('snapshot hasdata: ${snapshot.hasData}');

          if (!snapshot.hasData) {
            return CenterLoadCircular();
          }
          List<QueryDocumentSnapshot<Map<String, dynamic>>> orders =
              snapshot.data!.docs;
          // print('orders: $orders');
          // print('orders.length: ${orders.length}');
          return orders.isEmpty
              ? EmptyState(
                  text: "Sem pedidos concluídos",
                  icon: Icons.file_copy_outlined,
                  height: maxHeight(context),
                )
              : Column(
                  children: [
                    SizedBox(height: wXD(15, context)),
                    ...orders.map((order) {
                      print('order: ${order.id}');
                      print('order status: ${order.get("status")}');
                      return OrderWidget(
                        orderMap: order.data(),
                        status: order.get("status"),
                        agentStatus: order.get("agent_status") ?? "",
                      );
                    }),
                    Container(
                      height: wXD(120, context),
                      width: wXD(100, context),
                      alignment: Alignment.center,
                      child: limit == orders.length
                          ? CircularProgressIndicator()
                          : Container(),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
