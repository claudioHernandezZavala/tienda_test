import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class correo extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final TextInputAction accion;
  const correo({Key? key, required this.icon, required this.hint, required this.controller, required this.accion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.withOpacity(0.5)
        ),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
          obscureText: false,
          textInputAction: accion,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 20),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(icon),
              ),
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)
          ),
        ),
      ),
    ) ;
  }
}