import 'package:flutter/material.dart';

import 'Page/Cart.dart';
import 'Page/CartProduct.dart';
import 'Page/Items.dart';
import 'Page/Profile.dart';
import 'Page/Search.dart';
import 'Page/homepage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentTab = 0 ;

  // @override
  // void initState(){
  //   super.initState();
  //
  //   currentTab = 0;
  // }
  final List<Widget> screens= [
    CartScreen(),
    itempage(),
    ProfileScreen(),
    Searchscreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = homepage();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search ),
        onPressed: (){
          setState(() {
            currentScreen= Searchscreen();
          });
        },
        backgroundColor:Color(0xFFA2CC08),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth: 40,
                      onPressed: (){
                        setState(() {
                          currentTab = 0;
                          currentScreen = homepage();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: currentTab==0? Color(0xFFA2CC08): Colors.lightGreen[200],
                          ),
                          Text(
                            'Home',
                            style: TextStyle(color: currentTab == 0 ? Color(0xFFA2CC08):Colors.lightGreen[200]
                            ),
                          )
                        ],
                      ) ,
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentTab = 0;
                        currentScreen = itempage();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: currentTab==0? Color(0xFFA2CC08): Colors.lightGreen[200],
                        ),
                        Text(
                          'Items',
                          style: TextStyle(color: currentTab == 0 ? Color(0xFFA2CC08):Colors.lightGreen[200]
                          ),
                        )
                      ],
                    ) ,
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentTab = 0;
                        currentScreen = CardProduct();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_basket,
                          color: currentTab==0? Color(0xFFA2CC08): Colors.lightGreen[200],
                        ),
                        Text(
                          'Tokari',
                          style: TextStyle(color: currentTab == 0 ? Color(0xFFA2CC08):Colors.lightGreen[200]
                          ),
                        )
                      ],
                    ) ,
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentTab = 0;
                        currentScreen = ProfileScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people,
                          color: currentTab==0? Color(0xFFA2CC08): Colors.lightGreen[200],
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(color: currentTab == 0 ? Color(0xFFA2CC08):Colors.lightGreen[200]
                          ),
                        )
                      ],
                    ) ,
                  )
                ],
              )
              // Right Tab bar icons (home and items)
            ],
          ),
        ),
      ),
    );
  }
}
