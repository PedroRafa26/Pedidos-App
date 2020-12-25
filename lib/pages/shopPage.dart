import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedidos_app/modals/PedidoItem.dart';
import 'package:pedidos_app/widgets/pedidoDetails.dart';

import '../contantes.dart';

// ignore: must_be_immutable
class ShopPage extends StatefulWidget {
  ShopPage({Key key, @required this.pedidosRef}) : super(key: key);

  CollectionReference pedidosRef;

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this
          .widget
          .pedidosRef
          .where('comprado', isEqualTo: false)
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
          //Key para trabajar el autoScroll al enpandir
          final GlobalKey expansionTileKey = GlobalKey();
          PedidoItem pedido = PedidoItem.from(document);
          void onDismissed(DismissDirection direction) {
            document.reference.update({'comprado': true});
          }

          return PedidoDetails(
            document: document,
            pedido: pedido,
            expansionTileKey: expansionTileKey,
            onDismissed: onDismissed,
            action: "Comprada",
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
            child: Text("No hay pedidos pendientes por comprar tela"),
          )
        ],
      ),
    );
  }
}
