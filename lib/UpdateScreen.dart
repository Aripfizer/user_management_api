import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:date_field/date_field.dart';
import 'package:user_management_api/user.dart';
import 'package:user_management_api/userInfoScreen.dart';
import 'package:user_management_api/userListScreen.dart';
import 'package:http/http.dart' as http;


void updateUser(User user) async{
  final response = await http.post(
    Uri.parse('https://ifri.raycash.net/updateuser/${user.id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "firstname": user.firstname,
      "lastname" : user.lastname,
      "adress" : user.adress,
      "phone" : user.phone,
      "gender" : user.gender,
      "picture" : user.picture!,
      "citation" : user.citation
    }),
  );


  if (response.statusCode != 200) {
    throw Exception('Failed to create user.');
  }
}


class UpdateScreen extends StatefulWidget {
  final User user;
  const UpdateScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final formKey = GlobalKey<FormState>();
  String lastname= "";
  String firstname= "";
  String gender= "";
  String mail= "";
  String adress= "";
  String phone= "";
  String? picture= "";
  String citation= "";
  String birthday= "";


  User? user;
  File? imageFile;
  bool imageError = false;





  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> _items = [
      {
        'value': 'Masculin',
        'label': 'Masculin',
        'icon': const Icon(Icons.male_outlined, color: Colors.blue),
        'textStyle': const TextStyle(color: Colors.blue),
      },
      {
        'value': 'Féminin',
        'label': 'Féminin',
        'icon': const Icon(Icons.female_outlined, color: Colors.blue),
        'textStyle': const TextStyle(color: Colors.blue),
      }
    ];
    Future pickImage() async {
      try {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);

        if(image == null) return;
        setState(() {
          imageError = false;
        });
        final imageTemp = File(image.path);

        setState(() => imageFile = imageTemp);

/*
        final directory = await getExternalStorageDirectory();
        print('Success');
        try {
          if (directory != null) return File(imageFile!.path).copy('${directory.path}/name.png');
          print('Success');
        }on PlatformException catch(e) {
          print(e);
        }

 */

        /*
          final String appStorage = await getApplicationDocumentsDirectory().path;
          final newFile = File('$appStorage/images/${basename(imageFile!.path)}');
          return File(imageFile!.path).copy(newFile.path);

         */

      } on PlatformException catch(e) {
        print('Failed to pick imageFile: $e');
      }
    }





    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier ${widget.user.firstname} ${widget.user.lastname}"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: imageFile == null ?  const Image(
                            image: AssetImage('images/user.png'),
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ) : Image.file(
                            imageFile!,
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        /*CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: imageFile != null ? Image.file(imageFile!) :Image.asset(
                                  "images/user.png",
                                  fit: BoxFit.cover,
                              ),
                            )*/
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 46, right: 12),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            pickImage();
                          },
                          child: const Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "Choisir une image",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ),

                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: imageError ? const Text(
                    "Veillez choisir une image",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red)
                ) : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                initialValue: widget.user.lastname,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Nom",
                    hintText: "Enter votre nom",
                    icon: Icon(Icons.person, color : Colors.blue, size: 25,)
                ),
                onChanged: (v){
                  setState(() {
                    lastname = v;
                  });
                },
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "Le nom est réquis";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                initialValue: widget.user.firstname,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Prénom",
                    hintText: "Enter votre prénom",
                    icon: Icon(Icons.person, color : Colors.blue, size: 25,)
                ),
                onChanged: (v){
                  setState(() {
                    firstname = v;
                  });
                },
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "Le prénom est réquis";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                initialValue: widget.user.phone,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Phone",
                    hintText: "Enter votre numéro de téléphone",
                    icon: Icon(Icons.phone, color : Colors.blue, size: 25,)
                ),
                onChanged: (v){
                  setState(() {
                    phone = v;
                  });
                },
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "Le téléphone est réquis";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                initialValue: widget.user.adress,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                    labelText: "Adresse",
                    hintText: "Enter votre Adresse",
                    icon: Icon(Icons.add_location, color : Colors.blue, size: 25,)
                ),
                onChanged: (v){
                  setState(() {
                    adress = v;
                  });
                },
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "L'adresse est réquis";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                initialValue: widget.user.citation,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Citation",
                  hintText: "Enter votre Citation",
                  icon: Icon(Icons.email, color : Colors.blue, size: 25,),

                ),
                onChanged: (v){
                  setState(() {
                    citation = v;
                  });
                },
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "La citation est réquise";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: SelectFormField(
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: widget.user.gender,
                icon: const Icon(Icons.person),
                labelText: 'Sexe',
                items: _items,
                onChanged: (val){
                  setState(() {
                    gender = val;
                  });
                  //print(sexe);
                },
                onSaved: (val) => print(val),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {

                    if(imageFile == null) {
                      setState(() {
                        imageError = true;
                      });
                    }else
                    {
                      setState(() {
                        picture = imageFile?.path;
                      });

                      if(formKey.currentState!.validate())
                      {
                        user = User(
                          id: widget.user.id, // creer une methode qui verifie si le nombre generer existe deja dans la database
                          firstname: firstname, // exist
                          lastname : lastname,// exist
                          adress : adress,// exist
                          phone : phone,// exist
                          gender : gender,// exist
                          picture : picture!,// not exist
                          citation : citation,// exist
                        );

                        print("user : $user");
                         updateUser(user!);

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>  UserInfoScreen(userid: widget.user.id!)
                        )
                        );
                        /*Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>  const UserListScreen()
                      )
                      );

                       */
                        //Navigator.pop(context);
                        print("end");
                      }
                    }
                    //print(picture);

                  }, child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Mettre a jour", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
