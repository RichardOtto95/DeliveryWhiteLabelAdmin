import 'dart:ui';

import 'package:delivery_admin_white_label/app/modules/financial/financial_page.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class FinancialFilterPopup extends StatefulWidget {
  final void Function() onPop;

  const FinancialFilterPopup({
    Key? key,
    required this.onPop,
  }) : super(key: key);

  @override
  State<FinancialFilterPopup> createState() => _FinancialFilterPopupState();
}

class _FinancialFilterPopupState extends State<FinancialFilterPopup>
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Material(
            color: Colors.transparent,
            child: Stack(
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
                  right: -217 + 217 * _controller.value,
                  child: Container(
                    width: 217,
                    height: maxHeight(context),
                    padding: EdgeInsets.only(top: viewPaddingTop(context)),
                    decoration: BoxDecoration(
                      color: getColors(context).surface,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(9)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          offset: Offset(-2, 0),
                          color: getColors(context).shadow,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: 12.5, vertical: 10),
                          padding:
                              EdgeInsets.only(right: 3, bottom: 8.5, top: 22),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: getColors(context)
                                    .onSurface
                                    .withOpacity(.2),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.close_rounded,
                                  size: 12,
                                  color: getColors(context).onBackground,
                                ),
                                onPressed: () async {
                                  await animateTo(0);
                                  widget.onPop();
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  animateTo(0);
                                  widget.onPop();
                                },
                                child: Text(
                                  "Limpar",
                                  style: textFamily(context,
                                      fontSize: 13,
                                      color: getColors(context).onSurface),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  animateTo(0);
                                  widget.onPop();
                                },
                                child: Text(
                                  "filtrar",
                                  style: textFamily(
                                    context,
                                    fontSize: 13,
                                    color: getColors(context).primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 13),
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: getColors(context)
                                          .onSurface
                                          .withOpacity(.2)))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Período específico",
                                style: textFamily(context,
                                    fontSize: 12,
                                    color: getColors(context).onSurface),
                              ),
                              SizedBox(height: 14),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 29,
                                        width: 76,
                                        margin: EdgeInsets.only(bottom: 9),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: getColors(context)
                                              .onSurface
                                              .withOpacity(.1),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Data inicial",
                                          style: textFamily(
                                            context,
                                            fontSize: 10,
                                            color:
                                                getColors(context).onBackground,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "__/__/__",
                                        style: textFamily(
                                          context,
                                          fontSize: 13,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 29,
                                        width: 76,
                                        margin: EdgeInsets.only(bottom: 9),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: getColors(context)
                                              .onSurface
                                              .withOpacity(.1),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Data inicial",
                                          style: textFamily(
                                            context,
                                            fontSize: 10,
                                            color:
                                                getColors(context).onBackground,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "__/__/__",
                                        style: textFamily(
                                          context,
                                          fontSize: 13,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 15, right: 15, left: 15),
                          child: Column(
                            children: [
                              FilterField(
                                title: "ID",
                                hint: "id",
                              ),
                              FilterField(
                                title: "Origem",
                                hint: "origem",
                              ),
                              FilterField(
                                title: "Destino",
                                hint: "destino",
                              ),
                              FilterField(
                                title: "ID do pedido",
                                hint: "id do pedido",
                              ),
                              FilterField(
                                title: "Valor",
                                hint: "100",
                              ),
                              FilterField(
                                title: "Data",
                                hint: "__/__/__",
                              ),
                              FilterField(
                                title: "Justificativa",
                                hint: "justificativa",
                              ),
                              FilterField(
                                title: "Status",
                                hint: "status",
                              ),
                              FilterField(
                                title: "Método de pagamento",
                                hint: "método de pagamento",
                              ),
                              FilterField(
                                title: "Intenção de pagamento",
                                hint: "intenção de pagamento",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FilterField extends StatelessWidget {
  final String title;
  final String hint;
  FilterField({Key? key, required this.title, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            child: Text(
              "$title:",
              style: textFamily(
                context,
                fontSize: 12,
                color: getColors(context).onBackground,
              ),
            ),
          ),
          Container(
            height: 29,
            width: 103,
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: getColors(context).onSurface.withOpacity(.1),
            ),
            alignment: Alignment.centerLeft,
            child: TextFormField(
              style: textFamily(
                context,
                fontSize: 10,
                color: getColors(context).onSurface,
              ),
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: textFamily(
                  context,
                  fontSize: 10,
                  color: getColors(context).onSurface.withOpacity(.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
