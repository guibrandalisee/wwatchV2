import 'dart:convert';

enum AvatarType { tmdb, gravatar }

class Guest {
  String guestSessionID;
  String expiresAt;
  Guest({required this.guestSessionID, required this.expiresAt});
}

class User {
  User({
    this.avatar,
    this.avatarType,
    required this.id,
    required this.includeAdult,
    required this.iso_3166_1,
    required this.iso_639_1,
    required this.name,
    required this.username,
  });
  String? avatar;
  AvatarType? avatarType;
  int id;
  String iso_639_1;
  String iso_3166_1;
  String name;
  bool includeAdult;
  String username;
}

class UserCustomList {
  String description;
  int favoriteCount;
  int id;
  int itemCount;
  String iso_6391_1;
  String listType;
  String name;
  String? posterPath;
  UserCustomList({
    required this.description,
    required this.favoriteCount,
    required this.id,
    required this.iso_6391_1,
    required this.itemCount,
    required this.listType,
    required this.name,
    required this.posterPath,
  });
}

class RequestToken {
  String expiresAt;
  String token;
  bool authenticated;
  RequestToken({
    required this.expiresAt,
    required this.token,
    this.authenticated = false,
  });
}
