import 'dart:ui';

import 'package:delivery_admin_white_label/app/modules/financial/financial_page.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class BalancePopup extends StatefulWidget {
  final void Function() onPop;

  const BalancePopup({
    Key? key,
    required this.onPop,
  }) : super(key: key);

  @override
  State<BalancePopup> createState() => _BalancePopupState();
}

class _BalancePopupState extends State<BalancePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, value: 0);
    animateTo(1);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> animateTo(double val) async {
    await _controller.animateTo(val,
        duration: Duration(milliseconds: 400), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: maxHeight(context),
      width: maxWidth(context),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await animateTo(0);
              widget.onPop();
            },
            child: Container(
              color: Colors.transparent,
              width: maxWidth(context),
              height: 50,
            ),
          ),
          AnimatedBuilder(
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
                          height: maxHeight(context) - 50,
                          width: maxWidth(context),
                          color: getColors(context)
                              .shadow
                              .withOpacity(.3 * _controller.value),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -223 + 223 * _controller.value,
                      child: Container(
                        height: 223,
                        width: maxWidth(context),
                        decoration: BoxDecoration(
                          color: getColors(context).surface,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              offset: Offset(0, 2),
                              color: getColors(context).shadow,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            FinancialStatement(),
                            FinancialStatement(),
                            FinancialStatement(),
                            FinancialStatement(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
