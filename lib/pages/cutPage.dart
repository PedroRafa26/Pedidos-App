import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedidos_app/modals/PedidoItem.dart';

import '../contantes.dart';

// ignore: must_be_immutable
class CutPage extends StatefulWidget {
  CutPage({Key key, @required this.pedidosRef}) : super(key: key);

  CollectionReference pedidosRef;

  @override
  _CutPageState createState() => _CutPageState();
}

class _CutPageState extends State<CutPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this
          .widget
          .pedidosRef
          .where('comprado', isEqualTo: true)
          .where('cortado', isEqualTo: false)
          .snapshots(),
      builder: _buildPedidosList,
    );
  }

  void _scrollToSelectedContent({GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }


  Widget _buildPedidosList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (snapshot.data.docs.length == 0) {
        return _buildEmptyMessage();
      } else {
        return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
          final GlobalKey expansionTileKey = GlobalKey();
          PedidoItem pedido = PedidoItem.from(document);
          return Dismissible(
            key: Key(pedido.id),
            background: Container(
              color: Colors.greenAccent,
              child: Center(
                child: Text(
                  "Cortado",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if(direction == DismissDirection.endToStart){
                document.reference.update({'comprado': false});
              }
              if(direction == DismissDirection.startToEnd){
                document.reference.update({'cortado': true});
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Card(
                  child: ExpansionTile(
                    key: expansionTileKey,
                    onExpansionChanged: (value) {
                      if (value) {
                        _scrollToSelectedContent(
                            expansionTileKey: expansionTileKey);
                      }
                    },
                    childrenPadding: EdgeInsets.only(bottom: 10),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          key: Key(pedido.id),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Text("Destinatario: ${pedido.destinatario}"),
                                  Text(
                                      "Color: ${pedido.color == null ? "Sin color" : pedido.color}"),
                                  Text("Talla: ${pedido.talla}"),
                                  Text(
                                    "Fecha de Entrega:\n${pedido.fechaEntrega.toDate().day} / ${pedido.fechaEntrega.toDate().month} / ${pedido.fechaEntrega.toDate().year}",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MACUNROSE,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(
                                    Icons.image,
                                    size: 75,
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              //TODO agregar funcionalidad de edición.
                              showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text("Editado"),
                                  content: Text(
                                    "Sección en Construcción",
                                  ),
                                ),
                              );
                              print("Editado");
                            },
                            child: Text(
                              "Editar",
                              style: TextStyle(color: MACUNROSE),
                            ),
                          ),
                          OutlinedButton(
                            key: Key(pedido.id),
                            onPressed: () {
                              print("Eliminar");
                              document.reference.delete();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Eliminar",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                    title: Text("${pedido.modelo}"),
                  ),
                ),
            ),
          );
        }).toList());
      }
    }
  }

  Widget _buildEmptyMessage() {
    return Center(
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            size: 40,
            color: Colors.blueGrey,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text("No hay pedidos pendientes por cortar"),
          )
        ],
      ),
    );
  }
}
