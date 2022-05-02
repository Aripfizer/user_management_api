import 'package:flutter/material.dart';
import 'package:user_management_api/UpdateScreen.dart';
import 'package:user_management_api/register.dart';
import 'package:user_management_api/user.dart';
import 'package:user_management_api/userListScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = User(
      id: null, // creer une methode qui verifie si le nombre generer existe deja dans la database
      firstname: "Rock", // exist
      lastname : "Lee",// exist
      adress : "Cotonou",// exist
      phone : "229464836378",// exist
      gender : "M",// exist
      picture : null,// not exist
      citation : "force force force",// exist
    );


    return MaterialApp(
      title: 'Flutter User App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:  UserListScreen(),
    );
  }
}