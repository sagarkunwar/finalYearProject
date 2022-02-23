import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../home.dart';

class CardProduct extends StatefulWidget {

  final String productID;

  CardProduct({this.productID});

  @override
  _CardProductState createState() => _CardProductState(productID: productID);
}

class _CardProductState extends State<CardProduct> {

  final String productID;

  _CardProductState({this.productID});

  final databaseReference = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int sum = 0;

  // ignore: close_sinks
  StreamController<int> controller = StreamController<int>();
  Stream stream;
  int totalValue = 0;
  Map _productMap;




 delete (BuildContext context, String document) async {
   databaseReference
     .collection('Users')
     .doc(_auth.currentUser.uid)
     .collection('Cart')
     .doc(document)
     .delete();
 // DocumentSnapshot snap = await databaseReference
 //     .collection('Cart')
 //     .doc(document)
 //     .get();
 // print("${snap.data()['Price']}");
 // totalValue = totalValue -
 //     int.parse(snap.data()['Price']);
 // controller.add(totalValue);
 setState(() {
   try {

   } catch (e) {
     print('Error in deleting is $e');
   }
 });
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Tokari',textAlign:TextAlign.center)),backgroundColor: Color(0xFFA2CC08)),
      body: ListView(
        children: [
          //First Future Builder
          FutureBuilder(
              future: databaseReference
                  .collection('Users')
                  .doc(_auth.currentUser.uid)
                  .collection('Cart')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                sum = 0;

                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                      children: snapshot.data.docs
                          .map<Widget>((QueryDocumentSnapshot document) {
                        return

                          //new Future Builder
                         FutureBuilder(
                            future: databaseReference
                                .collection('Product')
                                .doc(document.id)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> productSnap) {
                              if (productSnap.hasError) {
                                return Scaffold(
                                  body: Center(
                                    child: Text("Error: ${snapshot.error}"),
                                  ),
                                );
                              }

                              if (productSnap.hasData) {
                                _productMap = productSnap.data.data();
                                // print('The product Map data zis $_productMap');

                                if (_productMap == null) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 24.0,
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8.0),
                                                  child: Container(
                                                    color: Colors.grey,
                                                    width: 90,
                                                    height: 90,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 16.0, left: 20.0),
                                                child: Icon(
                                                  Icons.warning,
                                                  color: Colors.white,
                                                  size: 50,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Container(
                                              margin:
                                              EdgeInsets.only(left: 20.0),
                                              child: Text(
                                                'Sorry some error occurred. This usually occurs when the product is deleted from the database. Sorry for any inconveniences.',
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.deepOrange,
                                                ),
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  );
                                } else {
                                  List price = [];
                                  price.add(
                                      int.parse(_productMap['Price']));
                                  calculatePrice(price);

                                  // print('Product Map is null so going to execute else clause');
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 24.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            child: Image.network(
                                              "${_productMap['image'][0]}",
                                              fit: BoxFit.cover,
                                            )

                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${_productMap['name']}" ??
                                                    'Sorry some error occurred',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: Text(
                                                  "Nrs. ${_productMap['Price']}" ??
                                                      'Please try again later',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),

                                            ],

                                          ),

                                        ),
                                        IconButton(icon: Icon(Icons.delete), onPressed:() {delete(context,document.id);},),],
                                    ),
                                  );
                                }
                              }
                              print('Else clause is executed with no error!');
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.deepOrange,
                                    valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                                  ),
                                ),
                              );
                            },
                                                  );
                      }).toList(),
                    );
                  }
                }

                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.deepOrange,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                );
              }),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          StreamBuilder(
              stream: stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Total Sum is ' + snapshot.data.toString() ?? "0",
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return Text(
                    'Total Price is: 0',
                    style: TextStyle(color: Colors.white),
                  );
                }
              })
        ],
      ),
    );


  }




  calculatePrice(List price) {
    print("${price.toString()} ---------- $sum");
    for (int i = 0; i < price.length; i++) {
      sum = sum + price[i];
    }
    totalValue = sum;
    controller.add(sum);
    print('Total sum is $sum');
  }
}