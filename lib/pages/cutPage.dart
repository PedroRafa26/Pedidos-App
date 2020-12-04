import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedidos_app/modals/PedidoItem.dart';

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
                child: ListTile(
                  key: Key(pedido.id),
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
