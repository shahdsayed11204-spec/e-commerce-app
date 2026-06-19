class ProfileModel {
  final String id;
  final String name;
  final String role;

  ProfileModel({
    required this.id,
    required this.name,
    required this.role,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final decoded = json['decoded'];

    return ProfileModel(
      id: decoded['id'] ?? '',
      name: decoded['name'] ?? '',
      role: decoded['role'] ?? '',
    );
  }
}