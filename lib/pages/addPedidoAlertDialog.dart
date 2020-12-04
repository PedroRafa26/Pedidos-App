import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedidos_app/modals/PedidoItem.dart';

import '../contantes.dart';

class AddPedidoAlertDialog extends StatefulWidget {
  @override
  _AddPedidoAlertDialogState createState() => _AddPedidoAlertDialogState();
}

class _AddPedidoAlertDialogState extends State<AddPedidoAlertDialog> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _destinatario = "";
  Timestamp _fechaPedido, _fechaEntrega;
  String _costo;
  String _modelo = "";
  String _talla = "";
  String _color = "";

  _savePedido() {
    final formState = _formKey.currentState;
    if (!formState.validate()) return;
    formState.save();
    Navigator.of(context).pop(PedidoItem(
      destinatario: _destinatario,
      modelo: _modelo,
      talla: _talla,
      color: _color,
      costo: _costo,
      comprado: false,
      cortado: false,
      fechaPedido: Timestamp.now(),
      fechaEntrega: Timestamp.fromDate(DateTime.now().add(Duration(days: 4)))
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Nuevo Pedido"),
          IconButton(
            icon: Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onSaved: (val) {
                  _destinatario = val != null ? val : "";
                },
                decoration: InputDecoration(labelText: "Nombre del cliente"),
                validator: (val) =>
                    val == '' ? "Porfavor ingrese un nombre" : null,
              ),
              TextFormField(
                onSaved: (val) {
                  _modelo = val;
                },
                decoration: InputDecoration(labelText: "Modelo"),
                validator: (val) =>
                    val == '' ? "Porfavor ingrese el modelo" : null,
              ),
              TextFormField(
                onSaved: (val) {
                  _color = val != null ? val : "";
                },
                decoration: InputDecoration(labelText: "Color"),
              ),
              DropdownButtonFormField(
                onChanged: (val) {},
                items: [
                  DropdownMenuItem(
                    child: (Text("XS")),
                    value: 'XS',
                  ),
                  DropdownMenuItem(
                    child: (Text("S")),
                    value: 'S',
                  ),
                  DropdownMenuItem(
                    child: (Text("M")),
                    value: 'M',
                  ),
                  DropdownMenuItem(
                    child: (Text("L")),
                    value: 'L',
                  ),
                  DropdownMenuItem(
                    child: (Text("XL")),
                    value: 'XL',
                  ),
                  DropdownMenuItem(
                    child: (Text("Medidas Personalizadas")),
                    value: 'Medidas Personalizadas',
                  ),
                ],
                onSaved: (val) {
                  _talla = val != null ? val : "";
                },
                decoration: InputDecoration(labelText: "Talla"),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (val) {
                  _costo = val != null ? val : "";
                },
                decoration: InputDecoration(labelText: "Costo"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            _formKey.currentState.reset();
          },
          child: Icon(
            Icons.delete,
            color: Colors.grey,
          ),
        ),
        RaisedButton(
          onPressed: _savePedido,
          child: Text("Agregar"),
          textColor: Colors.white,
          color: Colors.blueAccent[100],
        ),
      ],
    );
  }
}
