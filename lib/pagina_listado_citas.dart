import 'package:appmiagenda/cita.dart';
import 'package:appmiagenda/page_registro_cita.dart';
import 'package:flutter/material.dart';
import 'cita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
class PaginaListadoCitas extends StatefulWidget {
  List<Cita> Citas=[];

  @override
  _PaginaListadoCitasState createState() => _PaginaListadoCitasState();
}

class _PaginaListadoCitasState extends State<PaginaListadoCitas> {
  @override
  Widget build(BuildContext context) {
    return Center(
       child: new StreamBuilder(
         stream: FirebaseFirestore.instance.collection("cita").snapshots(),
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
                                  Icon(Icons.calendar_today_outlined,color: Colors.black54,),
                                  Padding(padding: EdgeInsets.symmetric(horizontal:3)),
                                  Text(
                                    "${ds['fecha']}",
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
                                  Icon(Icons.timer_rounded,color: Colors.black54,),
                                  Padding(padding: EdgeInsets.symmetric(horizontal:3)),
                                  Text(
                                    "${ds['hora']}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
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
                                          (context)=>PageRegistroCita(Cita(ds.id,ds["id_empresa"],ds['nombre_empresa'],ds['direccion'],ds['fecha'],ds['hora'],),),),);
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
    DocumentReference documentReference=FirebaseFirestore.instance.collection("cita").doc(id);
    documentReference.delete().whenComplete(() => {});
  }
}