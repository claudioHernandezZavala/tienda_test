import 'package:flutter/material.dart';
import 'package:tienda_test/clases/productos.dart';


class contador extends StatefulWidget {
  final int cantidad =1;
  const contador({Key? key, }) : super(key: key);

  @override
  _contadorState createState() => _contadorState(cantidad);
}

class _contadorState extends State<contador> {
    int cantidadProducto =0;

     _contadorState(cantidadProducto);





  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 11,
        ),
        SizedBox(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              elevation: 5,
              shadowColor: Colors.red,

              backgroundColor: Colors.white,
            ),
            onPressed: () {
              if (cantidadProducto > 1) {
                setState(() {

                  cantidadProducto--;
                });
              }
            },
            child: Icon(
              Icons.remove,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Center(
              child: Text(cantidadProducto.toString().padLeft(2, "0"))),
        ),
        SizedBox(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white, elevation: 5,shadowColor: Colors.green,),
            onPressed: () {
              setState(() {

                cantidadProducto++;
              });
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
