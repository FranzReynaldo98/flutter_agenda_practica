import 'package:flutter/material.dart';
import 'empresa.dart';

import 'package:appmiagenda/page_registro_empresa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

class PaginaListadoEmpresas extends StatefulWidget {
  PaginaListadoEmpresas({Key? key}) : super(key: key);

  @override
  _PaginaListadoEmpresasState createState() => _PaginaListadoEmpresasState();
}

class _PaginaListadoEmpresasState extends State<PaginaListadoEmpresas> {
  @override
  Widget build(BuildContext context) {
    return Center(
       child: new StreamBuilder(
         stream: FirebaseFirestore.instance.collection("empresa").snapshots(),
         //initialData: initialData ,
         builder: (BuildContext context,AsyncSnapshot snapshot){
           if(!snapshot.hasData){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           List<DocumentSnapshot> docs=snapshot.data.docs;
          return Container(
            child: 
               ListView.builder(
                itemCount: docs.length,           
                itemBuilder: (_,i){
                  DocumentSnapshot ds=snapshot.data.docs[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.white, boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                
                                children: [
                                  Icon(Icons.house,color: Colors.black54,),
                                  Padding(padding: EdgeInsets.symmetric(horizontal:3)),
                                  Text(
                                    "${ds['nombre_empresa']}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color:Colors.black54)),
                                ],
                              ),
                              SizedBox(
                                height:5
                              ),
                              Row(
                                children: [
                                  Icon(Icons.directions,color: Colors.black54,),
                                  Padding(padding: EdgeInsets.symmetric(horizontal:3)),
                                  Text(
                                    "${ds['direccion']}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:5
                              ),
                              Row(
                                children: [
                                  Icon(Icons.person,color: Colors.black54,),
                                  Padding(padding: EdgeInsets.symmetric(horizontal:3)),
                                  Text(
                                    "${ds['responsable']}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:5
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone,color: Colors.black54,),
                                  Padding(padding: EdgeInsets.symmetric(horizontal:3)),
                                  Text(
                                    "${ds['telefono_contacto']}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:5
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone_callback,color: Colors.black54,),
                                  Padding(padding: EdgeInsets.symmetric(horizontal:3)),
                                  Text(
                                    "${ds['telefono_emergencia']}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:5
                              ),
                              Row(
                                children: [
                                  Icon(Icons.email,color: Colors.black54,),
                                  Padding(padding: EdgeInsets.symmetric(horizontal:3)),
                                  Text(
                                    "${ds['correo']}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)  
                                  ),
                                ],
                              ),
                            ],
                         ),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             FloatingActionButton(
                                heroTag: null,
                                tooltip: "Modificar",
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.blue,
                                elevation: 0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.edit),
                                    
                                  ],
                                ),
                                onPressed: (){
                                      final player = AudioCache();
                                      player.play('SD_NAVIGATE_51.mp3');
                                      Navigator.push(
                                        context, 
                                        MaterialPageRoute(
                                          builder: 
                                          (context)=>PageRegistroEmpresa(Empresa(ds.id,ds['nombre_empresa'],ds['direccion'],ds['responsable'],ds['telefono_contacto'],ds['telefono_emergencia'],ds['correo'],),),),);
                                    }
                              ),
                              FloatingActionButton(
                                heroTag: null,
                                tooltip: "Eliminar",
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.red,
                                elevation: 0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.delete),
                                    
                                  ],
                                ),
                                onPressed: (){
                                  final player = AudioCache();
                                  player.play('SD_NAVIGATE_51.mp3');
                                  eliminar(ds.id);      
                                }
                              ),
                           ],
                         ), 
                    ])),
                  );
                },
              ),
          );
         },
       ),
    );
  }
  void eliminar(String id){
    DocumentReference documentReference=FirebaseFirestore.instance.collection("empresa").doc(id);
    documentReference.delete().whenComplete(() => {});
  }
}