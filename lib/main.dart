// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:parcial2_2506632017/src/models/datos_model.dart';

//Estudiante: Rodríguez Cruz, Hugo Alexander; Carnet: 25-0663-2017

void main() => runApp(Parcial2());

class Parcial2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.file_copy_rounded),
          title: Text('Parcial 2'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.deepPurpleAccent.shade700,
          child: FutureBuilder(
            future: _getDatos(),
            builder: (context, snapshot){

              if(snapshot.hasData){
                final datos = snapshot.data;

                return _crearListViewDatos(context, datos);
              } else if (snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              } else{
                return Center(child: CircularProgressIndicator());
              }

            },
          ),
        )
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.deepPurple),
      ),
    );
  }
}

Future<List<DatosModel>> _getDatos() async {
  List<DatosModel> datos = [];

  Uri uri = Uri.parse('https://utecclass.000webhostapp.com/post.php');
  final response = await http.get(uri);

  if(response.statusCode == 200){
    final stringData = utf8.decode(response.bodyBytes);
    final jsonData = jsonDecode(stringData);

    for(var dato in jsonData){
      datos.add(DatosModel(dato['id'], dato['title'], dato['status'], dato['content'], dato['user_id']));
    }
  } else {
    print('No se pudo');
  }

  return datos;
}

Widget _crearListViewDatos(BuildContext context, data){
  List items = data;
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, i) => Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.shade200,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 3.0,
              offset: Offset(0.0, 5.0)
            )
          ]
        ),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(items[i].content, style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
                Text(items[i].title, style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}