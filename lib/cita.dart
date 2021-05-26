import 'package:firebase_database/firebase_database.dart';
class Cita{
  String _id="";
  String _idempresa="";
  String _nombre="";
  String _direccion="";
  String _fecha="";
  String _hora="";
  Cita(this._id,this._idempresa,this._nombre,this._direccion,this._fecha,this._hora);
  String get getid=>_id;
  String get getidempresa=>_idempresa;
  String get getnombre=>_nombre;
  String get getdireccion=>_direccion;
  String get getfecha=>_fecha;
  String get gethora=>_hora;
  

  set setid(String id)=>this._id=id;
  set setidempresa(String idempresa)=>this._idempresa=idempresa;
  set setnombre(String nombre)=>this._nombre=nombre;
  set setdireccion(String direccion)=>this._direccion;
  set setfecha(String fecha)=>this._fecha;
  set sethora(String hora)=>this._hora;
  Cita.map(dynamic obj){
    this._idempresa=obj['id_empresa'];
    this._nombre=obj['nombre_empresa'];
    this._direccion=obj['direccion'];
    this._fecha=obj['responsable'];
    this._hora=obj['telefono_contacto'];
  }
  Cita.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _idempresa = snapshot.value['id_empresa'];
    _nombre = snapshot.value['nombre_empresa'];
    _direccion = snapshot.value['direccion'];
    _fecha = snapshot.value['fecha'];
    _hora = snapshot.value['hora'];
  }
  Cita.empty();

}