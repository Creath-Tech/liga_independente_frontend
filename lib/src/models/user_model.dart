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

  UserModel(
      {this.userId,
      this.imageUrl,
      this.name,
      this.email,
      this.bio = 'Amo jogar volei e futebol.',
      this.sports = const ['Vôlei', 'futebol', 'handebol', 'natação', 'basquete', 'golfe'],
      this.contacts = const {
        'whatsapp' : '',
        'facebook' : 'https://facebook.com/user1',
        'instagram' : 'https://instagram.com/user1'
      }
  });


  UserModel.fromJson(json) {
    userId = json['userId'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    email = json['email'];
    bio = json['password'];
    sports = json['phone'];
    contacts = json['adress'];
    createdAt = json['createdAt'].toDate();
    updatedAt = json['updatedAt'].toDate();
  }

  toJson() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'name': name,
      'email': email,
      'bio': bio,
      'sports': sports,
      'contacts': contacts,
      'createdAt' : createdAt,
      'upadatedAt' : updatedAt
    };
  }
}
