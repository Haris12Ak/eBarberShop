// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDetail _$PaymentDetailFromJson(Map<String, dynamic> json) =>
    PaymentDetail(
      json['transactionId'] as String,
      json['paymentMethod'] as String,
      json['payerId'] as String,
      json['payerFirstName'] as String,
      json['payerLastName'] as String,
      json['recipientName'] as String,
      json['recipientAddress'] as String,
      json['recipientCity'] as String,
      json['recipientState'] as String,
      json['recipientPostalCode'] as int,
      json['recipientCountryCode'] as String,
      (json['total'] as num).toDouble(),
      json['currency'] as String,
      (json['subtotal'] as num).toDouble(),
      (json['shippingDiscount'] as num).toDouble(),
      json['message'] as String,
      DateTime.parse(json['createTime'] as String),
    );

Map<String, dynamic> _$PaymentDetailToJson(PaymentDetail instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'paymentMethod': instance.paymentMethod,
      'payerId': instance.payerId,
      'payerFirstName': instance.payerFirstName,
      'payerLastName': instance.payerLastName,
      'recipientName': instance.recipientName,
      'recipientAddress': instance.recipientAddress,
      'recipientCity': instance.recipientCity,
      'recipientState': instance.recipientState,
      'recipientPostalCode': instance.recipientPostalCode,
      'recipientCountryCode': instance.recipientCountryCode,
      'total': instance.total,
      'currency': instance.currency,
      'subtotal': instance.subtotal,
      'shippingDiscount': instance.shippingDiscount,
      'message': instance.message,
      'createTime': instance.createTime.toIso8601String(),
    };
