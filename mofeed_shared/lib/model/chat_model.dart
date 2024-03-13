import 'package:food_court/model/order_model.dart';
import 'package:mofeed_shared/model/message_model.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class ChatModel {
  final bool read;

  final String recieverId;
  final String lastMessage;
  final DateTime sentAt;
  final MessageStatusEnum status;
  final String image;
  final String lastMessageSender;
  final String username;

  const ChatModel({
    this.read = false,
    required this.recieverId,
    required this.lastMessage,
    required this.image,
    required this.username,
    this.status = MessageStatusEnum.sent,
    required this.sentAt,
    required this.lastMessageSender,
  });

  factory ChatModel.fromMap(MapJson map) {
    return ChatModel(
      read: map['read'] ?? true,
      lastMessageSender: map['lastMessageSender'].toString().trim() ?? "",
      status: map['status'].toString().toMessageStatus,
      sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt']),
      recieverId: map['recieverId'] ?? map['id'] ?? "",
      lastMessage: map['lastMessage'] ?? "",
      image: map['image'] ?? "",
      username: map['username'] ?? "",
    );
  }

  MapJson toMap() {
    return {
      "read": read,
      "recieverId": recieverId,
      "lastMessage": lastMessage.trim(),
      "sentAt": sentAt.millisecondsSinceEpoch,
      "image": image,
      "username": username,
      "status": status.name,
      "lastMessageSender": lastMessageSender,
    };
  }

  ChatModel copyWith({
    String? lastMessage,
    String? image,
    String? username,
    DateTime? sentAt,
    String? recieverId,
    String? lastMessageSender,
    bool? read,
  }) {
    return ChatModel(
      read: read ?? this.read,
      lastMessageSender: lastMessageSender ?? this.lastMessageSender,
      sentAt: sentAt ?? this.sentAt,
      recieverId: recieverId ?? this.recieverId,
      lastMessage: lastMessage?.trim() ?? this.lastMessage.trim(),
      image: image ?? this.image,
      username: username ?? this.username,
    );
  }
}
