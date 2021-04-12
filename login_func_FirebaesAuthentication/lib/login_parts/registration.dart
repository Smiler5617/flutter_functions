import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_error.dart';
import '../home.dart';

// アカウント登録ページ
class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  String newEmail = "";  // 入力されたメールアドレス
  String newPassword = "";  // 入力されたパスワード
  String infoText = "";  // 登録に関する情報を表示
  bool pswd_OK;  // パスワードが有効な文字数を満たしているかどうか

  // Firebase Authenticationを利用するためのインスタンス
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthResult result;
  FirebaseUser user;

  // エラーメッセージを日本語化するためのクラス
  final auth_error = Authentication_error();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 30.0),
                  child:Text('新規アカウントの作成',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ),

                // メールアドレスの入力フォーム
                Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                  child:TextFormField(
                    decoration: InputDecoration(labelText: "メールアドレス"),
                    onChanged: (String value) {
                      newEmail = value;
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
                      if(value.length >= 8){
                        newPassword= value;
                        pswd_OK = true;
                      }else{
                        pswd_OK = false;
                      }
                    }
                  ),
                ),

                // 登録失敗時のエラーメッセージ
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                  child:Text(infoText,
                    style: TextStyle(color: Colors.red),),
                ),

                ButtonTheme(
                  minWidth: 350.0,
                  // height: 100.0,
                  child: RaisedButton(
                    child: Text('登録',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    textColor: Colors.white,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    onPressed: () async {
                      if (pswd_OK){
                      try {
                        // メール/パスワードでユーザー登録
                        result = await auth.createUserWithEmailAndPassword(
                            email: newEmail,
                            password: newPassword,
                          );

                        // 登録成功
                        // 登録したユーザー情報
                        user = result.user;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(user_id: user.uid),
                          )
                        );

                      } catch (e) {
                        // 登録に失敗した場合
                        setState(() {
                          infoText = auth_error.register_error_msg(e.code);
                        });
                      }
                      }else{
                        setState(() {
                          infoText = 'パスワードは8文字以上です。';
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
        ),
    );
  }
}