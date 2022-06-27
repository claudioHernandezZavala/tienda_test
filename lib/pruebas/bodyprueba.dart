import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tienda_test/clases/categoria.dart';
import 'package:tienda_test/componentes/grid_pulseras.dart';
import 'package:tienda_test/constants.dart';
import 'package:tienda_test/clases/productos.dart';
import 'package:tienda_test/screens/details/details.dart';
import 'package:carousel_slider/carousel_slider.dart';


class bodyPrueba extends StatefulWidget {
  const bodyPrueba({Key? key}) : super(key: key);

  @override
  State<bodyPrueba> createState() => _bodyState();
}

class _bodyState extends State<bodyPrueba> {
  List<Producto> productosGenerales = [];
  List<Categoria> cate = [];

  List<Producto> productosNuevos = [];
  bool loading = false;
  List<String> categorias = [
    "Todo",
    "Oro",
    "Plata",
    "Amor",
    "Elegante",
    "pareja",
    "Ofertas",
    "Nuevas"
  ];
  int selectedIndex = 0;
  Widget buildText(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          setState(() {
            initState();
          });
          print(selectedIndex);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            categorias[index],
            style: TextStyle(
                color: selectedIndex == index ? kTextColor : ktextLightColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          Container(
            height: 2,
            width: 30,
            color: selectedIndex == index ? Colors.black : Colors.transparent,
          )
        ]),
      ),
    );
  }

  void initState() {
   // llenarArreglo();
    setState(() {});
  }

  void llenarArreglo() {
    setState(() {
      loading = true;
    });
    Firebase.initializeApp();
    DatabaseReference postref = FirebaseDatabase.instance.reference().child("pulseras");


    postref.get().then((DataSnapshot snap) {

      var keys1 = snap.value.keys;
      dynamic data = snap.value;
      productosGenerales.clear();
      if (selectedIndex != 0) {
        for (var keyindividual in keys1) {
          if (data[keyindividual]['categoria'].toString() ==
              (categorias[selectedIndex])) {
            Producto ProductoNuevo = Producto(
                data[keyindividual]['imagen'],
                data[keyindividual]['nombre'],
                data[keyindividual]['descripcion'],
                data[keyindividual]['precio'],
                data[keyindividual]['material'],
                Color(0xFF524175),
                data[keyindividual]['categoria'],
                keyindividual);

            productosGenerales.add(ProductoNuevo);
          }
        }
      } else if (selectedIndex == 0) {
        for (var keyindividual in keys1) {
          Producto ProductoNuevo = Producto(
              data[keyindividual]['imagen'],
              data[keyindividual]['nombre'],
              data[keyindividual]['descripcion'],
              data[keyindividual]['precio'],
              data[keyindividual]['material'],
              Color(0xFF524175),
              data[keyindividual]['categoria'],
              keyindividual);
          productosGenerales.add(ProductoNuevo);
        }
      }
      productosNuevos.clear();
      for (var keyindividual in keys1) {
        Producto ProductoNuevo = Producto(
            data[keyindividual]['imagen'],
            data[keyindividual]['nombre'],
            data[keyindividual]['descripcion'],
            data[keyindividual]['precio'],
            data[keyindividual]['material'],
            Color(0xFF524175),
            data[keyindividual]['categoria'],
            keyindividual);
        productosNuevos.add(ProductoNuevo);
      }


    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
              "Productos recientes!",
              style: estilo3(),
            )),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<Object>(
            stream:
            FirebaseDatabase.instance.reference().child("pulseras").onValue,
            builder: (context,  AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                productosNuevos.clear();
                DataSnapshot valores =  snapshot.data.snapshot;
                Map<dynamic,dynamic> values =  valores.value;
                values.forEach((key, value) {
                  Producto ProductoNuevo = Producto(
                      value['imagen'],
                      value['nombre'],
                      value['descripcion'],
                      value['precio'],
                      value['material'],
                      Color(0xFF524175),
                      value['categoria'],
                      key);
                  productosNuevos.add(ProductoNuevo);
                });

              }
              return productosNuevos.isEmpty?Text("No hay Productos nuevos"):CarouselSlider.builder(
                  itemCount: productosNuevos.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return item_categoria(categoria: cate[itemIndex]);
                  },
                  options: CarouselOptions(
                    height: 250,
                    aspectRatio: 25 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ));
            }),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kdefaultpadding),
              child: StreamBuilder<Object>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child("pulseras")
                      .onValue,
                  builder: (context,  AsyncSnapshot snapshot) {


                    var count = 2;
                    double espacio = 20;
                    double aspetr = 0.68;
                    if (MediaQuery.of(context).size.width > 700) {
                      count = 6;
                      espacio = 3;
                      aspetr = 0.8;
                    }
                    if(snapshot.hasData){
                      productosGenerales.clear();
                      DataSnapshot valores =  snapshot.data.snapshot;
                      Map<dynamic,dynamic> values =  valores.value;
                      values.forEach((key, value) {
                        Producto ProductoNuevo = Producto(
                            value['imagen'],
                            value['nombre'],
                            value['descripcion'],
                            value['precio'],
                            value['material'],
                            Color(0xFF524175),
                            value['categoria'],
                            key);
                        productosGenerales.add(ProductoNuevo);
                      });

                    }

                    return productosGenerales.isEmpty
                        ? Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height > 750
                                ? 400
                                : 500,
                            width: MediaQuery.of(context).size.width > 750
                                ? 500
                                : 500,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Image.asset("assets/al_buscar.png"),
                                Text(
                                  "No pudimos encontrar productos en esa categoria",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            )))
                        : GridView.builder(
                        padding: EdgeInsets.all(6),
                        itemCount: productosGenerales.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: count,
                            mainAxisSpacing: espacio,
                            crossAxisSpacing: 10,
                            childAspectRatio: aspetr),
                        itemBuilder: (context, index) =>
                            ItemFinal(producto: productosGenerales[index]));
                  }),
            ))


      ],
    );
  }
}
