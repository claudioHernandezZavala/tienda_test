import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tienda_test/clases/productos.dart';

import '../../constants.dart';

class Producto_conImagen_Precio extends StatelessWidget {
  const Producto_conImagen_Precio({
    Key? key,
    required this.producto,
  }) : super(key: key);

  final Producto producto;

  @override
  Widget build(BuildContext context) {
    double width1 = 250;
    double height1 = 250;

    if (MediaQuery.of(context).size.width > 800) {
      width1 = 400;
      height1 = 300;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kdefaultpadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Text(producto.material,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 10,),
          Text(
            producto.titulo,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                width: 10,
              ),

              SizedBox(
                height: height1,
                width: width1,
                child: PhotoView(

                    loadingBuilder: (context, progress) => Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      )
                    ),
                    backgroundDecoration:
                        BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(25)),
                    enableRotation: true,
                    imageProvider: NetworkImage(
                      producto.imagen,
                    )),
              )

              //PhotoView(imageProvider: Image.network(producto.imagen,fit: BoxFit.fill,width:width1,height:height1))
            ],
          )
        ],
      ),
    );
  }
}
