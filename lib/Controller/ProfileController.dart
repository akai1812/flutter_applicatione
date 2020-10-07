import 'package:flutter/material.dart';
import 'package:flutter_app/Model/User.dart';
import 'package:flutter_app/Model/FirebaseHelper.dart';


class ProfileController extends StatefulWidget {

  String id;

  ProfileController(String id) {
    this.id = id;
  }

  ProfileControllerState createState() => new ProfileControllerState();

}

class ProfileControllerState extends State<ProfileController>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseHelper().getUser(widget.id).then((user){
     print(user.prenom);
     print(user.initiales);

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("Profile"),
    );
  }
}