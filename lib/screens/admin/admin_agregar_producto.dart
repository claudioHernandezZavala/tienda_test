import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:tienda_test/componentes/recordatorios.dart';
import 'package:tienda_test/screens/principal/home.dart';

class Agregar_producto extends StatefulWidget {
  const Agregar_producto({Key? key}) : super(key: key);

  @override
  State<Agregar_producto> createState() => _Agregar_productoState();
}

class _Agregar_productoState extends State<Agregar_producto> {
  File? sampleImage;
  final key = GlobalKey<FormState>();
  String descripcion = "";
  String precio = "";
  String nombre = "";
  String material = "";
  String categoria = "";
  var url = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar imagen"),
      ),
      body: Center(
          child: sampleImage == null
              ? recordatorio(
                  recordatorio_texto: "Presione el boton y\nescoga una imagen")
              : enableUpload()),
      floatingActionButton: sampleImage != null
          ? null
          : FloatingActionButton(
              onPressed: () {
                getImage();
              },
              tooltip: 'Subir foto',
              child: Icon(Icons.add_a_photo_outlined),
            ),
    );
  }

  Future getImage() async {
    final sampleImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final temp1 = sampleImage!.path;
    setState(() {
      this.sampleImage = File(temp1);
    });
  }

  Widget enableUpload() {
    return SingleChildScrollView(
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
                  decoration: InputDecoration(labelText: "Descripcion"),
                  validator: (value) {
                    return value!.isEmpty
                        ? "Una descripcion es requerida"
                        : null;
                  },
                  onSaved: (value) {
                    descripcion = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "categoria"),
                  validator: (value) {
                    return value!.isEmpty ? "Una categoria es requerida" : null;
                  },
                  onSaved: (value) {
                    categoria = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Precio"),
                  validator: (value) {
                    return value!.isEmpty ? "Un precio es requerid0" : null;
                  },
                  onSaved: (value) {
                    precio = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Nombre"),
                  validator: (value) {
                    return value!.isEmpty ? "Un nombre es requerido" : null;
                  },
                  onSaved: (value) {
                    nombre = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Material"),
                  validator: (value) {
                    return value!.isEmpty ? "Un material es requerido" : null;
                  },
                  onSaved: (value) {
                    material = value!;
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
                      child: Text("Subir nuevo producto")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void subiraDatabase() async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    CollectionReference referenciaBase =
        FirebaseFirestore.instance.collection("productos/");
    var data = {
      "imagen": url,
      "descripcion": descripcion,
      "precio": precio,
      "nombre": nombre,
      "material": material,
      "categoria": categoria
    };
    //ref.child("pulseras").child(nombre).set(data);
    referenciaBase.add(data);
    ref.child("pulseras").push().set(data);
    Fluttertoast.showToast(
        msg: "Producto subido con exito",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0);

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

      print(url);
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
