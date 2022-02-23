import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:tokari/Login.dart';
import 'package:tokari/blocs/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Profile',textAlign:TextAlign.center),backgroundColor: Color(0xFFA2CC08)),
      body: Center(
        child: StreamBuilder<User>(
          stream: authBloc.currentUser,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            print(snapshot.data.photoURL);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(

                  backgroundImage: NetworkImage(snapshot.data.photoURL.replaceFirst('s96','s400' )),
                  radius: 100.0,
                ),
                SizedBox(height: 20.0,),
                Container(
                  alignment: Alignment.center,
                  height: 55.0,
                  width: 180,
                   decoration: BoxDecoration(
                     color: Color(0xFFA2CC08),
                     borderRadius: BorderRadius.circular(12.0),
                   ),

                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(snapshot.data.displayName,style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),),
                    ),
                ),
            SizedBox(height: 20.0,),
                Container(
                  alignment:Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFA2CC08),
                  ),
                    child: Text(snapshot.data.email, style: TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.w600),)),
                SizedBox(height: 80.0,),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width:150,
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(12),
                    color: Color(0xFFA2CC08),
                  ),
                  child: SignInButton(Buttons.Google,text:'Sign Out', onPressed:() => authBloc.logout(),
                  ),
                )
              ]
            );
          }
        )
      ),
    );
  }
}
