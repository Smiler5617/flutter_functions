import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_error.dart';
import 'registration.dart';
import '../home.dart';
import 'email_check.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {

  // Firebase 認証
  final _auth = FirebaseAuth.instance;
  AuthResult _result;
  FirebaseUser _user;

  String _login_Email = "";  // 入力されたメールアドレス
  String _login_Password = "";  // 入力されたパスワード
  String _infoText = "";  // ログインに関する情報を表示

  // エラーメッセージを日本語化するためのクラス
  final auth_error = Authentication_error();

 @override
 Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                // メールアドレスの入力フォーム
                Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                  child:TextFormField(
                    decoration: InputDecoration(
                      labelText: "メールアドレス"
                    ),
                    onChanged: (String value) {
                      _login_Email = value;
                    },
                  )
                ),

                // パスワードの入力フォーム
                Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
                  child:TextFormField(
                    decoration: InputDecoration(
                      labelText: "パスワード（8～20文字）"
                    ),
                    obscureText: true,  // パスワードが見えないようRにする
                    maxLength: 20,  // 入力可能な文字数
                    maxLengthEnforced: false,  // 入力可能な文字数の制限を超える場合の挙動の制御
                    onChanged: (String value) {
                      _login_Password= value;
                    },
                  ),
                ),

                // ログイン失敗時のエラーメッセージ
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                  child:Text(_infoText,
                    style: TextStyle(color: Colors.red),),
                ),

                // ログインボタンの配置
                ButtonTheme(
                  minWidth: 350.0,
                  // height: 100.0,
                  child: RaisedButton(

                    // ボタンの形状
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    onPressed: () async {
                      try {
                        // メール/パスワードでログイン
                        _result = await _auth.signInWithEmailAndPassword(
                          email: _login_Email,
                          password: _login_Password,
                        );

                        // ログイン成功
                        _user = _result.user;    // ログインユーザーのIDを取得

                        // Email確認が済んでいる場合のみHome画面へ
                        if (_user.isEmailVerified){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(user_id: _user.uid, auth: _auth),
                            )
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Emailcheck(email: _login_Email, pswd: _login_Password ,from: 2)),
                          );
                        }

                      } catch (e) {
                        // ログインに失敗した場合
                        setState(() {
                          _infoText = auth_error.login_error_msg(e.code);
                        });
                      }
                    },

                    // ボタン内の文字や書式
                    child: Text('ログイン',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    textColor: Colors.white,
                    color: Colors.blue,
                  ),
                ),

                 // ログイン失敗時のエラーメッセージ                
                TextButton(
                  child: Text('上記メールアドレスにパスワード再設定メールを送信'),
                  onPressed: () => _auth.sendPasswordResetEmail(email: _login_Email),
                ),

              ],
            ),
        ),

        // 画面下にアカウント作成画面への遷移ボタンを配置
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:ButtonTheme(
                minWidth: 350.0,
                // height: 100.0,
                child: RaisedButton(
                  child: Text('アカウントを作成する',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  textColor: Colors.blue,
                  color: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // ボタンクリック後にアカウント作成用の画面の遷移する。
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) => Registration(),
                      ),
                    );
                  }

                ),
              ),
            ),
          ]),
    );
 }
} 