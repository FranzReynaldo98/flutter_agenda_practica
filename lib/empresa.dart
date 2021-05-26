import 'package:firebase_database/firebase_database.dart';

class Empresa{
  String _id ="";
  String _nombre="";
  String _direccion="";
  String _responsable="";
  String _telefonocontacto="";
  String _telefonoemergencia="";
  String _correo="";

  
  Empresa(this._id,this._nombre,this._direccion,this._responsable,this._telefonocontacto,this._telefonoemergencia,this._correo);
  String get getid=>_id;
  String get getnombre=>_nombre;
  String get getdireccion=>_direccion;
  String get getresponsable=>_responsable;
  String get gettelefonocontacto=>_telefonocontacto;
  String get gettelefonoemergencia=>_telefonoemergencia;
  String get getcorreo=>_correo;
  

  set setid(String id)=>this._id=id;
  set setnombre(String nombre)=>this._nombre=nombre;
  set setdireccion(String direccion)=>this._direccion;
  set setresponsable(String responsable)=>this._responsable;
  set settelefonocontacto(String telefonocontacto)=>this._telefonocontacto;
  set settelefonoemergencia(String telefonoemergencia)=>this._telefonoemergencia;
  set setcorreo(String correo)=>this._correo;
  
  Empresa.map(dynamic obj){
    this._nombre=obj['nombre_empresa'];
    this._direccion=obj['direccion'];
    this._responsable=obj['responsable'];
    this._telefonocontacto=obj['telefono_contacto'];
    this._telefonoemergencia=obj['telefono_emergencia'];
    this._correo=obj['correo'];
  }
  Empresa.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _nombre = snapshot.value['nombre_empresa'];
    _direccion = snapshot.value['direccion'];
    _responsable = snapshot.value['responsable'];
    _telefonocontacto = snapshot.value['telefono_contacto'];
    _telefonoemergencia = snapshot.value['telefono_emergencia'];
    _correo = snapshot.value['correo'];
  }
  Empresa.empty();
}
