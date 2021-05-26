
import 'package:appmiagenda/cita.dart';
import 'package:appmiagenda/page_registro_empresa.dart';
import 'package:appmiagenda/page_registro_cita.dart';
import 'package:appmiagenda/pagina_listado_citas.dart';
import 'package:appmiagenda/pagina_listado_empresas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'empresa.dart';
class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _pagina_actual=0;
  List<Empresa>? items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add),
         onPressed: (){
           final player = AudioCache();
           player.play('SD_NAVIGATE_51.mp3');
           if(_pagina_actual==1){
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>PageRegistroEmpresa(Empresa.empty())),
             );
           }else{
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>PageRegistroCita(Cita.empty())),
             );
           }
         },
       
       ),
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("Agenda"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
       body: _pagina_actual==0?PaginaListadoCitas():PaginaListadoEmpresas(),
       bottomNavigationBar: BottomNavigationBar(
         onTap: (index){
           setState(() {
             final player = AudioCache();
             player.play('button-click-off-click.mp3');
             _pagina_actual=index;
           });
         },
         currentIndex: _pagina_actual,
         backgroundColor: Colors.white70,
         items: [
           BottomNavigationBarItem(icon: Icon(Icons.house),label: "Principal",tooltip: "Principal"),
           BottomNavigationBarItem(icon: Icon(Icons.house_siding_rounded),label: "Listado de Empresas"),
         ],
       ),
    );
  }
  void eliminar(String id){
    DocumentReference documentReference=FirebaseFirestore.instance.collection("empresa").doc(id);
    documentReference.delete().whenComplete(() => {});
  }
}