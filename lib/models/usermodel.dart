class UserModel {
  final String name;
  final String username;
  final String about;
  // final String profilePhoto;
  final List<String> followers;
  final List<String> following;

  const UserModel({
    required this.name,
    required this.username,
    required this.about,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'usrename': username,
        'about': about,
        'followers': followers,
        'following': following
      };
}
