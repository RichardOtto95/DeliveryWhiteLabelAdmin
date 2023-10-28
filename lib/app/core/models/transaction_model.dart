import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionM {
  final dynamic createdAt;
  final String customerId;
  final String id;
  final String orderId;
  final String? paymentIntent;
  final String paymentMethod;
  final String sellerId;
  final String status;
  final dynamic updatedAt;
  final double value;

  TransactionM({
    this.createdAt,
    this.updatedAt,
    required this.customerId,
    required this.id,
    required this.orderId,
    this.paymentIntent,
    required this.paymentMethod,
    required this.sellerId,
    required this.status,
    required this.value,
  });

  factory TransactionM.fromDoc(DocumentSnapshot doc) {
    // print("TransactionId: ${doc.id}");
    return TransactionM(
      createdAt: doc["created_at"],
      customerId: doc["customer_id"],
      id: doc["id"],
      orderId: doc["order_id"],
      paymentIntent: doc["payment_intent"],
      paymentMethod: doc["payment_method"],
      sellerId: doc["seller_id"],
      status: doc["status"],
      updatedAt: doc["updated_at"],
      value: doc["value"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "created_at": this.createdAt,
        "customer_id": this.customerId,
        "id": this.id,
        "order_id": this.orderId,
        "payment_intent": this.paymentIntent,
        "payment_method": this.paymentMethod,
        "seller_id": this.sellerId,
        "status": this.status,
        "updated_at": this.updatedAt,
        "value": this.value,
      };
}
