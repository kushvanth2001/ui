import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui/web/screens/form_screen%20copy.dart';

import '../../authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';




class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  // Future<User?> signInWithGoogle() async {
  //   try {
  //     print("hi");
  //     print("hi");
  //     final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
  //     print("5");
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //     await googleSignInAccount!.authentication;
  //     print("6");
  //     print("1");
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     print("2");
  //     final UserCredential authResult =
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     final User? user = authResult.user;
  //     print(user);
  //     print("3");
  //     return user;
  //   } catch (e) {
  //     // Handle Google Sign-In errors
  //     print(e);
  //     return null;
  //   }
  // }
  bool _isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
      setState(() {
        _isSigningIn = true;
      });

      User? user =
          await Authentication.signInWithGoogle(context: context);

      setState(() {
        _isSigningIn = false;
      });

      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => FormScreen(),
          ),
        );
      }
    }
    ,
        child: Text('SignIn with google'),
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // Button color
          onPrimary: Colors.white, // Text color
        ),

    );
  }

}

void main()  => runApp(MaterialApp(home: LoginScreen()));

