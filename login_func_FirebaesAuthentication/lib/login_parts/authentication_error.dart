// Firebase Authentication利用時の日本語エラーメッセージ
class Authentication_error {

  // ログイン時の日本語エラーメッセージ
  login_error_msg(String error_code){

    String error_msg;

    if(error_code == 'ERROR_INVALID_EMAIL'){
      error_msg = '有効なメールアドレスを入力してください。';

    }else if (error_code == 'ERROR_USER_NOT_FOUND'){
      // 入力されたメールアドレスが登録されていない場合
      error_msg = 'メールアドレスかパスワードが間違っています。';

    }else if (error_code == 'ERROR_WRONG_PASSWORD'){
      // 入力されたパスワードが間違っている場合
      error_msg = 'メールアドレスかパスワードが間違っています。';

    }else if (error_code == 'error'){
      // メールアドレスかパスワードがEmpty or Nullの場合
      error_msg = 'メールアドレスとパスワードを入力してください。';

    }else{
      error_msg = error_code;
    }

    return error_msg; 
  }


  // アカウント登録時の日本語エラーメッセージ
  register_error_msg(String error_code){

    String error_msg;

    if(error_code == 'ERROR_INVALID_EMAIL'){
      error_msg = '有効なメールアドレスを入力してください。';

    }else if (error_code == 'error'){
      // メールアドレスかパスワードがEmpty or Nullの場合
      error_msg = 'メールアドレスとパスワードを入力してください。';

    }else{
      error_msg = error_code;
    }

    return error_msg; 
  }

}