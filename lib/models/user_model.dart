class UserModel {
  final String id;
  final String userName;
  final String profile;
  final String? dateOfBirth;
  final String? gender;

  UserModel({
    required this.id,
    required this.userName,
    required this.profile,
    this.dateOfBirth,
    this.gender,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      id: uid,
      userName: map['userName'] ?? '',
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'], profile: map['profile'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'profile': profile,
    };
  }
}