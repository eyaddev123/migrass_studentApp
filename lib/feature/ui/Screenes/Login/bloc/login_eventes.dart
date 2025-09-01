import 'package:flutter/foundation.dart';

@immutable
abstract class LoginEventes{

  const LoginEventes();
}
class code_userloginvalue extends LoginEventes
{
  final String code_user;

  const code_userloginvalue(this.code_user);
}
class mosque_codeloginvalue extends LoginEventes
{
  final String mosque_code;

  const mosque_codeloginvalue(this.mosque_code);
}
class LoginSubmitted extends LoginEventes{}