import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

import '../clases/categoria.dart';

class categoria_Card extends StatefulWidget {
  final Categoria categoria;
  const categoria_Card({Key? key, required this.categoria}) : super(key: key);

  @override
  _categoria_CardState createState() => _categoria_CardState();
}

class _categoria_CardState extends State<categoria_Card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 20,
          shadowColor: Colors.orange,
          child: Row(

        children: [
          SizedBox(width: 20,),
          Container(
            width: 100,
            height: 150,
            child: PhotoView(
                imageProvider: NetworkImage(widget.categoria.imagen),
                backgroundDecoration: BoxDecoration(
                  color: Colors.transparent
                ),
                loadingBuilder: (context, progress) => Center(
                        child: CircularProgressIndicator(
                      color: Colors.deepOrangeAccent
                    ))),
          ),
          SizedBox(width: 40,),
          Text(
            widget.categoria.categoriaTexto,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          ),
        ],
      )),
    );
  }
}
