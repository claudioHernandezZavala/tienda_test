import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:tienda_test/componentes/recordatorios.dart';
import 'package:tienda_test/screens/principal/home.dart';

class admin_agregar_categoria extends StatefulWidget {
  const admin_agregar_categoria({Key? key}) : super(key: key);

  @override
  _admin_agregar_categoriaState createState() => _admin_agregar_categoriaState();
}

class _admin_agregar_categoriaState extends State<admin_agregar_categoria> {
  File? sampleImage;
  final key = GlobalKey<FormState>();
  String categoriaNueva = "";
  String url = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sampleImage ==null? const Center( child:recordatorio(recordatorio_texto: "Presione el boton y\nescoga una imagen\npara la nueva categoria",)):enableUpload(),
      floatingActionButton: sampleImage != null ? null: FloatingActionButton(onPressed: (){

        getImage();
      },
        backgroundColor:Colors.orange,
      child: Icon(Icons.add_a_photo),),


    );
  }
  Future getImage() async {
    final sampleImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    final temp1 = sampleImage!.path;
    print(temp1);
    setState(() {
      this.sampleImage = File(temp1);
    });
  }
  Widget enableUpload() {
    return SingleChildScrollView(

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Container(
          child: Form(
            key: key,
            child: Column(
              children: [
                Image.file(
                  sampleImage!,
                  height: 200,
                  width: 400,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Nombre de categoría"),
                    validator: (value) {
                      return value!.isEmpty
                          ? "El nombre de la categoria es requerida"
                          : null;
                    },
                    onSaved: (value) {
                      categoriaNueva= value!;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Container(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.greenAccent),
                    child: FlatButton(
                        onPressed: () {
                          upload();
                        },
                        child: Text("Subir nueva categoria")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void subiraDatabase() async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "imagen": url,
      "categoria": categoriaNueva
    };
    //ref.child("pulseras").child(nombre).set(data);
    ref.child("categorias").push().set(data);
    Fluttertoast.showToast(
        msg: "Categoria subida con exito",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0
    );


    Navigator.of(this.context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void upload() async {
    //Firebase.initializeApp();
    if (validateForm()) {
      final String nombre = basename(this.sampleImage!.path);

      final destination = "pulseras/${nombre}";

      final referencia = await FirebaseStorage.instance.ref(destination);
      //referencia.putFile(this.sampleImage!);
      UploadTask task = referencia.putFile(this.sampleImage!);
      final snap = await task.whenComplete(() {});
      final urldownload = await snap.ref.getDownloadURL();
      this.url = urldownload;
      subiraDatabase();
    }
  }

  bool validateForm() {
    final form = key.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
