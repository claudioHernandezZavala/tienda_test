import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tienda_test/componentes/item_admin.dart';
import 'package:tienda_test/componentes/grid_pulseras.dart';
import 'package:tienda_test/clases/productos.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tienda_test/screens/admin/admin_agregar_producto.dart';

class listaproductos extends StatefulWidget {
  const listaproductos({Key? key}) : super(key: key);

  @override
  State<listaproductos> createState() => _listaproductosState();
}

class _listaproductosState extends State<listaproductos> {
  List<Producto> productosAdmin = [];



  void llenarArreglo() {
    Firebase.initializeApp();
    productosAdmin.clear();
    DatabaseReference ref =
        FirebaseDatabase.instance.reference().child("pulseras");
    ref.get().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      dynamic data = snap.value;

      for (var keyindividual in keys) {
        Producto ProductoNuevo = Producto(
            data[keyindividual]['imagen'],
            data[keyindividual]['nombre'],
            data[keyindividual]['descripcion'],
            data[keyindividual]['precio'],
            data[keyindividual]['material'],
            Color(0xFF524175),
            data[keyindividual]['categoria'],
            keyindividual);
        productosAdmin.add(ProductoNuevo);
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference postref = FirebaseDatabase.instance.reference();

    return Scaffold(
      appBar: AppBar(
        title: Text("Mis productos"),
      ),
      body: StreamBuilder(
        stream:
            FirebaseDatabase.instance.reference().child('pulseras').onValue,
        builder: (context, AsyncSnapshot snapshot) {
          var count = 2;
          double espacio = 15;
          double aspetr = 0.75;
          if (MediaQuery.of(context).size.width > 700) {
            count = 6;
            espacio = 2;
            aspetr = 1.25;
          }
          if(snapshot.hasData&&snapshot.data.snapshot.value!=null){
            productosAdmin.clear();
            DataSnapshot valor =  snapshot.data.snapshot;
            Map<dynamic,dynamic>valores =  valor.value;
            valores.forEach((key, value) {
              Producto ProductoNuevo = Producto(
                  value['imagen'],
                  value['nombre'],
                  value['descripcion'],
                  value['precio'],
                  value['material'],
                  Color(0xFF524175),
                  value['categoria'],
                  key);
              productosAdmin.add(ProductoNuevo);
            });

          }
          if(snapshot.hasError){
            return Center(child: Text("Hubo un error,\nverifique su conexion a internet\n e intente de nuevo"),);
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          return productosAdmin.length == 0
              ? Center(child: Text("No hay productos"))
              : ListView.builder(
                  itemCount: productosAdmin.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      child: item_admin(producto: productosAdmin[index]),
                      actionPane: SlidableDrawerActionPane(),
                      actions: [
                        IconSlideAction(
                          caption: "Editar",
                          color: Colors.blue,
                          icon: Icons.edit,
                          onTap: () {},
                        ),
                        IconSlideAction(
                          caption: "Eliminar",
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {

                            await postref.child("pulseras").child(productosAdmin[index].key).remove();


                          },
                        )
                      ],
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Agregar_producto()));
        },
        backgroundColor:Colors.blue,
        child: Icon(Icons.add),

      ),
    );
  }
}
