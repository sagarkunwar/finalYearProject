import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokari/Page/Items.dart';
import 'package:tokari/Services/product_page.dart';


class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home',textAlign: TextAlign.center,),
        backgroundColor: Color(0xFFA2CC08)
      ),
      body: Container(
        child: ListView(
          children: [

            LimitedBox(
              maxHeight: 300,
              child: PageView(
                children: [
                  AdsSlideCard(
                    slideImage: ("assets/images/poster.png"),
                  ),
                  AdsSlideCard(
                    slideImage: ("assets/images/poster1.png"),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount:4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Menuboard(
                  IconImage:"assets/images/vegetable.png", name:"Vegetable",
                ),
                Menuboard(
                  IconImage:"assets/images/fruit.png" , name:"Fruit" ,
                ),
                Menuboard(
                  IconImage:"assets/images/dairy.png" , name: "Dairy ",
                ),
                Menuboard(
                  IconImage: "assets/images/sale.png", name:" Sale" ,
                )
              ],
            ),
          ),
          AdsView(),
          ],
        ),
      ),
    );
  }
}
//image Slider class
class AdsSlideCard extends StatelessWidget {
  final String slideImage;
  AdsSlideCard({this.slideImage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 200,
          child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(slideImage,fit: BoxFit.cover,)),
        ),
      ),
    );
  }
}
class Menuboard extends StatelessWidget {
  final String IconImage;
  final String name;

  Menuboard({this.name,this.IconImage,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> itempage()));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 60,
                  height: 50,
                  child: Image.asset(IconImage,fit: BoxFit.cover,)),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(name,
                style: TextStyle(fontSize:16,fontWeight: FontWeight.bold, color: Color(0xFFA2CC08)),),
            ),
          ],
        ),
      ),
    );
  }
}
class AdsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            Container(
              child: Image.asset("assets/images/poster1.png"),
            ),
          ],
        ),
      ),
    );
  }
}
