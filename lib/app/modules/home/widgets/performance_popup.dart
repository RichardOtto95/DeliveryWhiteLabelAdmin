import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/utilities.dart';
import '../home_store.dart';
import 'full_performance.dart';

class PerformancePopup extends StatefulWidget {
  final String agentId;
  final void Function() onPop;

  const PerformancePopup({
    Key? key,
    required this.onPop,
    required this.agentId,
  }) : super(key: key);

  @override
  State<PerformancePopup> createState() => _PerformancePopupState();
}

class _PerformancePopupState extends State<PerformancePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final HomeStore store = Modular.get();

  // late TabController tabController;

  PageController pageController = PageController();

  int limit = 10;
  double lastExtent = 0;

  @override
  void initState() {
    // tabController = TabController(length: 2, vsync: this);
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
                child: Container(
                  width: 411,
                  height: maxHeight(context),
                  child: Observer(
                    builder: (context) {
                      print('observer store filter: ${store.filterBool}');
                      if (store.filterBool) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          store.filterBool = false;
                          setState(() {});
                        });
                      }
                      return WillPopScope(
                        onWillPop: () async {
                          print(
                              "inkwell overlay null ${store.filterOverlay == null}");
                          if (store.filterisNotNull()) {
                            // store.filterOverlay!.remove();
                            store.removeOverlay = true;
                            return false;
                          }
                          return true;
                        },
                        child: Scaffold(
                          backgroundColor: getColors(context).background,
                          body: Stack(
                            children: [
                              Earnings(agentId: widget.agentId),
                              PerformanceAppBar(
                                // tabController: tabController,
                                onTap: (pg) async =>
                                    await pageController.animateToPage(pg,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease),
                                onPop: () async {
                                  await animateTo(0);
                                  widget.onPop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
