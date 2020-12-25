import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedidos_app/modals/PedidoItem.dart';
import '../contantes.dart';

// ignore: must_be_immutable
class PedidoDetails extends StatefulWidget {
  PedidoDetails({Key key,this.action, this.document, this.pedido, this.expansionTileKey, this.onDismissed})
      : super(key: key);

  final Function onDismissed;
  DocumentSnapshot document;
  PedidoItem pedido;
  String action;
  GlobalKey expansionTileKey;

  @override
  _PedidoDetailsState createState() => _PedidoDetailsState();
}

class _PedidoDetailsState extends State<PedidoDetails> {

  //Manejo de los details
  void _scrollToSelectedContent({GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.widget.pedido.id),
      background: Container(
        color: MACUNROSE,
        child: Center(
          child: Text(
            "Tela ${this.widget.action}",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onDismissed: this.widget.onDismissed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onLongPress: () {
            showDialog(
              context: context,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      key: Key(this.widget.pedido.id),
                      onPressed: () {
                        print("Eliminar");
                        this.widget.document.reference.delete();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Eliminar",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          child: Card(
            child: ExpansionTile(
              key: this.widget.expansionTileKey,
              onExpansionChanged: (value) {
                if (value) {
                  _scrollToSelectedContent(
                      expansionTileKey: this.widget.expansionTileKey);
                }
              },
              childrenPadding: EdgeInsets.only(bottom: 10),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    key: Key(this.widget.pedido.id),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                                "Destinatario: ${this.widget.pedido.destinatario}"),
                            Text(
                                "Color: ${this.widget.pedido.color == null ? "Sin color" : this.widget.pedido.color}"),
                            Text("Talla: ${this.widget.pedido.talla}"),
                            Text(
                              "Fecha de Entrega:\n${this.widget.pedido.fechaEntrega.toDate().day} / ${this.widget.pedido.fechaEntrega.toDate().month} / ${this.widget.pedido.fechaEntrega.toDate().year}",
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
                      key: Key(this.widget.pedido.id),
                      onPressed: () {
                        print("Eliminar");
                        this.widget.document.reference.delete();
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
              title: Text("${this.widget.pedido.modelo}"),
            ),
          ),
        ),
      ),
    );
  }
}
