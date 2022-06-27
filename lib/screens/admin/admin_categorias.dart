import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tienda_test/screens/admin/admin_agregar_categoria.dart';
import 'package:tienda_test/componentes/card_categorias.dart';
import 'package:tienda_test/clases/categoria.dart';
import 'package:tienda_test/componentes/recordatorios.dart';
import 'package:tienda_test/constants.dart';
import 'package:tienda_test/widgets/resultado_vacio.dart';
class panel_categorias extends StatefulWidget {
  const panel_categorias({Key? key}) : super(key: key);

  @override
  _panel_categoriasState createState() => _panel_categoriasState();
}

class _panel_categoriasState extends State<panel_categorias> {
  DatabaseReference postref = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          recordatorio(recordatorio_texto:"Recuerda que puedes eliminar \nuna categoria deslizandola\n a la derecha"),
          SizedBox(height: 50,),
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child("categorias")
                  .orderByKey()
                  .onValue,
              builder: (context,AsyncSnapshot snapshot){
                List<Categoria> categorias = [];
                if(snapshot.hasData&&snapshot.data.snapshot.value!=null){
                  categorias.clear();
                  DataSnapshot valor =  snapshot.data.snapshot;
                  Map<dynamic,dynamic>valores =  valor.value;
                  valores.forEach((key, value) {
                    Categoria categorianueva =  Categoria(
                      value["imagen"],
                      value['categoria'],
                      key
                    );
                    categorias.add(categorianueva);
                  });
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                  return Center(child: Text("Revisa tu conexion a interner\n e intenta de nuevo",style: estiloLetras(),),);
                }

            return categorias.isEmpty?vacio(elemento: "Categorias vacias",imagen: "assets/cupcake.png",) :Expanded(
              child: ListView.builder(
                  itemCount: categorias.length,
                  
                  itemBuilder: (context,index){
                    return Slidable(

                      child: categoria_Card(categoria: categorias[index],),
                      actionPane: SlidableDrawerActionPane(

                      ),
                      actions: [

                        IconSlideAction(
                          caption: "Eliminar",
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {

                            await postref.child("categorias").child(categorias[index].key).remove();


                          },
                        )
                      ],
                    );
              }),
            );

          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>admin_agregar_categoria()));
        },
        backgroundColor: Colors.orange,
        tooltip: "Agregar categoria nueva",
        child: Icon(Icons.add,color: Colors.white,),
        elevation: 20,
        splashColor: Colors.orange.shade700,

      ),
    );
  }
}


