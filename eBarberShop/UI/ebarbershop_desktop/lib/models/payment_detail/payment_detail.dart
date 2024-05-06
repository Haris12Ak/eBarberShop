import 'package:json_annotation/json_annotation.dart';

part 'payment_detail.g.dart';

@JsonSerializable()
class PaymentDetail {
  String transactionId;
  String paymentMethod;
  String payerId;
  String payerFirstName;
  String payerLastName;
  String recipientName;
  String recipientAddress;
  String recipientCity;
  String recipientState;
  int recipientPostalCode;
  String recipientCountryCode;
  double total;
  String currency;
  double subtotal;
  double shippingDiscount;
  String message;
  DateTime createTime;

  PaymentDetail(
      this.transactionId,
      this.paymentMethod,
      this.payerId,
      this.payerFirstName,
      this.payerLastName,
      this.recipientName,
      this.recipientAddress,
      this.recipientCity,
      this.recipientState,
      this.recipientPostalCode,
      this.recipientCountryCode,
      this.total,
      this.currency,
      this.subtotal,
      this.shippingDiscount,
      this.message,
      this.createTime);

  factory PaymentDetail.fromJson(Map<String, dynamic> json) =>
      _$PaymentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDetailToJson(this);
}
