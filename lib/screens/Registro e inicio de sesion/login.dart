import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tienda_test/screens/Registro%20e%20inicio%20de%20sesion/registro.dart';
import 'package:tienda_test/screens/principal/home.dart';
import 'package:tienda_test/widgets/campo_contrasena.dart';
import 'package:tienda_test/widgets/campo_correo.dart';

import '../../constants.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  User? user = FirebaseAuth.instance.currentUser;
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  GoogleSignIn googlesign = GoogleSignIn(scopes: ["email"]);
  String dentro = "";
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user2 = googlesign.currentUser;
    return Stack(
      children: [
        imagen_fondo(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        "Ingreso",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    height: 150,
                  ),
                  SizedBox(
                    height: 10,
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
                              icon: Icons.email,
                              controller: emailcontroller,
                              accion: TextInputAction.next,
                            ),
                            password(
                              hint: "Contraseña",
                              icon: Icons.lock,
                              controller: passwordController,
                              accion: TextInputAction.next,
                            ),
                            Text(
                              "Olvidaste tu contraseña? ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: FlatButton(
                                    onPressed: () async {
                                      //GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD;
                                      // GoogleSignIn.games();
                                      //googlesign.signIn();
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: emailcontroller.text,
                                              password:
                                                  passwordController.text);
                                      // await signinGoogle();
                                      //FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcontroller.text, password:passwordController.text);
                                      setState(() {
                                        dentro = isSignin();
                                      });
                                      //navegar
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text("Iniciar sesion"),
                                    )),
                              ),
                            ),
                            Text(
                              "o",
                              style: estilo1(),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: FlatButton.icon(
                                icon: const FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  //GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD;
                                  // GoogleSignIn.games();
                                  //googlesign.signIn();
                                  //FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordController.text);
                                  await signinGoogle();
                                  //FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcontroller.text, password:passwordController.text);
                                  setState(() {
                                    dentro = isSignin();
                                  });
                                  //navegar
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                                },
                                label: Text(
                                    "Inicia sesion o registrate con Google"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  Text(
                                    "Aun no eres miembro?",
                                    style: estilo1(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        //googlesign.signOut();

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    register()));
                                      },
                                      child: Text(
                                        "Registrate!",
                                        style: estiloLinks(),
                                      ))
                                ],
                              ),
                            )
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

String isSignin() {
  if (FirebaseAuth.instance.currentUser == null) {
    return "out";
  } else {
    return "in";
  }
}

Future<UserCredential> signinGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleauth =
      await googleUser!.authentication;
  final credential = GoogleAuthProvider.credential(
      idToken: googleauth.idToken, accessToken: googleauth.accessToken);
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class roundedButtom extends StatelessWidget {
  final String texto;
  const roundedButtom({Key? key, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white30.withOpacity(05)),
      child: FlatButton(
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(texto),
        ),
      ),
    );
  }
}

Widget imagen_fondo() {
  return ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
      colors: [Colors.black, Colors.black12],
      begin: Alignment.bottomCenter,
      end: Alignment.center,
    ).createShader(bounds),
    blendMode: BlendMode.darken,
    child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/imagenLogin.jpg"),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
      )),
    ),
  );
}
