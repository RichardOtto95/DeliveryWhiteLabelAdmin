import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../core/models/time_model.dart';
import '../../../core/models/transaction_model.dart';
import '../../../shared/utilities.dart';

class FinancialDataSource extends DataGridSource {
  FinancialDataSource(List<TransactionM> transactions) {
    _transactions = transactions
        .map<DataGridRow>((trans) => DataGridRow(cells: [
              DataGridCell<String>(columnName: "id", value: trans.id),
              DataGridCell<String>(
                  columnName: "origin", value: trans.customerId),
              DataGridCell<String>(
                  columnName: "destiny", value: trans.sellerId),
              DataGridCell<String>(columnName: "orderId", value: trans.orderId),
              DataGridCell<double>(columnName: "value", value: trans.value),
              DataGridCell<dynamic>(columnName: "date", value: trans.createdAt),
              DataGridCell<String>(columnName: "status", value: trans.status),
              DataGridCell<String>(
                  columnName: "paymentMethod", value: trans.paymentMethod),
              DataGridCell<String>(
                  columnName: "paymentIntent", value: trans.paymentIntent),
              DataGridCell<TransactionM>(columnName: "actions", value: trans),
            ]))
        .toList();
  }

  List<DataGridRow> _transactions = [];

  @override
  List<DataGridRow> get rows => _transactions;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cellData) {
      late String finalVal;

      switch (cellData.columnName) {
        case "date":
          Timestamp timestamp = cellData.value;
          finalVal = Time(timestamp.toDate()).dayDate();
          break;
        case "value":
          finalVal = "R\$   " + cellData.value.toStringAsFixed(2);
          break;
        case "actions":
          finalVal = "";
          break;
        default:
          finalVal = cellData.value ?? "---";
          break;
      }

      return Builder(
        builder: (context) {
          if (cellData.columnName == "actions") {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: getColors(context).onSurface,
                    size: wXD(20, context),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: getColors(context).onSurface,
                    size: wXD(20, context),
                  ),
                ),
              ],
            );
          }
          return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: wXD(10, context)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SelectableText(
                  traduce(finalVal),
                  style: textFamily(
                    context,
                    fontSize: 15,
                    color: getColors(context).onSurface,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }).toList());
  }
}
