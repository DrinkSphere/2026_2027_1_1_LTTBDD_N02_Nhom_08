class CommentModel {
  final String id;
  final String drinkId;
  final String drinkName;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String content;
  final double rating;
  final bool isApproved;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.drinkId,
    required this.drinkName,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.content,
    this.rating = 5.0,
    this.isApproved = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  CommentModel copyWith({
    String? id,
    String? drinkId,
    String? drinkName,
    String? userId,
    String? userName,
    String? userAvatar,
    String? content,
    double? rating,
    bool? isApproved,
    DateTime? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      drinkId: drinkId ?? this.drinkId,
      drinkName: drinkName ?? this.drinkName,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      isApproved: isApproved ?? this.isApproved,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'drinkId': drinkId,
      'drinkName': drinkName,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'content': content,
      'rating': rating,
      'isApproved': isApproved,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      drinkId: json['drinkId'] as String? ?? '',
      drinkName: json['drinkName'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? 'Người dùng',
      userAvatar: json['userAvatar'] as String?,
      content: json['content'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      isApproved: json['isApproved'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

