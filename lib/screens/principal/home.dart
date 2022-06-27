import 'package:flutter/material.dart';
import 'package:tienda_test/carrito/carrito.dart';
import 'package:tienda_test/widgets/nav_bar.dart';

import '../../constants.dart';
import 'body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context1) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFEEDAD1),
      drawer: navBar(),
      appBar: appbarInicio(context1),
      body: body(context: context1),
    );
  }
}

AppBar appbarInicio(BuildContext context) {
  return AppBar(
    title: const Text(
      "lala",
      style: TextStyle(color: Colors.white),
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => shopcart()));
        },
        icon: Icon(Icons.shopping_cart, color: Colors.white),
        color: kTextColor,
      ),
      SizedBox(
        width: kdefaultpadding / 2,
      )
    ],
    backgroundColor: Color(0xFF383E56),
    elevation: 1,
    centerTitle: true,
  );
}
