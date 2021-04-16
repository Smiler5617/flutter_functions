import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// [Themelist] インスタンスにおける処理。
class Home extends StatelessWidget {

  final String user_id;
  final GoogleSignIn google_signin;
  final FirebaseAuth auth;

  Home({Key key, this.user_id, this.google_signin, this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const List<String> _popmenu_list = ["テスト", "ログアウト"];


    return Scaffold(

      // Header部分
      appBar: AppBar(
        
      // setting botton
        leading: Icon(Icons.home),

        // text
        title: Text(
          'ログイン後の画面',
        ),

        // adding button (dummy)
        actions:  <Widget>[
                // overflow menu
                PopupMenuButton<String>(
                  icon: Icon(Icons.menu),
                  onSelected: (String s) {

                    if(s == 'ログアウト'){
                      print(s);
                      auth.signOut();
                      if(google_signin != null){
                        google_signin.signOut();
                      }

                      Navigator.of(context).pushNamed("/login");
                    } else {
                      print(s);
                    }
                  },

                  itemBuilder: (BuildContext context) {
                    return _popmenu_list.map((String s) {
                      return PopupMenuItem(
                        child: Text(s),
                        value: s,
                      );
                    }).toList();
                  },
                ),
            ],
      
        backgroundColor: Colors.black87,
        centerTitle: true,
        elevation: 0.0,
      ),


      // メイン画面
      body:Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ようこそ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(user_id),
          ],
        ),
      ),
    );
  }
}