import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_test/clases/productos.dart';

class item_admin extends StatelessWidget {
  final Producto producto;
  const item_admin({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double wSizedBox = 20;
    double w = 120;
    double w2 = 1;
    double h = 200;
    if (MediaQuery.of(context).size.width >= 750) {
      wSizedBox = 50;
      w = 400;
      h = 300;
      w2 = 50;
    }
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(10),
          child: Container(
            child: Row(
              children: [
                SizedBox(
                  width: wSizedBox,
                ),
                Container(
                    height: h, width: w, child: Image.network(producto.imagen)),
                SizedBox(
                  width: w2,
                ),
                Expanded(
                  child: Wrap(

                    direction: Axis.vertical,
                    children: [
                      Text("Nombre",style: estilo(Colors.blue)),
                      Text(
                        producto.titulo,style: estilo(Colors.blue),
                      ),
                     SizedBox(height: 10,),
                      Text("Material:",style: estilo(Colors.purple)),
                      Text( producto.material,style: estilo(Colors.purple),),
                      SizedBox(height: 10,),
                      Text("Precio",style: estilo(Colors.green),),
                      Text(producto.precio,style: estilo(Colors.green),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
TextStyle estilo(Color color){
  return TextStyle(
    color: color
  );
}
