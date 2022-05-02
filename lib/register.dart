import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:user_management_api/user.dart';
import 'package:user_management_api/userListScreen.dart';
import 'package:http/http.dart' as http;


void createUser(User user) async{
  final response = await http.post(
    Uri.parse('https://ifri.raycash.net/adduser'),
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



class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final lastnameController = TextEditingController();
  final firstnameController = TextEditingController();
  final genderController = TextEditingController();
  final adressController = TextEditingController();
  final phoneController = TextEditingController();
  final pictureController = TextEditingController();
  final citationController = TextEditingController();
  String sexe = "m";
  String? picture;
  User? user;
  File? imageFile;
  bool imageError = false;





  @override
  void dispose() {
    lastnameController.dispose();
    firstnameController.dispose();
    genderController.dispose();
    adressController.dispose();
    phoneController.dispose();
    pictureController.dispose();
    citationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> _items = [
      {
        'value': 'm',
        'label': 'Masculin',
        'icon': const Icon(Icons.male_outlined, color: Colors.blue),
        'textStyle': const TextStyle(color: Colors.blue),
      },
      {
        'value': 'f',
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
        title: const Text("Ajouter un utilisateur"),
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
                controller: lastnameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Nom",
                    hintText: "Enter votre nom",
                    icon: Icon(Icons.person, color : Colors.blue, size: 25,)
                ),
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
                controller: firstnameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Prénom",
                    hintText: "Enter votre prénom",
                    icon: Icon(Icons.person, color : Colors.blue, size: 25,)
                ),
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
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Phone",
                    hintText: "Enter votre numéro de téléphone",
                    icon: Icon(Icons.phone, color : Colors.blue, size: 25,)
                ),
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
                controller: adressController,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                    labelText: "Adresse",
                    hintText: "Enter votre Adresse",
                    icon: Icon(Icons.add_location, color : Colors.blue, size: 25,)
                ),
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
                controller: citationController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                    labelText: "Citation",
                    hintText: "Enter votre Citation",
                    icon: Icon(Icons.email, color : Colors.blue, size: 25,),

                ),
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
                initialValue: sexe,
                icon: const Icon(Icons.person),
                labelText: 'Sexe',
                items: _items,
                onChanged: (val){
                  setState(() {
                    sexe = val;
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
                    }
                    //print(picture);

                    if(formKey.currentState!.validate())
                      {
                        user = User(
                          id: null, // creer une methode qui verifie si le nombre generer existe deja dans la database
                          firstname: firstnameController.value.text, // exist
                          lastname : lastnameController.value.text,// exist
                          adress : adressController.value.text,// exist
                          phone : phoneController.value.text,// exist
                          gender : sexe,// exist
                          picture : picture!,// not exist
                          citation : citationController.value.text,// exist
                        );

                        print("user $user");
                        createUser(user!);


                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>  const UserListScreen()
                          )
                        );

                        //Navigator.pop(context);
                      }
                  }, child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("S'inscrire", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


