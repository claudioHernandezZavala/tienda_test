import 'package:flutter/material.dart';
import 'package:tienda_test/constants.dart';
class vacio extends StatelessWidget {
  final String elemento;
  final String imagen;
  const vacio({Key? key, required this.elemento, required this.imagen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(

        children: [

          Container(
            height: 100,
            width: 100,
            child: Image.asset(imagen),
          ),
          SizedBox(height: 40,),
          Text(
            elemento,
            style: estiloLetras(),
          )
        ],
      ),
    );
  }
}
