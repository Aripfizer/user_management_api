import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_management_api/UpdateScreen.dart';
import 'package:http/http.dart' as http;
import 'package:user_management_api/user.dart';



class UserInfoScreen extends StatefulWidget {
  final String userid;
  const UserInfoScreen({Key? key, required this.userid}) : super(key: key);
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool isLoad = false;
  User? futureUser;

  @override
  void initState(){
    super.initState();
    fetchUser(widget.userid);
  }
  void fetchUser(String id) async {
    print("init u");
    print("https://ifri.raycash.net/getuser/$id");
    final response = await http
        .get(Uri.parse('https://ifri.raycash.net/getuser/$id'));

    if (response.statusCode == 200) {
      print("init bon");
      //final parsed = json.decode(response.body)['message'];
      User user = User.fromJson(jsonDecode(response.body)['message']);

      print("user : $user");
      setState(() {
        futureUser = user;
        isLoad = true;
      });
    } else
    {
      throw Exception('Failed to load user');
    }
  }



  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
      title: Text(futureUser!.firstname + " " + futureUser!.lastname),
    ),
    body: isLoad ?
    ListView(
      children: [
        Row(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 200,
                  height: 200,
                  child:const Image(
                    image: AssetImage('images/user.png'),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(futureUser!.lastname.toUpperCase(), style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                )),
                Text(futureUser!.firstname, style: const TextStyle(
                  fontSize: 25,
                )),
              ],
            )
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Text("<< " + futureUser!.citation + " >>",
                softWrap: true,
                style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const Expanded(
                      child: Text("Sexe :", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(futureUser!.gender, style: const TextStyle(
                        fontSize: 20
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const Expanded(
                      child: Text("Adresse :", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(futureUser!.adress, style: const TextStyle(
                        fontSize: 20
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  const Expanded(
                      child: Text("Téléphone :", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(futureUser!.phone, style: const TextStyle(
                        fontSize: 20
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>  UpdateScreen(user: futureUser!)
            )
            );
          }, child: const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Modifier Le profil",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          )
          ),
        )

      ]) :
    const Center(
    child: SizedBox(
    width: 100,
    height: 100,
    child: CircularProgressIndicator(
      value: null,
      backgroundColor: Colors.blue,
      valueColor: AlwaysStoppedAnimation(Colors.green),
       ),
      ),
    )
  );


  }
}
class buidUserItem extends StatelessWidget
{
  final User user;

  const buidUserItem({Key? key, required this.user}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Row(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 200,
                  height: 200,
                  child:const Image(
                    image: AssetImage('images/user.png'),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.lastname.toUpperCase(), style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                )),
                Text(user.firstname, style: const TextStyle(
                  fontSize: 25,
                )),
              ],
            )
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Text("<< " + user.citation + " >>",
                softWrap: true,
                style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const Expanded(
                      child: Text("Sexe :", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(user.gender, style: const TextStyle(
                        fontSize: 20
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const Expanded(
                      child: Text("Adresse :", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(user.adress, style: const TextStyle(
                        fontSize: 20
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  const Expanded(
                      child: Text("Téléphone :", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(user.phone, style: const TextStyle(
                        fontSize: 20
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>  UpdateScreen(user: user)
            )
            );
          }, child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Modifier Le profil",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          )
          ),
        )
      ],
    );
      /* ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: 100,
                      height: 100,
                      child: const Image(
                        image: AssetImage('images/user.png'),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.lastname.toUpperCase(), style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    )),
                    Text(user.firstname, style: const TextStyle(
                      fontSize: 25,
                    )),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Text("<< " + user.citation + " >>",
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text("Sexe :", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ))
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(user.gender, style: const TextStyle(
                            fontSize: 20
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text("Email :", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ))
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(user.lastname, style: const TextStyle(
                            fontSize: 20
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text("Adresse :", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ))
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(user.adress, style: const TextStyle(
                            fontSize: 20
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text("Date de Naissance :", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ))
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(user.firstname, style: const TextStyle(
                            fontSize: 20
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text("Téléphone :", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ))
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(user.phone, style: const TextStyle(
                            fontSize: 20
                        )),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18),
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>  UpdateScreen(user: user)
                    )
                    );
                  }, child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Modifier Le profil",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  )
                  ),
                )

              ],
            )
          ],
        )*/

  }

}