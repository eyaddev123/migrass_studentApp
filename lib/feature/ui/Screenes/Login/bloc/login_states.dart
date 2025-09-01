
enum LoginStatus { initial, submitting, success, failure }

class LoginState {
  final String  code_user;
  final String mosque_code;
  final LoginStatus status;
  final String? errorMessage;
  final String? token;

  LoginState({
    this.code_user ="" ,
    this.mosque_code ="" ,
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.token,
  });

  LoginState copyWith({
    String? code_user,
    String? mosque_code,
    LoginStatus? status,
    String? errorMessage,
    String? token,
  }) {
    return LoginState(
      code_user:  code_user  ?? this.code_user,
      mosque_code:mosque_code ?? this.mosque_code,
      status: status ?? this.status,
      errorMessage: errorMessage,
      token: token ?? this.token,
    );
  }
}

