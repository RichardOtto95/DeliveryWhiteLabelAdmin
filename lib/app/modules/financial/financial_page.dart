import 'dart:ui';
import 'package:delivery_admin_white_label/app/modules/financial/widgets/financial_app_bar.dart';
import 'package:delivery_admin_white_label/app/shared/grid_scroll_behavior.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/center_load_circular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:delivery_admin_white_label/app/modules/financial/financial_store.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'dart:math' as math;
import '../../shared/color_theme.dart';
import '../../shared/responsive.dart';

class FinancialPage extends StatefulWidget {
  final String? sellerId;

  const FinancialPage({Key? key, this.sellerId}) : super(key: key);

  @override
  FinancialPageState createState() => FinancialPageState();
}

class FinancialPageState extends State<FinancialPage> {
  final FinancialStore store = Modular.get();

  final DataPagerController dataPagerController = DataPagerController();

  final double columnWidth = 220;

  @override
  void initState() {
    store.setFinancialDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List months = [
      'jan',
      'fev',
      'mar',
      'abr',
      'mai',
      'jun',
      'jul',
      'ago',
      'set',
      'out',
      'nov',
      'dez',
    ];
    return Scaffold(
      backgroundColor: getColors(context).surface,
      body: Observer(
        builder: (context) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: Stack(
              children: [
                Responsive(
                  mobile: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: wXD(92, context)),
                        Container(
                          width: maxWidth(context),
                          padding: EdgeInsets.only(
                            left: wXD(16, context),
                            right: wXD(11, context),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Setembro de 2021',
                                style: textFamily(
                                  context,
                                  fontSize: 14,
                                  color: getColors(context).onBackground,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => store.setSelectMonth(true),
                                child: Text(
                                  'Meses',
                                  style: textFamily(context,
                                      fontSize: 14,
                                      color: getColors(context).error),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: maxWidth(context),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: getColors(context)
                                          .onBackground
                                          .withOpacity(.2)))),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: wXD(14.5, context),
                            ),
                            child: Row(
                              children: [
                                FinancialStatement(),
                                FinancialStatement(),
                                FinancialStatement(),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: wXD(16, context),
                            top: wXD(18, context),
                            bottom: wXD(14, context),
                          ),
                          child: Text(
                            'Repasses por período',
                            style: textFamily(
                              context,
                              fontSize: 14,
                              color: getColors(context).onBackground,
                            ),
                          ),
                        ),
                        PeriodicTransfer(first: true),
                        PeriodicTransfer(),
                        PeriodicTransfer(),
                        PeriodicTransfer(),
                        PeriodicTransfer(),
                        PeriodicTransfer(),
                        PeriodicTransfer(),
                        PeriodicTransfer(),
                        PeriodicTransfer(),
                      ],
                    ),
                  ),
                  desktop: Column(
                    children: [
                      Observer(builder: (context) {
                        if (store.financialDataSource == null) {
                          return CenterLoadCircular();
                        }
                        return Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 50),
                              height: maxHeight(context),
                              width: maxWidth(context),
                              child: SfDataGrid(
                                gridLinesVisibility: GridLinesVisibility.both,
                                headerGridLinesVisibility:
                                    GridLinesVisibility.both,
                                source: store.financialDataSource!,
                                columns: [
                                  GridColumn(
                                    width: columnWidth,
                                    columnName: "id",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "ID",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    width: columnWidth,
                                    columnName: "origin",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Origem",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    width: columnWidth,
                                    columnName: "destiny",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Destino",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    width: columnWidth,
                                    columnName: "orderId",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "ID do Pedido",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    width: columnWidth,
                                    columnName: "value",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Valor",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    width: columnWidth,
                                    columnName: "date",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Data",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    width: columnWidth,
                                    columnName: "status",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Status",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    width: columnWidth,
                                    columnName: "paymentMethod",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Método de pagamento",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    width: columnWidth,
                                    columnName: "paymentIntent",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Intenção de pagamento",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    width: 160,
                                    columnName: "actions",
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Ações",
                                        style: textFamily(
                                          context,
                                          fontSize: 16,
                                          color:
                                              getColors(context).onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: wXD(60, context),
                              bottom: wXD(40, context),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                        color: getColors(context).onSurface),
                                    color: getColors(context).surface,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        offset: Offset(0, 1),
                                        color: getColors(context).shadow,
                                      )
                                    ]),
                                // padding: EdgeInsets.symmetric(
                                //   vertical: 11,
                                //   horizontal: 13,
                                // ),
                                child: SfDataPagerTheme(
                                  data: SfDataPagerThemeData(
                                      itemBorderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: SfDataPager(
                                    controller: dataPagerController,
                                    delegate: store.financialDataSource!,
                                    pageCount: store.getPageCount(),
                                    direction: Axis.horizontal,
                                    onPageNavigationEnd: (val) {
                                      // print("onPageNavigationEnd: $val");
                                      print(
                                          "selectedend: ${dataPagerController.selectedPageIndex}");
                                    },
                                    onPageNavigationStart: (val) {
                                      // print("onPageNavigationStart: $val");
                                      // print("onPageNavigationStart: $val");
                                      print(
                                          "selectedstart: ${dataPagerController.selectedPageIndex}");
                                    },
                                    pageItemBuilder: (value) {
                                      // print("value: $value");
                                      // return Container();
                                      return Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: getColors(context).surface,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(9)),
                                            border: Border.all(
                                              color: dataPagerController
                                                          .selectedPageIndex
                                                          .toString() ==
                                                      value
                                                  ? getColors(context).primary
                                                  : getColors(context)
                                                      .onSurface,
                                            )),
                                        alignment: Alignment.center,
                                        child: getChild(value),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ),
                FinancialAppBar(noPop: widget.sellerId == null),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: store.selectMonth ? 2 : 0 + 0.001,
                    sigmaY: store.selectMonth ? 2 : 0 + 0.001,
                  ),
                  child: AnimatedOpacity(
                    opacity: store.selectMonth ? .6 : 0,
                    duration: Duration(milliseconds: 600),
                    child: GestureDetector(
                      onTap: () => store.setSelectMonth(false),
                      child: Container(
                        height: store.selectMonth ? maxHeight(context) : 0,
                        width: store.selectMonth ? maxWidth(context) : 0,
                        color: getColors(context).onBackground,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: store.selectMonth,
                  child: Center(
                    child: Container(
                      height: wXD(329, context),
                      width: wXD(339, context),
                      decoration: BoxDecoration(
                        color: getColors(context).surface,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: wXD(107, context),
                            width: wXD(339, context),
                            decoration: BoxDecoration(
                              color: getColors(context).primary,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(3)),
                            ),
                            padding: EdgeInsets.fromLTRB(
                              wXD(38, context),
                              wXD(14, context),
                              wXD(47, context),
                              wXD(23, context),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'abr de 2021',
                                  style: textFamily(
                                    context,
                                    color: getColors(context).surface,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '2021',
                                      style: textFamily(
                                        context,
                                        color: getColors(context).surface,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 38,
                                      ),
                                    ),
                                    Spacer(flex: 4),
                                    Transform.rotate(
                                      angle: math.pi * 1.5,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: getColors(context).surface,
                                        size: wXD(17, context),
                                      ),
                                    ),
                                    Spacer(),
                                    Transform.rotate(
                                      angle: math.pi / 2,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: getColors(context)
                                            .surface
                                            .withOpacity(.5),
                                        size: wXD(17, context),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: wXD(30, context),
                              right: wXD(30, context),
                              top: wXD(10, context),
                            ),
                            child: Observer(
                              builder: (context) {
                                return Wrap(
                                  spacing: wXD(5, context),
                                  children: List.generate(
                                    months.length,
                                    (index) => Month(
                                      onTap: () {
                                        print('index: $index');
                                        print(
                                            'MonthNow: ${DateTime.now().month}');
                                        store.setMonthSelected(index);
                                      },
                                      title: months[index],
                                      selected: index == store.monthSelected,
                                      month: index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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

  Widget getChild(String val) {
    switch (val) {
      case "First":
        return Icon(
          Icons.first_page_rounded,
          color: getColors(context).onSurface,
          size: wXD(20, context),
        );
      case "Previous":
        return Icon(
          Icons.arrow_back_ios_new_rounded,
          color: getColors(context).onSurface,
          size: wXD(20, context),
        );
      case "Last":
        return Icon(
          Icons.last_page_rounded,
          color: getColors(context).onSurface,
          size: wXD(20, context),
        );
      case "Next":
        return Icon(
          Icons.arrow_forward_ios_rounded,
          color: getColors(context).onSurface,
          size: wXD(20, context),
        );

      default:
        return Text(
          val,
          style: textFamily(
            context,
            fontSize: 16,
            color: dataPagerController.selectedPageIndex == val
                ? getColors(context).primary
                : getColors(context).onSurface,
          ),
        );
    }
  }
}

class Month extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final bool selected;
  final int month;
  Month(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.selected,
      required this.month})
      : super(key: key);
  final FinancialStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    bool monthBefore = DateTime.now().month < month;
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: wXD(4, context)),
        height: wXD(65, context),
        width: wXD(65, context),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? getColors(context).primary : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: textFamily(
            context,
            fontSize: 17,
            color: selected
                ? getColors(context).surface
                : monthBefore
                    ? getColors(context).onBackground.withOpacity(.5)
                    : getColors(context).onBackground,
          ),
        ),
      ),
    );
  }
}

class PeriodicTransfer extends StatelessWidget {
  final bool first;
  PeriodicTransfer({this.first = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(77, context),
      width: maxWidth(context),
      padding: EdgeInsets.fromLTRB(
        wXD(16, context),
        0,
        wXD(12, context),
        wXD(3, context),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Icon(
                first ? Icons.edit : Icons.check_circle_outline,
                size: wXD(15, context),
                color: first
                    ? getColors(context).onSurface.withOpacity(.3)
                    : green,
              ),
              Container(
                width: wXD(1, context),
                height: wXD(58, context),
                color: getColors(context).onSurface.withOpacity(.3),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: wXD(3, context)),
            width: wXD(300, context),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Em aberto',
                      style: textFamily(
                        context,
                        fontSize: 13,
                        color: getColors(context).onBackground,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '19/04 a 24/04',
                      style: textFamily(context,
                          fontSize: 13,
                          color:
                              getColors(context).onBackground.withOpacity(.5)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'R\$ 4.000,00',
                      style: textFamily(
                        context,
                        fontSize: 13,
                        color: getColors(context).onBackground,
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'R\$ 2.000,00',
                      style: textFamily(
                        context,
                        fontSize: 13,
                        height: 1.3,
                        color: getColors(context).onBackground.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total de vendas',
                      style: textFamily(
                        context,
                        fontSize: 10,
                        color: getColors(context).onBackground.withOpacity(.5),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Total do repasse',
                      style: textFamily(context,
                          fontSize: 10,
                          color:
                              getColors(context).onBackground.withOpacity(.5)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: wXD(23, context)),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: wXD(20, context),
              color: getColors(context).primary,
            ),
          )
        ],
      ),
    );
  }
}

class FinancialStatement extends StatefulWidget {
  const FinancialStatement({Key? key}) : super(key: key);

  @override
  _FinancialStatementState createState() => _FinancialStatementState();
}

class _FinancialStatementState extends State<FinancialStatement> {
  bool flutuant = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // flutuant = !flutuant;
        // setState(() {});
      },
      child: Container(
        height: wXD(173, context),
        width: wXD(239, context),
        margin: EdgeInsets.only(
          top: wXD(30, context),
          bottom: wXD(18, context),
          right: wXD(12, context),
          left: wXD(12, context),
        ),
        decoration: BoxDecoration(
          color: getColors(context).surface,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          border: Border.all(color: Color(0xfff1f1f1)),
        ),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: wXD(52, context),
                width: wXD(239, context),
                padding: EdgeInsets.only(
                    top: wXD(8, context), bottom: wXD(12, context)),
                decoration: BoxDecoration(
                  color: getColors(context).primary.withOpacity(.12),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mês em aberto',
                      style: textFamily(context,
                          fontSize: 12, color: getColors(context).onBackground),
                    ),
                    Text(
                      'Vendas 01/04 a 30/04',
                      style: textFamily(context,
                          fontSize: 10, color: getColors(context).onSurface),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                'Balanço Geral',
                style: textFamily(context,
                    fontSize: 10, color: getColors(context).onSurface),
              ),
              Spacer(),
              Text(
                'R\$ 7.768,15',
                style: textFamily(context,
                    fontSize: 20, color: getColors(context).primary),
              ),
              Spacer(),
              Container(
                width: wXD(239, context),
                height: wXD(1, context),
                color: getColors(context).onBackground.withOpacity(.2),
              ),
              Spacer(),
              Text(
                'Ver detalhes',
                style: textFamily(context,
                    fontSize: 12, color: getColors(context).error),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
