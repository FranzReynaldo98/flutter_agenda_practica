import 'package:flutter/material.dart';
import 'cita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PageRegistroCita extends StatefulWidget {
  Cita cita;
  PageRegistroCita(this.cita);
  @override
  _PageRegistroCitaState createState() => _PageRegistroCitaState();
}

class _PageRegistroCitaState extends State<PageRegistroCita> {
  TextEditingController? _nombreController;
  TextEditingController? _direccionController;
  TextEditingController? _fechaController;
  TextEditingController? _horaController;

  @override
  void initState() {
    super.initState();
    _nombreController = new TextEditingController(text: widget.cita.getnombre);
    _direccionController = new TextEditingController(text: widget.cita.getdireccion);
    _fechaController = new TextEditingController(text: widget.cita.getfecha);
    _horaController = new TextEditingController(text: widget.cita.gethora);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Citas"),
      ),
      body: 
      Form(
        child: ListView(
          children: [
            SizedBox(height:26),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: 
                Column(
                children: [
                  TextFormField(
                      controller: _nombreController,
                      decoration: InputDecoration(
                      labelText: "Empresa",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Divider(height: 3,),
                  TextFormField(
                    controller: _direccionController,
                    decoration: InputDecoration(
                      labelText: "Dirección",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Divider(height: 3,),
                  TextFormField(
                    controller: _fechaController,
                    decoration: InputDecoration(
                      labelText: "Fecha",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Divider(height: 3,),
                  TextFormField(
                    controller: _horaController,
                    decoration: InputDecoration(
                      labelText: "Hora",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                //mainAxisSize: MainAxisSize.max,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(     
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                            Text(widget.cita.getid.isEmpty?"Registrar":"Modificar"),
                            Icon(Icons.save),
                        ],
                      ),
                      //textColor: Colors.black,
                      //color: Colors.cyan,
                      onPressed: (){
                        widget.cita.getid.isEmpty?registrar(widget.cita):modificar(widget.cita);
                        Navigator.pop(context);
                      }
                    ),
                    SizedBox(width:5),
                    ElevatedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Cancelar"),
                          Icon(Icons.cancel),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent
                      ),
                      //highlightColor: Colors.red,
                      //textColor: Colors.black,
                      //color: Colors.redAccent,
                      onPressed: (){
                        Navigator.pop(context);
                      }
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  void modificar(Cita cita){
    DocumentReference documentReference=FirebaseFirestore.instance.collection("cita").doc(widget.cita.getid);
   print('direccion ${_direccionController!.text}');
    Map<String,dynamic> data={
      "id_empresa":cita.getidempresa, 
      "nombre_empresa":_nombreController!.text,
      "direccion":_direccionController!.text,
      "fecha":_fechaController!.text,
      "hora":_horaController!.text,
    };
    documentReference.set(data).whenComplete(() => (){});
  }

  void registrar(Cita cita){
    //DocumentReference documentReference=FirebaseFirestore.instance.collection("cita").doc(_nombreController!.text);
    Map<String,dynamic> data={
      "id_empresa":cita.getidempresa, 
      "nombre_empresa":_nombreController!.text,
      "direccion":_direccionController!.text,
      "fecha":_fechaController!.text,
      "hora":_horaController!.text,
    };
    //documentReference.set(data).whenComplete(() => (){});
    FirebaseFirestore.instance.collection("cita").add(data);
  }
}
