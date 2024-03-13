import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/user_model.dart';
import 'package:mofeed_shared/utils/enums/user_prefs.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class ClientUser extends UserModel with EquatableMixin {
  final Pet pet;

  final Smoking smoking;

  final String bio;

  final String image;

  final Gender gender;

  final Religion religion;

  static const ClientUser anonymus = ClientUser(
      name: '',
      phone: '',
      online: false,
      verified: false,
      uId: '',
      lastname: '',
      token: '',
      uniId: '',
      email: '');

  const ClientUser({
    required String name,
    required String phone,
    required String uId,
    required String lastname,
    bool online = true,
    required String token,
    String local = 'en',
    required String uniId,
    required String email,
    bool verified = false,
    this.religion = Religion.na,
    this.smoking = Smoking.nonSmoker,
    this.gender = Gender.na,
    this.pet = Pet.na,
    this.image = '',
    this.bio = '',
  }) : super(
          name: name,
          phone: phone,
          type: UserType.client,
          uId: uId,
          lastname: lastname,
          online: online,
          token: token,
          local: local,
          uniId: uniId,
          email: email,
          verified: verified,
        );

  factory ClientUser.fromMap(MapJson map) {
    return ClientUser(
      name: map['name'],
      phone: map['phone'],
      image: map['image'],
      uId: map['uId'],
      lastname: map['lastname'],
      online: map['online'],
      token: map['token'] ?? "",
      local: map['local'] ?? 'en',
      uniId: map['uniId'],
      email: map['email'],
      bio: map['bio'] ?? "",
      verified: map['verified'] ?? true,
      pet: map['pet'].toString().toPet,
      gender: map['gender'].toString().toGender,
      smoking: map['smoking'].toString().toSmoking,
      religion: map['religion'].toString().toReligion,
    );
  }

  @override
  MapJson toMap() {
    return {
      'pet': pet.name,
      'gender': gender.name,
      'smoking': smoking.name,
      'religion': religion.name,
      'type': type.name,
      'name': name,
      'phone': phone,
      'uId': uId,
      'lastname': lastname,
      'online': online,
      'token': token,
      'local': local,
      'uniId': uniId,
      'email': email,
      'verified': verified,
      'image': image,
      'bio': bio
    };
  }

  ClientUser copyWith({
    String? name,
    String? phone,
    String? uId,
    String? lastname,
    bool? online,
    String? token,
    String? local,
    String? uniId,
    String? email,
    bool? verified,
    Pet? pet,
    String? bio,
    Smoking? smoking,
    Gender? gender,
    Religion? religion,
    String? image,
  }) {
    return ClientUser(
      pet: pet ?? this.pet,
      religion: religion ?? this.religion,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      smoking: smoking ?? this.smoking,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      uId: uId ?? this.uId,
      lastname: lastname ?? this.lastname,
      token: token ?? this.token,
      local: local ?? this.local,
      uniId: uniId ?? this.uniId,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  String get userName => "$name $lastname";

  bool get completedProfile =>
      [
        name,
        lastname,
        email,
        image,
      ].every((element) => element.isNotEmpty) &&
      pet != Pet.na &&
      gender != Gender.na;

  @override
  List<Object?> get props => [
        name,
        phone,
        image,
        uId,
        lastname,
        online,
        token,
        local,
        uniId,
        bio,
        email,
        verified,
        gender,
        pet,
        smoking,
        religion,
      ];
}
