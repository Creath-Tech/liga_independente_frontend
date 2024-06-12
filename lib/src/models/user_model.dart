class UserModel {
  String? userId;
  String? name;
  String? email;
  String? bio;
  List<String>? sports;
  Map<String, dynamic>? contacts;

  UserModel(
      {this.userId,
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

}
