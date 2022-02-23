
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokari/OnboardData/data.dart';

import 'Login.dart';
import 'home.dart';

void main(){
  runApp(MyApp2());
}


class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Onboarding",
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides= getSlides();
  }

  Widget pageIndexIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0 ,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ?Color(0xFFA2CC08) : Colors.lightGreen[200],
        borderRadius: BorderRadius.circular(12)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: slides.length,
          onPageChanged: (val){
          setState(() {
            currentIndex=val;
          });
          },
          itemBuilder: (context, index){
          return SliderTile(
            imageAssetPath: slides[index].getImageAssetPath(),
            title: slides[index].getTitle(),
            decs: slides[index].getDesc(),
          );
          }),
      bottomSheet: currentIndex != slides.length -1 ?
      Container(
        height: Platform.isIOS ? 70 : 60 ,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                pageController.animateToPage(slides.length -1, duration: Duration(milliseconds:200), curve: Curves.linear);
              },
              child: Text('SKIP', style: TextStyle(
                color: Color(0xFFA2CC08),
                  fontWeight: FontWeight.bold
              ),),
            ),
            Row(
              children:<Widget>[
                for(int i = 0; i < slides.length; i++) currentIndex== i ? pageIndexIndicator(true)
                    : pageIndexIndicator(false)
              ]
              
            ),
            GestureDetector(
              onTap: (){
                pageController.animateToPage(currentIndex +1 , duration: Duration(milliseconds: 200), curve: Curves.linear);
              },
              child: Text('NEXT', style: TextStyle(
                color: Color(0xFFA2CC08),
                fontWeight: FontWeight.bold
              ),),
            ),

          ],
        )
      ):
      MaterialButton(
        elevation: 0,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 20),
        onPressed: () {
           Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (_) => LoginScreen())); // psge chsnge garni yaha bata
        },
        color: Color(0xFFA2CC08),
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(60) ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Get Started',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
        textColor: Colors.white,
      )
      // Container(
      //   margin: EdgeInsets.symmetric(horizontal: 20),
      //   alignment: Alignment.center,
      //   width: MediaQuery.of(context).size.width,
      //   height: Platform.isIOS ? 70:60,
      //   color: Color(0xFFA2CC08),
      //   child: Text('GET STARTED NOW',style:TextStyle(
      //       color: Colors.white,
      //     fontWeight: FontWeight.bold
      //   ) ,),
      // ),
    );
  }
}

class SliderTile extends StatelessWidget {

  String imageAssetPath, title, decs;
  SliderTile({this.imageAssetPath, this.title, this.decs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imageAssetPath, width: MediaQuery.of(context).size.width*.9,),
          SizedBox( height: 20,),
          Text(title, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 12,),
          Text(decs, textAlign: TextAlign.center,style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16
          ),)

        ],
      ),
  
    );
  }
}

