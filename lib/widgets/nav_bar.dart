import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tienda_test/screens/Registro%20e%20inicio%20de%20sesion/login.dart';
import 'package:tienda_test/screens/admin/paneladmin.dart';
import 'package:tienda_test/screens/perfil.dart';

import '../constants.dart';

class navBar extends StatelessWidget {
  const navBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? nombre = user!.displayName;

    String? email = user.email;
    String? url = user.photoURL;

    Widget fotoPerfil() {
      if (url != null) {
        return Image.network(
          url,
          fit: BoxFit.cover,
        );
      } else {
        return Image.asset(
          "assets/avatar_hombre.png",
          fit: BoxFit.cover,
        );
      }
    }

    Widget adminPanel() {
      if (email == "claudio.ahz123@gmail.com") {
        return ListTile(
          title: Text(
            "Panel",
            style: estilodrawer(),
          ),
          leading: Icon(Icons.insert_chart, color: colorIconsDrawer),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => paneladminp()));
          },
        );
      } else {
        return ListTile();
      }
    }

    return Drawer(
      backgroundColor: Color(0xFF383E56),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: nombre != null ? Text(nombre) : Text("Cliente"),
            accountEmail: Text(email!),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(child: fotoPerfil()),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("assets/background.jpg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle_rounded,
                color: colorIconsDrawer),
            title: Text(
              "Perfil",
              style: estilodrawer(),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.map, color: colorIconsDrawer),
            title: Text(
              "Visitar tienda",
              style: estilodrawer(),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.share, color: colorIconsDrawer),
            title: Text(
              "Comparte nuesta app",
              style: estilodrawer(),
            ),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.book, color: colorIconsDrawer),
            title: Text(
              "Terminos y condiciones",
              style: estilodrawer(),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help, color: colorIconsDrawer),
            title: Text(
              "Ayuda",
              style: estilodrawer(),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: colorIconsDrawer),
            title: Text(
              "Configuracion",
              style: estilodrawer(),
            ),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: colorIconsDrawer,
            ),
            title: Text(
              "Cerrar sesion",
              style: estilodrawer(),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => login()));
            },
          ),
          adminPanel()
        ],
      ),
    );
  }
}
