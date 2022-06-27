import 'package:flutter/material.dart';
import 'package:tienda_test/screens/admin/admin_categorias.dart';
import 'package:tienda_test/screens/admin/pedidos_admin.dart';
import 'lista_productos.dart';
class paneladminp extends StatefulWidget {
  const paneladminp({Key? key}) : super(key: key);

  @override
  _paneladminpState createState() => _paneladminpState();
}

class _paneladminpState extends State<paneladminp> {

  @override
  Widget build(BuildContext context) {
    double elevation =20;
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel de administrador"),
      ),
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left:20.0,top: 10,right: 30),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(this.context).push(MaterialPageRoute(builder: (context) =>panel_categorias()));
                },
                child: Card(

                  elevation: elevation,
                  color: Colors.orange.shade50,
                  shadowColor: Colors.orange.shade600,
                  child: Center(
                    child: Row(

                      children: [
                        Container(
                          width:100,
                          height: 100,

                          child: Icon(Icons.category,color: Colors.orangeAccent,size: 40,),
                        ),
                        Container(
                          height: 200,

                          child: Center(child: Text("Categorias",style: estilocartas(),)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>listaproductos()));
                },
              child: Padding(
                padding: const EdgeInsets.only(left:20.0,top: 50,right: 30),
                child: Card(

                  elevation: elevation,
                  color: Colors.blue.shade50,
                  shadowColor: Colors.blue.shade600,
                  child: Center(
                    child: Row(

                      children: [
                        Container(
                          width:100,
                          height: 100,

                          child: Icon(Icons.pest_control_rodent,color: Colors.blue,size: 40,),
                        ),
                        Container(
                          height: 200,

                          child: Center(child: Text("Productos",style: estilocartas(),)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>pedidos_Admin()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left:20.0,top: 50,right: 30),
                child: Card(

                  elevation: elevation,
                  color: Colors.red.shade50,
                  shadowColor: Colors.red.shade600,
                  child: Center(
                    child: Row(

                      children: [
                        Container(
                          width:100,
                          height: 100,

                          child: Icon(Icons.list_alt,color: Colors.red,size: 40,),
                        ),
                        Container(
                          height: 200,

                          child: Center(child: Text("Pedidos",style: estilocartas(),)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.only(left:20.0,top: 50,right: 30),
                child: Card(

                  elevation: elevation,
                  color: Colors.green.shade50,
                  shadowColor: Colors.green.shade600,

                  child: Center(
                    child: Row(

                      children: [
                        Container(
                          width:100,
                          height: 100,

                          child: Icon(Icons.monetization_on_rounded,color: Colors.green,size: 40,),
                        ),
                        Container(
                          height: 200,

                          child: Center(child: Text("Ventas",style: estilocartas(),)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
  TextStyle estilocartas(){
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300
    );

  }
}
