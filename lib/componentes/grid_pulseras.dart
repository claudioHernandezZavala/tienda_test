import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:photo_view/photo_view.dart';
import 'package:tienda_test/clases/categoria.dart';
import 'package:tienda_test/clases/productos.dart';
import 'package:tienda_test/screens/details/details.dart';
import 'package:tienda_test/screens/principal/grid_productos.dart';

import '../../constants.dart';

class ItemFinal extends StatelessWidget {
  final Producto producto;

  const ItemFinal({
    Key? key,
    required this.producto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = 300;
    double h = 200;
    if (MediaQuery.of(context).size.width > 700) {
      w = 600;
      h = 400;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailScreen(producto: producto)));
      },
      child: Container(
        height: (MediaQuery.of(context).size.height / 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
              )
            ]),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.orange,
                  )
                ],
              ),
            ),
            Container(
              width: 140,
              height: 110,
              child: PhotoView(
                loadingBuilder: (context, progress) => Center(
                    child: CircularProgressIndicator(
                  color: Colors.orange,
                )),
                heroAttributes: PhotoViewHeroAttributes(
                  tag: producto.key,
                  transitionOnUserGestures: true,
                ),
                imageProvider: NetworkImage(producto.imagen),
                backgroundDecoration: BoxDecoration(color: Colors.transparent),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Lps." + producto.precio,
              style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              producto.titulo,
              maxLines: 4,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class cardProductosCarousel extends StatelessWidget {
  final Producto producto;

  const cardProductosCarousel({Key? key, required this.producto})
      : super(key: key);

  @override
  Widget build(BuildContext contextoGrid) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(contextoGrid).push(MaterialPageRoute(
                  builder: (context) => detailScreen(producto: producto)));
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              color: Color(0xFFF69E7B),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              shadowColor: Colors.blue,
              elevation: 10,
              child: Container(
                width: (MediaQuery.of(contextoGrid).size.width / 2) * 1.5,
                height: (MediaQuery.of(contextoGrid).size.height / 2) * 0.56,
                child: PhotoView(
                  customSize: Size(
                      (MediaQuery.of(contextoGrid).size.width / 2) * 1.5, 270),
                  loadingBuilder: (context, progress) => Center(
                      child: CircularProgressIndicator(
                    color: Colors.orange,
                  )),
                  imageProvider: NetworkImage(producto.imagen),
                  backgroundDecoration:
                      BoxDecoration(color: Colors.transparent),
                ),
                decoration: BoxDecoration(),
              ),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(contextoGrid).size.height / 2) * 0.45,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shadowColor: Colors.orange,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: EdgeInsets.all(10),
                width: 250,
                height: 100,
                // width: (MediaQuery.of(context).size.width/1.5),
                //height: (MediaQuery.of(context).size.height/3)*0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      producto.titulo,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lps. " + producto.precio,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.orange,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class item_categoria extends StatelessWidget {
  final Categoria categoria;
  const item_categoria({Key? key, required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => categoriasCuerpo(categoria: categoria)))
            .then((value) {});
        ;
      },
      child: Card(
          color: Color(0xFFF69E7B),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          margin: EdgeInsets.symmetric(vertical: 20),
          borderOnForeground: true,
          shadowColor: Colors.yellow,
          elevation: 10,
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                height: 150,
                width: 150,
                child: PhotoView(
                  loadingBuilder: (context, progress) => Center(
                      child: CircularProgressIndicator(
                    color: Colors.orange,
                  )),
                  imageProvider: NetworkImage(categoria.imagen),
                  backgroundDecoration:
                      BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                categoria.categoriaTexto,
                style: estilo3(),
              ),
            ],
          )),
    );
  }
}

class itemtarjetaproducto extends StatelessWidget {
  final Producto producto;
  const itemtarjetaproducto({Key? key, required this.producto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailScreen(producto: producto)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            shadowColor: Colors.blue,
            elevation: 10,
            child: Container(
              width: 400,
              height: 150,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 150,
                    width: 140,
                    child: PhotoView(
                        imageProvider: NetworkImage(producto.imagen),
                        backgroundDecoration:
                            BoxDecoration(color: Colors.transparent),
                        loadingBuilder: (context, progress) => Center(
                                child: CircularProgressIndicator(
                              color: Colors.green,
                            ))),
                  ),
                  Expanded(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        producto.titulo,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Lps. " + producto.precio,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.deepOrangeAccent,
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

//segunda opcion=======================================
