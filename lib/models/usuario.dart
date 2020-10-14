
import 'dart:convert';
Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.online,
        this.nombre,
        this.apellido,
        this.telefono,
        this.email,
        this.uid,
    });

    bool online;
    String nombre;
    String apellido;
    String telefono;
    String email;
    String uid;
    

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        nombre: json["nombre"],
        apellido:json["apellido"],
        telefono:json["telefono"],
        email: json["email"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "nombre": nombre,
        "apellido":apellido,
        "telefono":telefono,
        "email": email,
        "uid": uid,
    };
}
