import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_error.dart';
import 'email_check.dart';

// アカウント登録ページ
class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // Firebase Authenticationを利用するためのインスタンス

  String _newEmail = ""; // 入力されたメールアドレス
  String _newPassword = ""; // 入力されたパスワード
  String _infoText = ""; // 登録に関する情報を表示
  bool _pswd_OK = false; // パスワードが有効な文字数を満たしているかどうか

  // エラーメッセージを日本語化するためのクラス
  final auth_error = Authentication_error_to_ja();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("アカウント作成"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 80.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 30.0), child: Text('新規アカウントの作成', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),

              // メールアドレスの入力フォーム
              Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "メールアドレス"),
                    onChanged: (String value) {
                      _newEmail = value;
                    },
                  )),

              // パスワードの入力フォーム
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
                child: TextFormField(
                    decoration: InputDecoration(labelText: "パスワード（8～20文字）"),
                    obscureText: true, // パスワードが見えないようRにする
                    maxLength: 20, // 入力可能な文字数
                    maxLengthEnforced: false, // 入力可能な文字数の制限を超える場合の挙動の制御
                    onChanged: (String value) {
                      if (value.length >= 8) {
                        _newPassword = value;
                        _pswd_OK = true;
                      } else {
                        _pswd_OK = false;
                      }
                    }),
              ),

              // 登録失敗時のエラーメッセージ
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                child: Text(
                  _infoText,
                  style: TextStyle(color: Colors.red),
                ),
              ),

              // アカウント作成のボタン配置
              SizedBox(
                width: 350.0,
                // height: 100.0,
                child: ElevatedButton(
                  // ボタンの形状や背景色など
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background-color
                    onPrimary: Colors.white, //text-color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // ボタン内の文字と書式
                  child: Text(
                    '登録',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (_pswd_OK) {
                      try {
                        // メール/パスワードでユーザー登録
                        UserCredential _result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _newEmail,
                          password: _newPassword,
                        );

                        // 登録成功
                        User _user = _result.user!; // 登録したユーザー情報
                        _user.sendEmailVerification(); // Email確認のメールを送信
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Emailcheck(email: _newEmail, pswd: _newPassword, from: 1),
                            ));
                      } catch (e) {
                        // 登録に失敗した場合
                        setState(() {
                          _infoText = auth_error.register_error_msg(e.hashCode, e.toString());
                        });
                      }
                    } else {
                      setState(() {
                        _infoText = 'パスワードは8文字以上です。';
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
