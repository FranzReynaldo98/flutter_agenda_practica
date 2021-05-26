
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'empresa.dart';
import 'package:image_picker/image_picker.dart';


class PageRegistroEmpresa extends StatefulWidget {
  
  Empresa empresa;
  PageRegistroEmpresa(this.empresa);

  @override
  _PageRegistroEmpresaState createState() => _PageRegistroEmpresaState();
}

class _PageRegistroEmpresaState extends State<PageRegistroEmpresa> {
  TextEditingController? _nombreController;
  TextEditingController? _direccionController;
  TextEditingController? _responsableController;
  TextEditingController? _telefonocontactoController;
  TextEditingController? _telefonoemergenciaController;
  TextEditingController? _correoController;
  File? selected_imagen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreController = new TextEditingController(text: widget.empresa.getnombre);
    _direccionController = new TextEditingController(text: widget.empresa.getdireccion);
    _responsableController = new TextEditingController(text: widget.empresa.getresponsable);
    _telefonocontactoController = new TextEditingController(text: widget.empresa.gettelefonocontacto);
    _telefonoemergenciaController = new TextEditingController(text: widget.empresa.gettelefonoemergencia);
    _correoController = new TextEditingController(text: widget.empresa.getcorreo);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Empresas"),
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
                  ElevatedButton(
                    onPressed: () async{
                      final image=  await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                      print(image);
                      setState((){
                        selected_imagen=File(image!.path);
                      });
                    }, 
                    child: Icon(Icons.camera_alt)
                  ),
                  if(selected_imagen!=null)
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.file(selected_imagen!)
                    ),
                  
                  Divider(height:3,),
                  TextFormField(
                    controller: _responsableController,
                    decoration: InputDecoration(
                      labelText: "Responsable",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Divider(height: 3,),
                  TextFormField(
                    controller: _telefonocontactoController,
                    decoration: InputDecoration(
                      labelText: "Teléfono Contacto",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Divider(height: 3,),
                  TextFormField(
                    controller: _telefonoemergenciaController,
                    decoration: InputDecoration(
                      labelText: "Teléfono Emergencia",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Divider(height: 3,),
                  TextFormField(
                    controller: _correoController,
                    decoration: InputDecoration(
                      labelText: "Correo",
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
                            Text(widget.empresa.getid.isEmpty?"Registrar":"Modificar"),
                            Icon(Icons.save),
                        ],
                      ),
                      
                      onPressed: (){
                        widget.empresa.getid.isEmpty?registrar(widget.empresa):modificar(widget.empresa);
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
                        primary:Colors.redAccent
                      ),
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

  void modificar(Empresa empresa){
    DocumentReference documentReference=FirebaseFirestore.instance.collection("empresa").doc(widget.empresa.getid);
   print('direccion ${_direccionController!.text}');
    Map<String,dynamic> data={
      "nombre_empresa":_nombreController!.text,
      "direccion":_direccionController!.text,
      "responsable":_responsableController!.text,
      "telefono_contacto":_telefonocontactoController!.text,
      "telefono_emergencia":_telefonoemergenciaController!.text,
      "correo":_correoController!.text
    };
    documentReference.set(data).whenComplete(() => (){});
  }

  void registrar(Empresa empresa){
    DocumentReference documentReference=FirebaseFirestore.instance.collection("empresa").doc(_nombreController!.text);
    Map<String,dynamic> data={
      "nombre_empresa":_nombreController!.text,
      "direccion":_direccionController!.text,
      "responsable":_responsableController!.text,
      "telefono_contacto":_telefonocontactoController!.text,
      "telefono_emergencia":_telefonoemergenciaController!.text,
      "correo":_correoController!.text
    };
    documentReference.set(data).whenComplete(() => (){});
    //FirebaseFirestore.instance.collection("empresa").add(data);
  }
}