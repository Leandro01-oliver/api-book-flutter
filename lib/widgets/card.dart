import 'package:flutter/material.dart';

class CardBook extends StatefulWidget{
  const CardBook({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardBookState createState() => _CardBookState();
}

class _CardBookState extends State<CardBook>{
 @override
 Widget build(BuildContext context){
  return const Card(
     child: Text("olá"),
    );
 }
}