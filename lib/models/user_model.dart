class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profileImageUrl;
  final String phoneNumber;
  final List<String> studentId; 

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.phoneNumber,
    this.studentId = const [], 
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      studentId: (map['studentId'] as List<dynamic>?)
              ?.map((id) => id.toString())
              .toList() ??
          [],
    );
  }
}
