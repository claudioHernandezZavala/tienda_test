
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:tienda_test/clases/pedidos.dart';
import 'package:tienda_test/clases/productoCarritos.dart';

import '../constants.dart';

class reciboCompra extends StatefulWidget {
  final List<ProductoCarrito> productos;
  final double  total;
  const reciboCompra({Key? key, required this.productos, required this.total}) : super(key: key);

  @override
  _reciboCompraState createState() => _reciboCompraState();
}

class _reciboCompraState extends State<reciboCompra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Recibo")),
      body: Center(
        child: Container(

          width: MediaQuery.of(context).size.width/1.2,
          height: MediaQuery.of(context).size.height/1.3,
          decoration: BoxDecoration(
              color: Colors.orange.shade200,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54.withOpacity(0.9),
                    spreadRadius: 5,
                    blurRadius: 10)
              ]),
          child: Column(
            children: [

              SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                "Resumen de compra",
                style: estiloLetras(),
              )),
              SizedBox(height: 35,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Productos",style: estiloLetras(),),
                    Text("Cantidad",style: estiloLetras(),)
                  ],
                ),
                
              ),
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.productos.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.productos[index].nombre,style: estiloLetras(),),
                            Text(widget.productos[index].cantidad,style: estiloLetras(),),
                          ],
                        ),
                      );
                    }),
              ),
             Divider(
               color: Colors.black,
               thickness: 1,
             ),
              SizedBox(height: 10,),
              Text("Total a pagar:    " + widget.total.toString() ),
              FlatButton(onPressed: (){
                User? usuario = FirebaseAuth.instance.currentUser;
                String? Nombreusuario =  usuario!.displayName;
                String usuarioID =  usuario.uid;

                DatabaseReference ref = FirebaseDatabase.instance.reference();
                ref.child("Pedidos").child(usuarioID).child("Usuario").set(Nombreusuario);
                
                List<Map<String,String>> p  = [];
                widget.productos.forEach((element) {
                  p.add(element.toMap());
                });
                String key = ref.push().toString();
                pedido pedidoNuevo = pedido(
                  p,
                  Nombreusuario!,
                  key
                );


                pedidoNuevo.productos.forEach((element) {
                  ref.child("Pedidos").child(usuarioID).push().set(element);

                });
                ref.child("carritos").child(usuarioID).remove();








              }, child: Text("Efectuar compra"),shape: StadiumBorder(),color: Colors.orange,splashColor: Colors.blue,),
              SizedBox(height: 25,),



            ],
          ),
        ),
      ),
    );
  }
}
