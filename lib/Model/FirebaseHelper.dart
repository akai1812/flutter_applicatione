import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {

  //Authentification
  final auth = FirebaseAuth.instance;


  Future<FirebaseUser> handleSignIn(String mail, String password) async {
    final FirebaseUser user = (await auth.signInWithEmailAndPassword(email: mail, password: password)).user;
    return user;
  }

  Future<FirebaseUser> handleCreate(String mail, String password, String prenom, String nom) async {
    final FirebaseUser user = (await auth.createUserWithEmailAndPassword(email: mail, password: password)).user;
    String uid = user.uid;
    Map<String, String> map = {
      "prenom": prenom,
      "nom": nom,
    };
    addUser(uid, map);
    return user;
    
  }

  //Database

static final base = FirebaseDatabase.instance.reference();
  final base_user = base.child("user");

  addUser(String uid, Map map){
    base_user.child(uid).set(map);
  }
}