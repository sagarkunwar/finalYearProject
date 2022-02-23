
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tokari/Services/product_page.dart';

import '../home.dart';

class CartScreen extends StatefulWidget {
  final String ProductId;
  CartScreen({this.ProductId});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String ProductId;
  _CartScreenState({this.ProductId});
  final CollectionReference _productRef = FirebaseFirestore.instance.collection("Product");

  final CollectionReference _userRef = FirebaseFirestore.instance.collection("Users");
  User _user = FirebaseAuth.instance.currentUser;

  deleteProduct (BuildContext context, int index )async{
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(_user.uid)
        .collection('Cart')
        .doc(ProductId)
        .delete();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tokari',textAlign:TextAlign.center),backgroundColor: Color(0xFFA2CC08)),
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _userRef.doc(_user.uid)
                .collection("Cart").get(),
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
                // DocumentSnapshot info = snapshot.docs.data();
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      top: 10.0
                  ),
                    itemCount: snapshot.data.docs.length ,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: ()=>deleteProduct(context, index),
                              child : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: 200,
                                    height: 100,
                                    color: Colors.white,
                                    child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                    width: 90,
                    height: 90,
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                    "${snapshot.data.docs[index]['image']}",
                    fit: BoxFit.cover,),
                    ),
                    ),
                      ),



                  // child: snapshot.data.docs.map((document){
                  //   return GestureDetector(
                  //     onTap: (){
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder:(context) => ProductPage( productId: document.id,)
                  //           )
                  //       );
                  //     },
                  //     child: FutureBuilder(
                  //       future: _productRef.doc(document.id).get(),
                  //       builder: (context,productSnap){
                  //         if(productSnap.hasError){
                  //           return Container(
                  //             child: Center(
                  //               child: Text("${productSnap.error}"),
                  //             ),
                  //           );
                  //           }
                  //           if( productSnap.connectionState == ConnectionState.done){
                  //             Map _productMap = productSnap.data.data();
                  //             return Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(8.0),
                  //                 child: Container(
                  //                   width: 200,
                  //                   height: 100,
                  //                   color: Colors.white,
                  //                   child: Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //   width: 90,
                  //   height: 90,
                  //   child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   child: Image.network(
                  //   "${_productMap['image'][0]}",
                  //   fit: BoxFit.cover,),
                  //   ),
                  //   ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(8),
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //               color: Colors.white,
                  //               height: 90,
                  //               width:175,
                  //               alignment: Alignment.center,
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Column(
                  //                       children: [
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(8.0),
                  //                           child: Container(
                  //                             color: Colors.green,
                  //                             child: Text("${_productMap['name']}",),
                  //                             ),
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(8.0),
                  //                           child: Container(
                  //                             color: Colors.green,
                  //                             child: Text("Price: Rs ${_productMap['Price']} per kg"),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                 ),
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.all(12.0),
                  //               child: GestureDetector(
                  //                  onTap: deleteProduct,
                  //                 child: Container(
                  //                   height: 50.0,
                  //                   width: 50.0,
                  //                   decoration: BoxDecoration(
                  //                     color: Colors.red,
                  //                     borderRadius: BorderRadius.circular(12.0),
                  //                   ),
                  //                   alignment: Alignment.center,
                  //                   child: Icon(
                  //                     Icons.delete_outline_sharp,
                  //                     size: 50 ,
                  //                     color:Colors.white ,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  //   ),
                  //                 ),
                  //               ),
                  //             );
                  //           }
                  //           return Container (
                  //           child: Center(
                  //           child: CircularProgressIndicator(),
                  //           ),
                  //           );
                  //       },
                  //     ),
                  //   );
                  // }).toList(),


                                    ]
                              ))))));
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
      )
    );
  }
}
