import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CollectionReference _productRef = FirebaseFirestore.instance.collection("Product");

  final CollectionReference _userRef =
  FirebaseFirestore.instance.collection("Users"); // suru ma user ko collection ma uid ani tyo user lai cart collection ani tyo ma chai product pass garni

  User _user = FirebaseAuth.instance.currentUser;

  Future _addToCart(){
    return _userRef
        .doc(_user.uid)
        .collection("Cart")
        .doc(widget.productId)
        .set(
        {
         'ProductID' : widget.productId,
        });
  }

  final SnackBar _snackBar = SnackBar(content: Text("Product added to Tokari")
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home',textAlign:TextAlign.center,),backgroundColor: Color(0xFFA2CC08) ,
        ),
        body: Stack(
          children: [
            FutureBuilder(
              future: _productRef.doc(widget.productId).get(),
              builder: (context,snapshot){
                if(snapshot.hasError){
                  return Scaffold(

                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                if(snapshot.connectionState==ConnectionState.done){
                  Map<String, dynamic> documentData = snapshot.data.data();

                  return ListView(
                    children: [
                      Container(
                        height: 300.0,
                        child: Container(
                          height: 200.0,
                          width: 400.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                                "${documentData['image'][0]}"
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 24.0
                        ),
                        child: Text(
                            "${documentData['name']}"??"Product name",style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 24.0),
                        child: Text( "\Rs ${documentData['Price']}"??"Price",
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w600
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 24.0),
                        child: Text( "${documentData['desc']}"??"Desc",
                          style: TextStyle(
                              fontSize: 16.0
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap:() async{
                                  await _addToCart();
                                 Scaffold.of(context).showSnackBar(_snackBar);
                              } ,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(12.0)
                                  ),
                                  child: Text("Add to Tokari",style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      )

                    ],
                  );

                }


                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        )
    );
  }
}
