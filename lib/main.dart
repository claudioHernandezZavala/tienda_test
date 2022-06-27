import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tienda_test/screens/Registro%20e%20inicio%20de%20sesion/login.dart';
import 'package:tienda_test/screens/principal/grid_productos.dart';
import 'package:tienda_test/screens/principal/home.dart';

import 'clases/categoria.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        routes: {
          "inicio": (context) => HomeScreen(),
          "cuerpoCate": (context) => categoriasCuerpo(
              categoria: Categoria("assets/imagenLogin.jpg", "Todo", "keyTodo"))
        },
        home: FutureBuilder(
            future: initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("error");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return iniciar();
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  Widget iniciar() {
    if (FirebaseAuth.instance.currentUser == null) {
      return login();
    } else {
      return HomeScreen();
    }
  }
}
