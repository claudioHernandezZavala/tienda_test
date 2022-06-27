import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/Registro e inicio de sesion/login.dart';
import 'Registro e inicio de sesion/login.dart';

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? url = user!.photoURL;
    String? correo = user.displayName;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Center(
              child: CircleAvatar(
                  maxRadius: 50,
                  child: ClipOval(
                    child: Image.network(url!),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              correo!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              child: FlatButton(

                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login()));
                  },

                  child:  Text("Cerrar sesión")),
            ),
          ],
        ),
      ),
    );
  }
}
