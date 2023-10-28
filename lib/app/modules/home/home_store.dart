import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_admin_white_label/app/modules/main/main_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final MainStore mainStore = Modular.get();

  @observable
  int value = 0;
  @observable
  DateTime? startDate;
  @observable
  bool removeOverlay = false;
  @observable
  OverlayEntry? filterOverlay;
  @observable
  int filterIndex = 0;
  @observable
  DateTime? endDate;
  @observable
  int previousFilterIndex = 0;
  @observable
  Timestamp? startTimestamp;
  @observable
  Timestamp? endTimestamp;
  @observable
  bool filterBool = false;
  @observable
  DateTime nowDate = DateTime.now();
  @observable
  DateTime yesterdayDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);
  @observable
  OverlayEntry? userMenu;

  @action
  bool filterisNotNull() => filterOverlay != null;

  @action
  insertOverlay(context, OverlayEntry _overlay) {
    filterOverlay = _overlay;
    Overlay.of(context)!.insert(filterOverlay!);
  }

  @action
  void filter() {
    if (startDate != null) {
      startTimestamp = Timestamp.fromDate(startDate!);
    }
    if (endDate != null) {
      endTimestamp = Timestamp.fromDate(endDate!);
    }
    previousFilterIndex = filterIndex;
  }

  @action
  Future<Map> getConcludedOrders(String agentId) async {
    if (startTimestamp == null && endTimestamp == null) {
      startTimestamp = Timestamp.fromDate(
          DateTime(nowDate.year, nowDate.month, nowDate.day, 0, 0, 0));
      endTimestamp = Timestamp.fromDate(
          DateTime(nowDate.year, nowDate.month, nowDate.day, 23, 59, 59));
    }
    QuerySnapshot orders = await FirebaseFirestore.instance
        .collection('agents')
        .doc(agentId)
        .collection('orders')
        .where('created_at', isGreaterThanOrEqualTo: startTimestamp)
        .where('created_at', isLessThanOrEqualTo: endTimestamp)
        .where('status', isEqualTo: "CONCLUDED")
        .orderBy('created_at', descending: true)
        .get();

    num totalGain = 0;
    for (var i = 0; i < orders.docs.length; i++) {
      DocumentSnapshot orderDoc = orders.docs[i];
      totalGain += orderDoc['price_rate_delivery'];
    }
    return {
      'query': orders,
      'total_gain': totalGain,
    };
  }

  @action
  Future<num> getTotalAmount(String sellerId) async {
    // QuerySnapshot ordersQuery = await FirebaseFirestore.instance.collection('orders').where('status', isEqualTo: "CONCLUDED").get();
    DocumentSnapshot sellerDoc = await FirebaseFirestore.instance
        .collection('sellers')
        .doc(sellerId)
        .get();

    mainStore.sellerOn = sellerDoc['online'];

    QuerySnapshot ordersQuery = await sellerDoc.reference
        .collection('orders')
        .where('status', isEqualTo: "CONCLUDED")
        .get();
    num totalAmount = 0;
    if (ordersQuery.docs.isNotEmpty) {
      for (var i = 0; i < ordersQuery.docs.length; i++) {
        DocumentSnapshot orderDoc = ordersQuery.docs[i];
        totalAmount += orderDoc['price_total_with_discount'];
      }
    }

    // print('totalAmount: $totalAmount');

    return totalAmount;
  }

  @action
  void filterAltered(int index) {
    filterIndex = index;
    List monthsWith30days = [
      4,
      6,
      9,
      11,
    ];
    List monthsWith31days = [
      1,
      3,
      5,
      7,
      8,
      10,
      12,
    ];
    switch (index) {
      case 0:
        startDate = DateTime(nowDate.year, nowDate.month, nowDate.day, 0, 0, 0);
        endDate =
            DateTime(nowDate.year, nowDate.month, nowDate.day, 23, 59, 59);
        break;

      case 1:
        startDate =
            DateTime(nowDate.year, nowDate.month, nowDate.day - 1, 0, 0, 0);
        endDate =
            DateTime(nowDate.year, nowDate.month, nowDate.day - 1, 23, 59, 59);
        break;

      case 2:
        print('nowDate.month: ${nowDate.month}');
        if (nowDate.month == 2) {
          startDate = DateTime(nowDate.year, nowDate.month, 1, 0, 0, 0);
          endDate = DateTime(nowDate.year, nowDate.month, 14, 23, 59, 59);
        }

        if (monthsWith30days.contains(nowDate.month)) {
          startDate = DateTime(nowDate.year, nowDate.month, 1, 0, 0, 0);
          endDate = DateTime(nowDate.year, nowDate.month, 15, 23, 59, 59);
        }

        if (monthsWith31days.contains(nowDate.month)) {
          startDate = DateTime(nowDate.year, nowDate.month, 1, 0, 0, 0);
          endDate = DateTime(nowDate.year, nowDate.month, 16, 12, 00, 00);
        }
        break;

      case 3:
        print('nowDate.month: ${nowDate.month}');
        if (nowDate.month == 2) {
          startDate = DateTime(nowDate.year, nowDate.month, 15, 0, 0, 0);
          endDate = DateTime(nowDate.year, nowDate.month, 28, 23, 59, 59);
        }

        if (monthsWith30days.contains(nowDate.month)) {
          startDate = DateTime(nowDate.year, nowDate.month, 16, 0, 0, 0);
          endDate = DateTime(nowDate.year, nowDate.month, 30, 23, 59, 59);
        }

        if (monthsWith31days.contains(nowDate.month)) {
          startDate = DateTime(nowDate.year, nowDate.month, 16, 12, 0, 0);
          endDate = DateTime(nowDate.year, nowDate.month, 31, 23, 59, 59);
        }
        break;

      case 4:
        int previousMonth = nowDate.month - 1;
        if (previousMonth == 0) {
          previousMonth = 12;
        }
        print('previousMonth: $previousMonth');
        if (previousMonth == 2) {
          startDate = DateTime(nowDate.year, previousMonth, 1, 0, 0, 0);
          endDate = DateTime(nowDate.year, previousMonth, 28, 23, 59, 59);
        }

        if (monthsWith30days.contains(previousMonth)) {
          startDate = DateTime(nowDate.year, previousMonth, 1, 0, 0, 0);
          endDate = DateTime(nowDate.year, previousMonth, 30, 23, 59, 59);
        }

        if (monthsWith31days.contains(previousMonth)) {
          startDate = DateTime(nowDate.year, previousMonth, 1, 0, 0, 0);
          endDate = DateTime(nowDate.year, previousMonth, 31, 23, 59, 59);
        }
        break;

      default:
        break;
    }
  }

  @action
  Future<List<Map<String, dynamic>>> getStatistics(int index, sellerId) async {
    Timestamp? _start;
    Timestamp? _end;
    num totalAmount = 0;
    double rating = 0;
    List monthsWith30days = [
      4,
      6,
      9,
      11,
    ];
    List monthsWith31days = [
      1,
      3,
      5,
      7,
      8,
      10,
      12,
    ];

    if (index == 0) {
      DateTime startDate =
          DateTime(nowDate.year, nowDate.month, nowDate.day, 0, 0, 0);
      DateTime endDate =
          DateTime(nowDate.year, nowDate.month, nowDate.day, 23, 59, 59);
      _start = Timestamp.fromDate(startDate);
      _end = Timestamp.fromDate(endDate);
    }

    if (index == 1) {
      print('nowDate.weekday: ${nowDate.weekday}');
      print('nowDate.weekday -1: ${nowDate.weekday - 1}');
      print('7 - nowDate.weekday: ${7 - nowDate.weekday}');
      DateTime startDate =
          nowDate.subtract(Duration(days: nowDate.weekday - 1));
      DateTime endDate = nowDate.add(Duration(days: 7 - nowDate.weekday));
      print(
          'weekDayFirst: ${startDate.year} / ${startDate.month} / ${startDate.day}');
      print(
          'weekDayFirst: ${endDate.year} / ${endDate.month} / ${endDate.day}');
      _start = Timestamp.fromDate(startDate);
      _end = Timestamp.fromDate(endDate);
    }

    if (index == 2) {
      print('nowDate.month: ${nowDate.month}');
      if (nowDate.month == 2) {
        DateTime startDate = DateTime(nowDate.year, nowDate.month, 1, 0, 0, 0);
        DateTime endDate =
            DateTime(nowDate.year, nowDate.month, 28, 23, 59, 59);
        _start = Timestamp.fromDate(startDate);
        _end = Timestamp.fromDate(endDate);
      }

      if (monthsWith30days.contains(nowDate.month)) {
        DateTime startDate = DateTime(nowDate.year, nowDate.month, 1, 0, 0, 0);
        DateTime endDate =
            DateTime(nowDate.year, nowDate.month, 30, 23, 59, 59);
        _start = Timestamp.fromDate(startDate);
        _end = Timestamp.fromDate(endDate);
      }

      if (monthsWith31days.contains(nowDate.month)) {
        DateTime startDate = DateTime(nowDate.year, nowDate.month, 1, 0, 0, 0);
        DateTime endDate =
            DateTime(nowDate.year, nowDate.month, 31, 12, 00, 00);
        _start = Timestamp.fromDate(startDate);
        _end = Timestamp.fromDate(endDate);
      }
    }

    QuerySnapshot ordersQuery = await FirebaseFirestore.instance
        .collection('sellers')
        .doc(sellerId)
        .collection('orders')
        .where('created_at', isGreaterThanOrEqualTo: _start)
        .where('created_at', isLessThanOrEqualTo: _end)
        .get();

    QuerySnapshot concludedOrdersQuery = await FirebaseFirestore.instance
        .collection('sellers')
        .doc(sellerId)
        .collection('orders')
        .where('created_at', isGreaterThanOrEqualTo: _start)
        .where('created_at', isLessThanOrEqualTo: _end)
        .where('status', isEqualTo: "CONCLUDED")
        .get();

    QuerySnapshot ratingsQuery = await FirebaseFirestore.instance
        .collection('sellers')
        .doc(sellerId)
        .collection('ratings')
        .where('created_at', isGreaterThanOrEqualTo: _start)
        .where('created_at', isLessThanOrEqualTo: _end)
        .where('status', isEqualTo: "VISIBLE")
        .get();

    if (concludedOrdersQuery.docs.isNotEmpty) {
      for (var i = 0; i < concludedOrdersQuery.docs.length; i++) {
        DocumentSnapshot orderDoc = concludedOrdersQuery.docs[i];
        totalAmount += orderDoc['price_total_with_discount'];
      }
    }

    if (ratingsQuery.docs.isNotEmpty) {
      for (var i = 0; i < ratingsQuery.docs.length; i++) {
        DocumentSnapshot ratingDoc = ratingsQuery.docs[i];
        rating += ratingDoc['rating'];
      }
      rating = rating / ratingsQuery.docs.length;
    }

    // print('totalAmount: $totalAmount');

    return [
      {
        "ordersLength": ordersQuery.docs.length,
        "isGreaterThan": 3,
        "valid": ordersQuery.docs.length > 3,
      },
      {
        "totalAmount": totalAmount,
        "isGreaterThan": 100,
        "valid": totalAmount > 100,
      },
      {
        "ratings": rating,
        "isGreaterThan": 4,
        "valid": rating > 4,
      },
    ];
  }
}
