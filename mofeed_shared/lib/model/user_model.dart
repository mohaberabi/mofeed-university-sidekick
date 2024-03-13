import 'dart:convert';

import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

import '../utils/enums/user_prefs.dart';
import 'client_user_model.dart';

abstract class UserModel {
  final UserType type;
  final bool verified;
  final String name;
  final String phone;
  final String token;
  final String email;
  final String uId;
  final String lastname;
  final String local;
  final bool online;
  final String uniId;
  final bool blocked;

  const UserModel({
    required this.name,
    required this.phone,
    required this.uId,
    required this.lastname,
    required this.online,
    required this.token,
    required this.local,
    required this.uniId,
    required this.email,
    this.blocked = false,
    this.verified = false,
    required this.type,
  });

  factory UserModel.fromMap(MapJson map) {
    return ClientUser.fromMap(map);
  }

  String toJson() => jsonEncode(toMap());

  MapJson toMap();
}
