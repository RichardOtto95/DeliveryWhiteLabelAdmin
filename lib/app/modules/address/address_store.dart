import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_admin_white_label/app/core/models/address_model.dart';
import 'package:delivery_admin_white_label/app/modules/main/main_store.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/load_circular_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:place_picker/place_picker.dart';

part 'address_store.g.dart';

class AddressStore = _AddressStoreBase with _$AddressStore;

abstract class _AddressStoreBase with Store {
  final MainStore mainStore = Modular.get();

  @observable
  LocationResult? locationResult;
  @observable
  OverlayEntry? editAddressOverlay;
  @observable
  bool hasAddress = false;
  @observable
  bool addressOverlay = false;
  @observable
  bool canBack = false;
  @observable
  BuildContext? addressPageContext;
  @observable
  User user = FirebaseAuth.instance.currentUser!;

  @action
  getLocationResult(_locationResult) => locationResult = _locationResult;
  @action
  getCanBack() => canBack;

  @action
  newAddress(Map<String, dynamic> addressMap, context, bool editing) async {
    canBack = false;
    print("addressMap: $addressMap");
    print("editing: $editing");
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(overlayEntry);
    String functionName = "newAddress";

    if (editing) {
      functionName = "editAddress";
    }
    print("$functionName");
    await cloudFunction(function: functionName, object: {
      "address": addressMap,
      "collection": "sellers",
      "userId": user.uid,
    });
    overlayEntry.remove();
    canBack = true;
  }

  @action
  setMainAddress(String addressId) async {
    print("setMainAddress");
    final addressQue = await FirebaseFirestore.instance
        .collection("sellers")
        .doc(user.uid)
        .collection("addresses")
        .get();

    for (var addressDoc in addressQue.docs) {
      if (addressDoc.get("main")) {
        await addressDoc.reference.update({"main": false});
      }
    }

    final selRef =
        FirebaseFirestore.instance.collection("sellers").doc(user.uid);

    await selRef.collection("addresses").doc(addressId).update({"main": true});

    await selRef.update({"main_address": addressId});
  }

  @action
  deleteAddress(context, Address address) async {
    canBack = false;

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(overlayEntry);

    DocumentSnapshot _user = await FirebaseFirestore.instance
        .collection("sellers")
        .doc(user.uid)
        .get();

    await _user.reference
        .collection("addresses")
        .doc(address.id)
        .update({"status": "DELETED", "main": false});

    if (_user.get("main_address") == address.id) {
      String? mainAddress = null;

      final activeAddresses = await _user.reference
          .collection("addresses")
          .where("status", isEqualTo: "ACTIVE")
          .orderBy("created_at", descending: true)
          .get();

      if (activeAddresses.docs.isNotEmpty) {
        await activeAddresses.docs.first.reference.update({"main": true});
        mainAddress = activeAddresses.docs.first.id;
      }

      await _user.reference.update({"main_address": mainAddress});
    }

    overlayEntry.remove();
    mainStore.globalOverlay!.remove();
    mainStore.globalOverlay = null;
    canBack = true;
  }
}
