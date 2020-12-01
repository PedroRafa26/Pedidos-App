import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      theme: ThemeData.dark(),
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
  // CollectionReference _pedidosRef;

  // @override
  // void initState() {
  //   super.initState();
  //   _getPedidos();
  // }

  // void _getPedidos() async {
  //   _pedidosRef = FirebaseFirestore.instance.collection("pedidos");
  // }

  Widget _buildBody() {
    // if (_pedidosRef == null) {
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    // } else {
      switch (_actualPageIndex) {
        case 0:
          return CutPage(
            // pedidosRef: _pedidosRef,
          );
          break;
        case 1:
          return ShopPage();
          break;
        case 2:
          return SewPage();
        default:
          return Center(
            child: Text("Esto no debería aparecer nunca"),
          );
      // }
    }
  }

  // List<Widget> _pages = [
  //   CutPage(),
  //   ShopPage(),
  //   SewPage(),
  // ];
  int _actualPageIndex = 0;

  _onTapSelector(index) {
    setState(() {
      _actualPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _actualPageIndex,
        onTap: _onTapSelector,
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
    );
  }
}
