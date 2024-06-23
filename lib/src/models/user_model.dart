import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? imageUrl;
  String? name;
  String? email;
  String? bio;
  List<String>? sports;
  Map<String, dynamic>? contacts;

  Timestamp createdAt = Timestamp.now();
  Timestamp updatedAt = Timestamp.now();

  UserModel({
    this.userId,
    this.imageUrl,
    this.name,
    this.email,
    this.bio = '',
    this.sports = const [],
    this.contacts = const {},
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    email = json['email'];
    bio = json['bio'];
    sports = List<String>.from(json['sports'] ?? []);
    contacts = json['contacts'] ?? {};

    if (json['createdAt'] != null) {
      createdAt = json['createdAt'] as Timestamp;
    }
    if (json['updatedAt'] != null) {
      updatedAt = json['updatedAt'] as Timestamp;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'name': name,
      'email': email,
      'bio': bio,
      'sports': sports,
      'contacts': contacts,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
