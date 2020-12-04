import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoItem {
  String id;
  String destinatario = "";
  Timestamp fechaPedido, fechaEntrega;
  String costo;
  String modelo = "";
  String talla = "";
  String color = "";
  bool comprado = false, cortado = false;

  PedidoItem({
    this.id,
    this.color,
    this.comprado,
    this.cortado,
    this.costo,
    this.destinatario,
    this.fechaEntrega,
    this.fechaPedido,
    this.modelo,
    this.talla,
  });


  PedidoItem.from(DocumentSnapshot snapshot):
    id= snapshot.id,
    destinatario = snapshot["destinatario"],
    color = snapshot["color"],
    costo = snapshot["costo"],
    modelo = snapshot["modelo"],
    talla = snapshot["talla"],
    comprado = snapshot["comprado"],
    cortado = snapshot["cortado"],
    fechaPedido = snapshot["fechaPedido"],
    fechaEntrega = snapshot["fechaEntrega"];


  Map<String, dynamic> toJson(){
    return {
      "destinatario": destinatario,
      "color": color,
      "costo": costo,
      "modelo": modelo,
      "talla": talla,
      "comprado": comprado,
      "cortado": cortado,
      "fechaPedido": fechaPedido,
      "fechaEntrega": fechaEntrega
    };
  }
}
