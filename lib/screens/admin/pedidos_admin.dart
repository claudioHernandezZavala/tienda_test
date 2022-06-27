import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tienda_test/clases/pedidos.dart';
class pedidos_Admin extends StatefulWidget {
  const pedidos_Admin({Key? key}) : super(key: key);

  @override
  _pedidos_AdminState createState() => _pedidos_AdminState();
}

class _pedidos_AdminState extends State<pedidos_Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Mis pedidos"),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseDatabase.instance.reference().child("Pedidos").onValue,
              builder: (context,AsyncSnapshot snapshot){
               if(snapshot.hasData&&snapshot.data.snapshot.value!=null){
                 //List<pedido> pedidos = [];
                 //DataSnapshot valores = snapshot.data.snapshot;
                 //Map<dynamic, dynamic> values = valores.value;
                   DatabaseReference ref = FirebaseDatabase.instance.reference().child("Pedidos");
                   ref.get().then((DataSnapshot snapshot)  {

                       var keys =  snapshot.value.keys;
                       print(keys);
                       dynamic data = snapshot.value;

                       for (var keyindividual in keys){

                       }
                   });







                 
               }
               return const Center(child: Text("claudio"));
              }
          
          
          
          )
        ],
      ),
    );
  }
}
