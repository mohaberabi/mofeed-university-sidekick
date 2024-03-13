import 'dart:convert';

import '../utils/typdefs/typedefs.dart';

class MessageModel {
  final String message;

  final String sender;

  final String reciever;

  final DateTime issuedAt;

  final String id;
  final MessageStatusEnum status;

  const MessageModel({
    required this.id,
    required this.message,
    this.status = MessageStatusEnum.sending,
    required this.sender,
    required this.issuedAt,
    required this.reciever,
  });

  MapJson toMap() {
    return {
      "id": id,
      "message": message.trim(),
      "status": status.name,
      "sender": sender,
      "issuedAt": issuedAt.millisecondsSinceEpoch,
      "reciever": reciever,
    };
  }

  factory MessageModel.fromJson(String json) {
    final map = jsonDecode(json);
    return MessageModel.fromMap(map);
  }

  factory MessageModel.fromMap(MapJson map) {
    return MessageModel(
        id: map['id'],
        status: map['status'].toString().toMessageStatus,
        message: map['message'].toString().trim(),
        sender: map['sender'],
        issuedAt: DateTime.fromMillisecondsSinceEpoch(map['issuedAt']),
        reciever: map['reciever']);
  }

  MessageModel copyWith({
    String? message,
    String? sender,
    String? reciever,
    DateTime? issuedAt,
    String? id,
    MessageStatusEnum? status,
  }) {
    return MessageModel(
      message: message?.trim() ?? this.message.trim(),
      sender: sender ?? this.sender,
      reciever: reciever ?? this.reciever,
      issuedAt: issuedAt ?? this.issuedAt,
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }
}

enum MessageStatusEnum {
  sending,
  sent,
  recieved,
  seen;
}

extension MessageStatConvertor on String {
  MessageStatusEnum get toMessageStatus {
    switch (this) {
      case "seen":
        return MessageStatusEnum.seen;
      case "sent":
        return MessageStatusEnum.sent;
      case "recieved":
        return MessageStatusEnum.recieved;
      default:
        return MessageStatusEnum.sending;
    }
  }
}
