class EchoModel {
  final DateTime createdAt;
  final String uniId;
  final String id;
  final String username;
  final bool allowChat;
  final int replies;
  final String uid;
  final String echo;
  final String userImage;
  final bool isReply;

  const EchoModel({
    required this.createdAt,
    required this.uniId,
    required this.id,
    required this.echo,
    required this.username,
    required this.uid,
    this.allowChat = false,
    this.replies = 0,
    required this.userImage,
    this.isReply = false,
  });

  factory EchoModel.fromJson(Map<String, dynamic> json) {
    return EchoModel(
        isReply: json['isReply'] ?? false,
        userImage: json['userImage'] ?? '',
        replies: json['replies'] ?? 0,
        uid: json['uid'] ?? '',
        allowChat: json['allowChat'] ?? false,
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        uniId: json['uniId'],
        id: json['id'],
        username: json['username'],
        echo: json['echo']);
  }

  Map<String, dynamic> toMap() {
    return {
      'userImage': userImage,
      'echo': echo.trim(),
      'username': username,
      'id': id,
      'uniId': uniId,
      'allowChat': allowChat,
      'uid': uid,
      'replies': replies,
      'isReply': isReply,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  EchoModel copyWith({
    DateTime? createdAt,
    String? uniId,
    String? id,
    String? username,
    String? echo,
    List<dynamic>? images,
    bool? allowChat,
    String? uid,
    int? replies,
    String? userImage,
    bool? isReply,
  }) {
    return EchoModel(
      isReply: isReply ?? this.isReply,
      userImage: userImage ?? this.userImage,
      replies: replies ?? this.replies,
      uid: uid ?? this.uid,
      allowChat: allowChat ?? this.allowChat,
      createdAt: createdAt ?? this.createdAt,
      uniId: uniId ?? this.uniId,
      id: id ?? this.id,
      username: username ?? this.username,
      echo: echo ?? this.echo,
    );
  }
}
