import 'package:flutter/material.dart';
import 'package:pharma_shop/model/client.dart';

class AdminClientDetailPage extends StatefulWidget {

  final Client client;

  AdminClientDetailPage({@required this.client});

  @override
  _AdminClientDetailPageState createState() => _AdminClientDetailPageState();
}

class _AdminClientDetailPageState extends State<AdminClientDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.client.email}"),
      ),
    );
  }
}
