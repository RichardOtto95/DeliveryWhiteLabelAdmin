import 'package:flutter/material.dart';

class Cross extends StatelessWidget {
  final bool isColumn;
  final Row row;
  final Column column;

  const Cross({
    Key? key,
    this.isColumn = true,
    required this.row,
    required this.column,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isColumn) {
      return column;
    } else {
      return row;
    }
  }
}
