import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// [Themelist] インスタンスにおける処理。
class Home extends StatelessWidget {

  final String user_id;
  final FirebaseAuth auth;

  Home({Key key, this.user_id, this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const List<String> _popmenu_list = ["テスト", "ログアウト"];

    return Scaffold(

      // Header部分
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('ログイン後の画面'),
        backgroundColor: Colors.black87,
        centerTitle: true,
        elevation: 0.0,

        // 右上メニューボタン
        actions:  <Widget>[
                // overflow menu
                PopupMenuButton<String>(
                  icon: Icon(Icons.menu),
                  onSelected: (String s) {

                    if(s == 'ログアウト'){
                      auth.signOut();
                      Navigator.of(context).pushNamed("/login");
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