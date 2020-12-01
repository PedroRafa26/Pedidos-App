import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CutPage extends StatefulWidget {
  // CutPage({Key key, @required this.pedidosRef}) : super(key: key);

  // CollectionReference pedidosRef;

  @override
  _CutPageState createState() => _CutPageState();
}

class _CutPageState extends State<CutPage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.red
    );
  //   return StreamBuilder(
  //     stream: this
  //         .widget
  //         .pedidosRef
  //         .where('comprado', isEqualTo: false)
  //         .snapshots(),
  //     builder: _buildPedidosList,
  //   );
  // }

  // Widget _buildPedidosList(
  //     BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //   if (!snapshot.hasData) {
  //     return Center(child: CircularProgressIndicator());
  //   } else {
  //     if (snapshot.data.docs.length == 0) {
  //       return _buildEmptyMessage();
  //     }else{
  //       return Center(child: Text("Aqui ira todo"));
  //     }
  //   }
  // }

  // Widget _buildEmptyMessage() {
  //   return Flex(
  //     direction: Axis.vertical,
  //     children: [
  //       Icon(
  //         Icons.check,
  //         size: 40,
  //         color: Colors.blueGrey,
  //       ),
  //       SizedBox(
  //         height: 20,
  //       ),
  //       Center(
  //         child: Text("No hay pedidos pendientes por cortar"),
  //       )
  //     ],
  //   );
  // }
  }
}
