import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:tienda_test/constants.dart';
import 'package:tienda_test/screens/principal/home.dart';

class onboardPrueba extends StatefulWidget {
  const onboardPrueba({Key? key}) : super(key: key);

  @override
  _onboardPruebaState createState() => _onboardPruebaState();
}

class _onboardPruebaState extends State<onboardPrueba> {
  late LiquidController liquidcontroller;
  TextEditingController controllerName =  TextEditingController();


  @override
  void initState() {
    liquidcontroller = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF96ceb4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/online-shopping.png"),
            Text("Bienvenido a Claudios store",style: estilo1(),)
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFffeead),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/shopping-bag.png",height: 300,width: 300,),
            Text("Una compra rapida con un solo click",style: estilo1(),)
          ],
        ),
      ),
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFff6f69),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/shopping.png",),
              Text("Encontraras lo que mas te gusta",style: estilo1())
            ],
          ))
    ];
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            waveType: WaveType.liquidReveal,
            enableLoop: false,
            enableSideReveal: true,
            slideIconWidget: Icon(Icons.arrow_forward_ios),
            liquidController: liquidcontroller,
            pages: pages
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: FlatButton(
                onPressed: () {
                  opendialog();
                },
                child: Text("iniciar"),
                color: Colors.white.withOpacity(0.01),
              ),
            ),
          ),

        ],
      ),
    );

  }
  Future opendialog()=>showDialog(context: context, builder:(context)=>
      AlertDialog(
        title: Text("¿Como te gustaria que te llamaramos?"),
        content:TextField(
          controller: controllerName,
          decoration: InputDecoration(hintText: 'Ingresa tu nombre preferido'),
        ),
        actions: [
          TextButton(onPressed: () async{

           await  FirebaseAuth.instance.currentUser?.updateDisplayName(controllerName.text);
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));


          }, child: Text("Listo"))
        ],

      )
  );
}
