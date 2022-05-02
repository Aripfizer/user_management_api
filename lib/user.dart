import 'dart:convert';

List<User> postFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

class User {
    final String? id;
    final String firstname;
    final String lastname;
    final String adress;
    final String phone;
    final String gender;
    final String? picture;
    final String citation;

    User({required this.id, required this.firstname, required this.lastname, required this.adress,
      required this.phone, required this.gender, required this.picture, required this.citation});


    @override
  String toString() {
    return 'User{id: $id, firstname: $firstname, lastname: $lastname, adress: $adress, phone: $phone, gender: $gender, picture: $picture, citation: $citation}';
  }

  factory User.fromJson(Map<String, dynamic> json) {

      return  User(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        adress: json['adress'],
        phone: json['phone'],
        gender: json['gender'],
        picture: json['picture'],
        citation: json['citation'],
      );
    }




/*
  Map<String, dynamic> toMap() {
      return {
        'id': id,
        'isAsset' : isAsset,
        'firstname': firstname,
        'lastname': lastname,
        'birthday': birthday,
        'adress': adress,
        'phone': phone,
        'mail': mail,
        'gender': gender,
        'picture': picture,
        'citation': citation,
      };
    }

    factory User.fromMap(Map<String, dynamic> map) => User(
      map['id'],
      map['isAsset'],
      map['firstname'],
      map['lastname'],
      map['birthday'],
      map['adress'],
      map['phone'],
      map['mail'],
      map['gender'],
      map['picture'],
      map['citation'],
    );

 */


}