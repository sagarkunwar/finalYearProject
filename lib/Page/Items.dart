
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokari/Services/product_page.dart';

class itempage extends StatelessWidget {
  final CollectionReference _productRef =
  FirebaseFirestore.instance.collection("Product");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Text('Items',
              textAlign:TextAlign.center,
            ),
          ),
          backgroundColor: Color(0xFFA2CC08) ,
          elevation: 0.0,
        ),

        body: Center(
          child: Container(
            child: Stack(
              children: [
                FutureBuilder<QuerySnapshot>(
                  future: _productRef.get(),
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Scaffold(
                        body: Center(
                          child: Text("Error: ${snapshot.error}"),
                        ),
                      );
                    }

                    // Collection is ready to display
                    if(snapshot.connectionState== ConnectionState.done){
                      return ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            top: 10.0
                        ),
                        children: snapshot.data.docs.map((document){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder:(context) => ProductPage( productId: document.id,)
                                  )
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              height: 200.0 ,
                              margin: EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 10.0,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 200.0,
                                    width: 400.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        "${document.data()['image'][0]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            document.data()['name']??"Product Name",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          Text(
                                            "\Per kg Rs${document.data()['Price']}" ?? 'Price',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600),)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }

                    //Loading State
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
