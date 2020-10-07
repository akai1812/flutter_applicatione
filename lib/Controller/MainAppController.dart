import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Model/FirebaseHelper.dart';
import 'package:flutter_app/Controller/MessagesController.dart';
import 'package:flutter_app/Controller/ProfileController.dart';
import 'package:flutter_app/Controller/ContactController.dart';
import 'package:flutter/cupertino.dart';

class MainAppController extends StatefulWidget {
  MainAppState createState() => new MainAppState();
}



class MainAppState extends State<MainAppController> {

  String id;



  User user = FirebaseHelper().auth.currentUser;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    FirebaseHelper().myId().then((uid){
      setState((){
        id = uid;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    Text title = new Text("Flutter Chat");

          if (user != null) {
            if(Theme.of(context).platform == TargetPlatform.iOS){
              return new CupertinoTabScaffold(
                tabBar: new CupertinoTabBar(
                  backgroundColor: Colors.blue,
                    activeColor: Colors.black,
                    inactiveColor: Colors.white,

                    items: [
                  new BottomNavigationBarItem(icon: new Icon(Icons.message),),
                  new BottomNavigationBarItem(icon: new Icon(Icons.supervisor_account),),
                  new BottomNavigationBarItem(icon: new Icon(Icons.account_circle),),
                  ]),
                tabBuilder: (BuildContext context, int index) {
                  Widget controllerSelected = controllers()[index];
                  return new Scaffold(
                    appBar: new AppBar(title: title,),
                    body: controllerSelected,
                  );

                }
              );

            }else{
              return new DefaultTabController(
                length: 3,
                child: new Scaffold(
                  appBar: new AppBar(
                    title: title,
                    bottom: new TabBar(tabs: [
                      new Tab(icon: new Icon(Icons.message),),
                      new Tab(icon: new Icon(Icons.supervisor_account),),
                      new Tab(icon: new Icon(Icons.account_circle),),
                    ]),
                  ),
                  body: new TabBarView(
                      children: controllers()
                  ),
                )
              );
            }

          } else {
            // retourne Widget chargement

            return new Scaffold(
              appBar: new AppBar(
                title: title),
              body: new Center(
                child: new Text(
                  "Chargement...",
                  style: new TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  ),
                ),
              ),
            );

        };
  }

List<Widget> controllers(){
  return [
    new MessagesController(id),
    new ContactController(id),
    new ProfileController(id),


  ];

  }
}