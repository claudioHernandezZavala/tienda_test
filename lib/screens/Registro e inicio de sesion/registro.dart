import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tienda_test/screens/Intros/onboard.dart';
import 'package:tienda_test/widgets/campo_contrasena.dart';
import 'package:tienda_test/widgets/campo_correo.dart';

import 'login.dart';
class register extends StatelessWidget {

  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailcontroller =  TextEditingController();
    final passwordController =  TextEditingController();
    return Stack(
      children: [
        imagen_fondo(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Center(
                        child: Text(
                          "Registro",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    height: 150,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            correo(
                              hint: "Email",
                              accion: TextInputAction.next,

                              icon: Icons.email,controller: emailcontroller,),
                            password(
                              hint: "Contraseña",
                              accion: TextInputAction.next,
                              icon: Icons.lock,controller: passwordController,),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: FlatButton(
                                    onPressed: () async{
                                       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcontroller.text, password:passwordController.text);
                                      //GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD;
                                      Fluttertoast.showToast(
                                        msg: "Registro exitoso",
                                        backgroundColor: Colors.green,

                                      );
                                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>onboardPrueba()));
                                    },
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 12),
                                      child: Text("Registrarme"),
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}