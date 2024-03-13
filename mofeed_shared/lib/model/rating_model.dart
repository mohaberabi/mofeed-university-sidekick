class RatingModel {
  final int value;

  final String text;

  final String id;
  final DateTime createdAt;
  final String uid;

  final String username;

  const RatingModel({
    required this.value,
    required this.text,
    required this.id,
    required this.createdAt,
    required this.uid,
    required this.username,
  });

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      value: map['value'],
      text: map['text'],
      id: map['id'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      uid: map['uid'],
      username: map['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'text': text,
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'username': username,
      'uid': uid
    };
  }
}
