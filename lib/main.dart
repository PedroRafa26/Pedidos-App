import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pedidos_app/contantes.dart';
import 'package:pedidos_app/modals/PedidoItem.dart';
import 'package:pedidos_app/pages/addPedidoAlertDialog.dart';
import 'package:pedidos_app/pages/cutPage.dart';
import 'package:pedidos_app/pages/sewPage.dart';
import 'package:pedidos_app/pages/shopPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedidos App',
      theme: ThemeData.light().copyWith(
        accentColor: Color(0xFFE1AFE0),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CollectionReference _pedidosRef;
  int _actualPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _getPedidos();
  }

  void _getPedidos() async {
    await Firebase.initializeApp();
    // EmailAuthProvider.credential(email: EMAIL, password: PASSWORD);
    print("Inicio de la petición");
    var pedidosRef = FirebaseFirestore.instance.collection("pedidos");
    print(_pedidosRef);
    setState(() {
      _pedidosRef = pedidosRef;
    });
  }

  Widget _buildBody() {
    if (_pedidosRef == null) {
      print("Aun no hay data");
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      print("Actualmente navegando en: " + _actualPageIndex.toString());
      switch (_actualPageIndex) {
        case 0:
          print("Entrando en caso 1");
          return ShopPage(
            pedidosRef: _pedidosRef,
          );
          break;
        case 1:
          return CutPage(
            pedidosRef: _pedidosRef,
          );
          break;
        case 2:
          return SewPage(
            pedidosRef: _pedidosRef,
          );
        default:
          return Center(
            child: Text("Esto no debería aparecer nunca"),
          );
      }
    }
  }

  // List<Widget> _pages = [
  //   CutPage(),
  //   ShopPage(),
  //   SewPage(),
  // ];
  _onTapSelector(index) {
    setState(() {
      _actualPageIndex = index;
    });
  }

  _addPedido() async {
    PedidoItem pedido = await showDialog(
      context: context,
      builder: (_)=>AddPedidoAlertDialog()
    );
    if(pedido != null){
      await _pedidosRef.add(pedido.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Macundales Pedidos"),
        backgroundColor: MACUNROSE,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _actualPageIndex,
        onTap: _onTapSelector,
        selectedItemColor: MACUNROSE,
        items: [
          BottomNavigationBarItem(
            label: "Comprar",
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            label: "Cortar",
            icon: Icon(Icons.cut),
          ),
          BottomNavigationBarItem(
            label: "Coser",
            icon: Icon(Icons.workspaces_filled),
          ),
        ],
        showSelectedLabels: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MACUNROSE,
        child: Icon(Icons.add),
        onPressed: _addPedido,
      ),
    );
  }
}
