import 'package:flutter/material.dart';

import '../constants.dart';

class categorias extends StatefulWidget {

  const categorias({Key? key, }) : super(key: key);

  @override
  _categoriasState createState() => _categoriasState();
}

class _categoriasState extends State<categorias> {
  List<String> categorias = [
    "Oro",
    "Plata",
    "Amor",
    "Elegante",
    "pareja",
    "Ofertas",
    "Nuevas"
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categorias.length,
            itemBuilder: (context, index) => buildText(index)),
      ),
    );
  }


  Widget buildText(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;


        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
}
