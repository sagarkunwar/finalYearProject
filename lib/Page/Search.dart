import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Search Items'),),
      body: Container(
        child: Column(
          children:<Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: ()=> searchController.clear(),
                  ),
                  hintText: 'Search here1',
                ),
              ),
            ),

          ]
        ),
      )
    );
  }
}
