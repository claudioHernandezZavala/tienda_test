import 'package:flutter/material.dart';
import 'package:tienda_test/carrito/carrito.dart';
import 'package:tienda_test/constants.dart';
import 'package:tienda_test/clases/productos.dart';
import 'package:tienda_test/screens/details/body.dart';
class detailScreen extends StatelessWidget {
  final Producto producto;
  const detailScreen({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfe9c8f),
      appBar:buildAppbar(context),
      body: bodyDetails(producto:producto),

    );
  }
  AppBar buildAppbar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xFFfe9c8f),
      leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: ()=> Navigator.pop(context),),
      actions: [

        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => shopcart()));
        }, icon:Icon(Icons.shopping_cart)),

        SizedBox(width: kdefaultpadding/2,)
      ],
    );
  }

}

