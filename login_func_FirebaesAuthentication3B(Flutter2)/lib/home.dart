import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// [Themelist] インスタンスにおける処理。
class Home extends StatelessWidget {
  final String? user_id;
  final FirebaseAuth? auth;

  Home({Key? key, this.user_id, this.auth}) : super(key: key);

  // 前画面から受け取った値はNull許容のため、入れ直し用の変数を用意
  late String _user_id;

  // 新規追加ダイアログ用の入力文字の受け取り用変数
  var _roomnameController = TextEditingController();

  // 共有コードダイアログ用の入力文字の受け取り用変数
  var _sharecodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _user_id = user_id ?? 'ログインユーザー名取得失敗';

    const List<String> _popmenu_list = ["テスト", "ログアウト"];

    return Scaffold(
      // Header部分
      appBar: AppBar(
        // leading: Icon(Icons.home),
        title: Text('ページタイトル'),
        backgroundColor: Colors.black87,
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,

        // 右上メニューボタン
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<String>(
            icon: Icon(Icons.menu),
            onSelected: (String s) {
              if (s == 'ログアウト') {
                auth!.signOut();

                // Navigator.of(context).pushNamed("/login");
                Navigator.of(context).popUntil((route) => route.isFirst);
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
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
            child: Text('ようこそ！',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 300.0,
            height: 40.0,
            child: ElevatedButton(
                // ボタンの形状や背景色など
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background-color
                  onPrimary: Colors.white, //text-color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('ボタン１'),

                // ボタン１の処理内容（ポップアップを出し、何かを入力させる。）
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        child:
                        return AlertDialog(
                          title: Text('ダイアログ　タイトル'),
                          content: TextField(
                            //controller: dateTextController,
                            decoration: InputDecoration(
                              hintText: '入力項目１',
                            ),
                            autofocus: true,
                            // keyboardType: TextInputType.number,
                            controller: _roomnameController,
                          ),
                          actions: <Widget>[
                            TextButton(
                                child: Text('キャンセル'),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  print(_roomnameController);
                                }),
                          ],
                        );
                      });
                }),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
            child: Text('または'),
          ),
          SizedBox(
            width: 300.0,
            height: 40.0,
            child: ElevatedButton(
                // ボタンの形状や背景色など
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // background-color
                  onPrimary: Colors.white, //text-color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('ボタン２'),
                // ボタン２の処理内容（ポップアップを出し、何かを入力させる。）
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        child:
                        return AlertDialog(
                          title: Text('ダイアログ　タイトル'),
                          content: TextField(
                            //controller: dateTextController,
                            decoration: InputDecoration(
                              hintText: '入力項目２',
                            ),
                            autofocus: true,
                            // keyboardType: TextInputType.number,
                            controller: _roomnameController,
                          ),
                          actions: <Widget>[
                            TextButton(
                                child: Text('キャンセル'),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  print(_roomnameController);
                                }),
                          ],
                        );
                      });
                }),
          ),
        ]),
      ),
    );
  }
}
