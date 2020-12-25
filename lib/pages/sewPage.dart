import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedidos_app/modals/PedidoItem.dart';
import 'package:pedidos_app/widgets/pedidoDetails.dart';

// ignore: must_be_immutable
class SewPage extends StatefulWidget {
  SewPage({Key key, @required this.pedidosRef}) : super(key: key);

  CollectionReference pedidosRef;

  @override
  _SewPageState createState() => _SewPageState();
}

class _SewPageState extends State<SewPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this
          .widget
          .pedidosRef
          .where('comprado', isEqualTo: true)
          .where('cortado', isEqualTo: true)
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
              final GlobalKey expansionTileKey = GlobalKey();
          PedidoItem pedido = PedidoItem.from(document);
          void onDismissed(DismissDirection direction) {
              if(direction == DismissDirection.endToStart){
                document.reference.update({'cortado': false});
              }
              if(direction == DismissDirection.startToEnd){
                document.reference.delete();
              }
            }
          return PedidoDetails(
            pedido:pedido,
            document: document,
            onDismissed: onDismissed,
            expansionTileKey: expansionTileKey,
            action: "Terminada",
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